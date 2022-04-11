# How to Use This Repo

dUI is a notebook front end for the dbstress concurrency benchmarking tool.  It lets the user send multiple queries to a JDBC SQL endpoint without having to navigate too much code or manually edit config files.

dUI is meant to run in a Databricks workspace, and uses `ipywidgets` to generate the UI.

Clone this repo into your Databricks Workspace and open `dUI_nb.py`.  Run each cell one by one to select which sql files to run and which SQL endpoint to query.

# Dependencies

Install custom dbstress jar from https://github.com/PavanDendi/dbstress/tree/databricks to your cluster.

Compiled binary can be found in the github Releases [HERE](https://github.com/PavanDendi/dbstress/releases/download/0.0.0/dbstress-assembly-0.0.0-SNAPSHOT.jar), or compile from source using `sbt assembly` from the dbstress repo root directory.

Cluster can be a single node using a weak instance type since the cluster will only be sending API calls, and processing minimal data itself.

Cluster must be running a DBR version that supports ipykernel. Tested on DBR 10.4 LTS

Enable ipykernel by adding to cluster config
```
spark.databricks.python.defaultPythonRepl ipykernel
```
