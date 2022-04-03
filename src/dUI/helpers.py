import requests
import re

global conn_config, sel_db, notebook_hostname, database, token


def get_sqlep(token, hostname=notebook_hostname):
    apiurl = f"https://{hostname}/api/2.0/sql/endpoints"
    headers = {
        "Authorization": f"Bearer {token}"
    }
    return requests.get(apiurl, headers=headers).json()['endpoints']


def format_str(detail_dict=None):
    if detail_dict:
        return "\n".join([f'{k:<15}{str(v):>30}' for k, v in sorted(detail_dict.items())])
    else:
        return "NOTHING DOING, BOSS"


def get_jdbc(db):

    jdbc = conn_config[db]['jdbc_w'].value
    username = conn_config[db]['user_w'].value
    password = conn_config[db]['pass_w'].value
#   TODO: format generic jdbc string
    return jdbc


def get_dbsql_jdbc(ep, log_level=4):
    params = conn_config[sel_db][ep]
    hostname = params['hostname']
    httpPath = params['path']
    protocol = params['protocol']
    port = params['port']
    debug = "LogLevel=" + str(log_level) if log_level else None
    return f"jdbc:spark://{hostname}:{port}/{database};transportMode=http;ssl=1;AuthMech=3;httpPath={httpPath};AuthMech=3;UID=token;PWD={token};UseNativeQuery=1;{debug}"
