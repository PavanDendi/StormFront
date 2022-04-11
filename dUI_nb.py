# Databricks notebook source
# MAGIC %md
# MAGIC # Dependencies
# MAGIC 
# MAGIC install `slqparse` either as a cluster library or as a notebook scoped library using `%pip install sqlparse`
# MAGIC 
# MAGIC install custom dbstress jar from https://github.com/PavanDendi/dbstress/tree/databricks
# MAGIC 
# MAGIC Compiled binary can be found in the github Releases [HERE](https://github.com/PavanDendi/dbstress/releases/download/0.0.0/dbstress-assembly-0.0.0-SNAPSHOT.jar), or compile from source using `sbt assembly`
# MAGIC 
# MAGIC Cluster must be running a DBR version that supports ipykernel.  Tested on DBR 10.4 LTS
# MAGIC 
# MAGIC Enable ipykernel by adding to cluster config
# MAGIC ```
# MAGIC spark.databricks.python.defaultPythonRepl ipykernel
# MAGIC ```

# COMMAND ----------

# DBTITLE 1,Select SQL Files to Run
from src.dUI import dUI

# dUI.start(root_path="/Users/pavan.dendi/Documents/benchit/dUI/queries")
display(dUI.start())

# COMMAND ----------

# DBTITLE 1,Select DB SQL Endpoint
from src.dUI.db_select import SQLEPConfig

# PAT token needed in order to query the workspace for DB SQL Endpoints
# See https://docs.databricks.com/dev-tools/api/latest/authentication.html
#    for instructions on how to generate a PAT
# See https://docs.databricks.com/security/secrets/index.html
#    for how to use the Secrets feature to securely store credentials
token = dbutils.secrets.get("fieldeng", "prd-pat")
ep_sel = SQLEPConfig(token)
display(ep_sel)

# COMMAND ----------

# DBTITLE 1,Test JDBC Connection and dbstress Config
from pathlib import PosixPath, Path
from src.dUI import dUI
from src.dUI.utils import *

jdbc = ep_sel.get_jdbc()
dbstress_cfg = DBstressCfg(
    yaml_path="/dbfs/tmp/dbstress/config.yaml",
    result_path="/dbfs/tmp/dbstress/output/"
)
conn_cfg = ConnConfig(
    parallel=1,
    repeats=1,
    timeout=3000
)

display(dUI.run(jdbc, [Query("test", "SELECT 1")], dbs_cfg=dbstress_cfg, conn=conn_cfg))

# COMMAND ----------

# DBTITLE 1,Run dbstress with Selected SQL files and JDBC Connection
from pathlib import Path
from src.dUI.utils import read_sql_files, ConnConfig, DBstressCfg


jdbc = ep_sel.get_jdbc()
queries = read_sql_files(dUI.get_selected(), info=True)

dbstress_cfg = DBstressCfg(
    yaml_path="/dbfs/tmp/dbstress/config.yaml",
    result_path="/dbfs/tmp/dbstress/output/"
)

conn_cfg = ConnConfig(
    parallel=1,
    repeats=1,
    timeout=3000
)

display(dUI.run(jdbc, queries, dbs_cfg=dbstress_cfg, conn=conn_cfg))
