import json
import sys
from collections import namedtuple
from pyspark.sql import SparkSession

spark = SparkSession.getActiveSession()

DBR = True if 'dbruntime' in sys.modules else False
if DBR:
    from pyspark.dbutils import DBUtils
    dbutils = DBUtils.get_dbutils(DBUtils, spark)
    CONTEXT_RAW = json.loads(
        dbutils.notebook.entry_point.getDbutils().notebook().getContext().toJson()
    )['tags'] if DBR else {}
else:
    CONTEXT_RAW = {}

CONTEXT = namedtuple("CONTEXT", ["DBR", "user", "host"])(
    DBR,
    CONTEXT_RAW.get("user", "local.user"),
    CONTEXT_RAW.get("browserHostName", "127.0.0.1")
)
