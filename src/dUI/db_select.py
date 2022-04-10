# Databricks notebook source
# import json
# import os,glob,sys
import requests
import ipywidgets as w
from .sql_select import CONTEXT
from .utils import *


def db_selector(default_db="DB SQL"):
    dblist = ["DB SQL", "JDBC"]
    return w.Select(
        options=dblist,
        value=default_db,
        layout=w.Layout(width='20em', height='11em'),
        description="Select DB:"
    )


def get_sqlep(token, hostname=None):

    if hostname:
        apiurl = f"https://{hostname}/api/2.0/sql/endpoints"
    else:
        apiurl = f"https://{CONTEXT.host}/api/2.0/sql/endpoints"
    headers = {
        "Authorization": f"Bearer {token}"
    }
    return requests.get(apiurl, headers=headers).json()['endpoints']


def sqlep_selector(token, config=None):
    endpoints = get_sqlep(token)
    ep_dict = {ep['name']: ep for ep in endpoints}
    ep_names = sorted(ep_dict.keys())
    key_map = {
        "cluster_size": "Size",
        "enable_photon": "Photon",
        "creator_name": "Creator",
        "enable_serverless_compute": "Serverless",
        "min_num_clusters": "Min clusters",
        "max_num_clusters": "Max clusters",
        "state": "State",
        "id": "ID"
    }
    filtered_ep = {ep: {v: details[k] for k, v in key_map.items()}
                   for ep, details in ep_dict.items()}

    default_ep = None if len(ep_names) == 0 else ep_names[0]
    sel_ep = w.Select(
        options=ep_names,
        value=default_ep,
        layout=w.Layout(width='25em', height='11em'),
        description="Select Endpoint:",
        style={'description_width': 'initial'}
    )
    show_details = w.Textarea(
        value=format_str(filtered_ep.get(default_ep, None)),
        disabled=True,
        layout=w.Layout(width='100%', height='11em')
    )

    def on_val(change):
        new_ep = change['new']
        debug.value += "\nnew_ep: " + new_ep
        show_details.value = format_str(filtered_ep[new_ep])

    sel_ep.observe(on_val, names='value')
    container = w.HBox(layout=w.Layout(width='100%'))
    container.children = [sel_ep, show_details]

    db = config.get("db", None)
    if db:
        conn_config.update({db: {}})
        conn_config[db]['sel_ep_w'] = sel_ep
        conn_config[db]['ep_resp'] = endpoints
        for name in ep_names:
            conn_config[db].update({name: ep_dict[name]['odbc_params']})

    return container


def jdbc_selector(config=None):
    container = w.VBox(layout=w.Layout(width='100%'))
    jdbc_init = "jdbc:db://..."
    jdbc_value = config.get("jdbc_str", None) if config else None
    jdbc = w.Text(
        value=jdbc_value,
        placeholder=jdbc_init,
        layout=w.Layout(width='50em'),
        description="JDBC String"
    )
    username = w.Text(
        description="Username"
    )
    password = w.Password(
        description="Password"
    )
    db = config.get("db", None)
    if db:
        conn_config.update({db: {}})
        conn_config[db]['jdbc_w'] = jdbc
        conn_config[db]['user_w'] = username
        conn_config[db]['pass_w'] = password
    container.children = [jdbc, username, password]
    return container


def on_dbtype_change(change):
    new_db = change['new']
    debug.value = "on_db_change: " + new_db
    change_conn_selector(new_db)


def change_conn_selector(db):
    debug.value += "\nchange_conn_selector: " + db
    selector = conn_selectors.get(db, conn_selector_map.get(
        db, jdbc_selector)(conn_config.get(db, {"db": db})))
    debug.value += "\ndb before adding: " + db
    conn_selectors[db] = selector
    container.children = [db_sel, selector]


debug_w = w.VBox()
container = w.HBox()
debug = w.Textarea(layout=w.Layout(height="11em"))
debug_w.children = [debug, container]

db_sel = db_selector()
db_sel.observe(on_dbtype_change, names="value")

conn_selectors = {}
conn_selector_map = {
    "DB SQL": sqlep_selector,
    "JDBC": jdbc_selector
}
conn_config = {}

curr_db = db_sel.value
change_conn_selector(curr_db)



def get_jdbc(db):

    jdbc = conn_config[db]['jdbc_w'].value
    username = conn_config[db]['user_w'].value
    password = conn_config[db]['pass_w'].value
#   TODO: format generic jdbc string
    return jdbc


def get_dbsql_jdbc(ep, database="default", log_level=4):
    params = conn_config[sel_db][ep]
    hostname = params['hostname']
    httpPath = params['path']
    protocol = params['protocol']
    port = params['port']
    debug = ";LogLevel=" + str(log_level) if log_level else ""
    return f"jdbc:spark://{hostname}:{port}/{database};transportMode=http;ssl=1;AuthMech=3;httpPath={httpPath};AuthMech=3;UID=token;PWD={token};UseNativeQuery=1{debug}"


sel_db = db_sel.value

if sel_db == "DB SQL":
    sel_conn = conn_selectors[sel_db]
    sel_ep = sel_conn.children[0].value
    jdbc = get_dbsql_jdbc(sel_ep)
else:
    jdbc = get_jdbc(sel_db)

# TODO: figure out driver class selection
driver_class = "com.simba.spark.jdbc.Driver"

# COMMAND ----------

# get_dbsql_jdbc("Shared Endpoint")

# COMMAND ----------

# import uuid
# from IPython.display import display_javascript, display_html, display
# import json

# class RenderJSON(object):
#     def __init__(self, json_data):
#         if isinstance(json_data, dict):
#             self.json_str = json.dumps(json_data)
#         else:
#             self.json_str = json
#         self.uuid = str(uuid.uuid4())

#     def _ipython_display_(self):
#         IPython.display_html('<div id="{}" style="height: 600px; width:100%;"></div>'.format(self.uuid),
#             raw=True
#         )
#         IPython.display_javascript("""
#         function() {
#           document.getElementById('%s').appendChild(renderjson(%s))
#         };
#         """ % (self.uuid, self.json_str), raw=True)

# COMMAND ----------

# import pandas as pd

# pd.DataFrame.from_dict(ep_dict[names[0]])
# IPython.display.JSON(ep_dict[names[0]])
# from IPython.lib.pretty import pretty
# IPython.display.display(pretty(ep_dict[names[0]]))

# pprint(ep_dict[names[0]])

# COMMAND ----------

# MAGIC %%HTML
# MAGIC <script src="https://rawgit.com/caldwell/renderjson/master/renderjson.js"></script>

# COMMAND ----------

# from ipywidgets import embed

# help(embed)

# COMMAND ----------
