# Databricks notebook source
import ipywidgets as w
from src.dUI.sql_select import StateSingleton

debug_ext = StateSingleton().debug
display(debug_ext)

# COMMAND ----------

from src.dUI import dUI

# dUI.start(root_path="/Users/pavan.dendi/Documents/benchit/dUI/queries",debug_ext=debug_ext)
display(dUI.start())

# COMMAND ----------

selected_sql = dUI.get_selected()
# yaml_path = "/dbfs/dbstress/configs/test_config_2.yaml"
# result_path = "/dbfs/dbstress/output/"
selected_sql

# COMMAND ----------

from src.dUI.db_select import container

token = dbutils.secrets.get("fieldeng", "prd-pat")

# hostname for workspace to query for DBSQL endpoints
# default is to use current notebook's workspace
# hostname = "adb-984752964297111.11.azuredatabricks.net"

display(container)

# COMMAND ----------

# MAGIC %scala
# MAGIC 
# MAGIC import java.sql.DriverManager
# MAGIC 
# MAGIC DriverManager.registerDriver(new com.simba.spark.jdbc.Driver())
