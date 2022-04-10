from __future__ import annotations

import os
from pathlib import Path
import sqlparse
from types import SimpleNamespace
from typing import NamedTuple


class Query(NamedTuple):
    name: str
    string: str


class JDBC(NamedTuple):
    string: str
    driver: str = "com.simba.spark.jdbc.Driver"
    user: str = "username"
    password: str = "password"


class ConnConfig(NamedTuple):
    parallel: int = 1
    repeats: int = 1
    timeout: int = 3000


class DBstressCfg(NamedTuple):
    yaml_path: os.PathLike = "/tmp/dbstress/config.yaml"
    result_path: os.PathLike = "/tmp/dbstress/output/"


def format_str(detail_dict=None) -> str:
    if detail_dict:
        return "\n".join([f'{k:<15}{str(v):>30}' for k, v in sorted(detail_dict.items())])
    else:
        return "NOTHING DOING HERE, BOSS"


# read in a list of sql filepaths and convert syntax and strip comments
def read_sql_files(sql_files: list(os.PathLike), info: bool = False) -> list(Query):
    named_queries = []
    for file in sql_files:
        with open(file, "r") as f:
            query_name = Path(file).stem
            generalized = sqlparse.format(
                f.read(), strip_comments=True).strip()
            named_queries.append(Query(query_name, generalized))
            if info:
                print(query_name + "\n")
                print(generalized + "\n\n")

    return named_queries


def read_sql_folder(path: os.PathLike, info: bool = False) -> list(Query):
    path = Path(path)
    sql_files = sorted(list(path.glob('./*.sql')))

    return read_sql_files(sql_files, info)


def check_dbs_cfg(dbs_cfg: DBstressCfg = DBstressCfg()) -> None:
    yaml_dir = Path(dbs_cfg.yaml_path).parent
    out_dir = Path(dbs_cfg.result_path)
    if not out_dir.is_dir() or Path(dbs_cfg.yaml_path).is_dir():
        print("yaml path is not a filename or result path is not a directory")
        print(f"yaml path: {dbs_cfg.yaml_path}")
        print(f"result path: {dbs_cfg.result_path}")
        raise ValueError
    if not os.path.exists(yaml_dir):
        print(f"Config directory {yaml_dir} does not exist")
        print(f"Creating {yaml_dir}")
        os.makedirs(yaml_dir)
    if not os.path.exists(out_dir):
        print(f"Result directory {out_dir} does not exist")
        print(f"Creating {out_dir}")
        os.makedirs(out_dir)


def yaml_str(query: Query, jdbc: JDBC, conn: ConnConfig = ConnConfig()) -> str:
    out = "---\n"
    out += f"unit_name: {query.name}\n"
    out += f'query: "/* {query.name}  @@gen_query_id@@ */\n{query.string}"\n'
    out += f'uri: "{jdbc.string}"\n'
    out += f"driver_class: {jdbc.driver}\n"
    out += f"username: {jdbc.user}\n"
    out += f"password: {jdbc.password}\n"
    out += f"parallel_connections: {conn.parallel}\n"
    out += f"repeats: {conn.repeats}\n"
    out += f"connection_timeout: {conn.timeout}\n"
    return out


def write_yaml(yamls:list[str], dbs_cfg:DBstressCfg = DBstressCfg(), info:bool = False) -> None:
    yaml_out = "".join(yamls)
    yaml_path = dbs_cfg.yaml_path

    if info:
        print(f"Writing yaml config file to: {yaml_path}")
        print(yaml_out)
        with open(yaml_path, "w") as f:
            f.write(yaml_out)
