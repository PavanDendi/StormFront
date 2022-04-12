from __future__ import annotations

from pathlib import Path
import ipywidgets as w
from pyspark.sql import DataFrame
from . import spark, sc
from .utils import *


def start(root_path=None, show_debug=False, debug_ext=None):
    """
    root_path:  start app using a different root than default
                default path is /Workspace/Repos/{username}/dUI/queries

    show_debug: show debug messages above app

    debug_ext:  widget to use instead of internal text widget
                this is useful if you want a larger debug output at a different cell
                app widgets post messages by appending to debug_w.value
    """
    from .sql_select import StateSingleton

    if debug_ext:
        state = StateSingleton(debug_ext)
    else:
        state = StateSingleton()

    state.change_root(root_path)

    path_select = state.path_select
    dir_select = state.dir_select
    file_tabs = state.file_tabs

    sql_select = w.HBox([dir_select, file_tabs])
    if show_debug:
        return w.VBox([state.debug, path_select, sql_select])
    else:
        return w.VBox([path_select, sql_select])


def get_selected() -> list[os.PathLike]:
    from .sql_select import StateSingleton

    state = StateSingleton()
    sel_files = []
    for (p, dt) in state.dirtabs.items():
        sel_files += [p / Path(f.description)
                      for f in dt.clist.checklist if f.value]
    return sel_files


def run(jdbc: JDBC,
        queries: list[Query],
        dbs_cfg: DBstressCfg = DBstressCfg(),
        conn: ConnConfig = ConnConfig()) -> DataFrame:

    check_dbs_cfg(dbs_cfg)
    yaml_out = [yaml_str(q, jdbc, conn) for q in queries]
    write_yaml(yaml_out, dbs_cfg, info=True)

    def toJStringArray(arr):
        jarr = sc._gateway.new_array(sc._jvm.java.lang.String, len(arr))
        for i in range(len(arr)):
            jarr[i] = arr[i]
        return jarr

    args = toJStringArray(["-c", dbs_cfg.yaml_path, "-o", dbs_cfg.result_path])

    spark._jvm.eu.semberal.dbstress.Main.main(args)

    dbfs_dir = list(Path(dbs_cfg.result_path).parts)
    dbfs_dir.pop(1)
    dbfs_dir = str(Path(*dbfs_dir))

    return spark.read.option("header", True).option("InferSchema", True).csv(dbfs_dir)
