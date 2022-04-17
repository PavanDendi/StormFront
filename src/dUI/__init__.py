import json
import sys
from collections import namedtuple
from pyspark.sql import SparkSession
from pyspark.context import SparkContext

spark = SparkSession.getActiveSession()
sc = SparkContext.getOrCreate()

DBR = True if 'dbruntime' in sys.modules else False
if DBR:
    from pyspark.dbutils import DBUtils
    dbutils = DBUtils.get_dbutils(DBUtils, spark)
    CONTEXT_RAW = json.loads(
        dbutils.notebook.entry_point.getDbutils().notebook().getContext().toJson()
    )
else:
    CONTEXT_RAW = {}

CONTEXT = namedtuple("CONTEXT", ["DBR", "user", "host"])(
    DBR,
    CONTEXT_RAW.get('tags', {}).get("user", "local.user"),
    CONTEXT_RAW.get('extraContext', {}).get("api_url", "127.0.0.1")
)
