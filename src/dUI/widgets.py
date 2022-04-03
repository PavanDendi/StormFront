import ipywidgets as w
# import IPython
from helpers import *


def db_selector(default_db="DB SQL"):
    dblist = ["DB SQL", "JDBC", "MySQL", "Synapse", "Snowflake"]
    return w.Select(
        options=dblist,
        value=default_db,
        layout=w.Layout(width='20em', height='11em'),
        description="Select DB:"
    )


def sqlep_selector(config=None):
    global token, debug, conn_config
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
    global container, conn_selectors, conn_selector_map, db_sel
    debug.value += "\nchange_conn_selector: " + db
    selector = conn_selectors.get(db, conn_selector_map.get(
        db, jdbc_selector)(conn_config.get(db, {"db": db})))
    debug.value += "\ndb before adding: " + db
    conn_selectors[db] = selector
    container.children = [db_sel, selector]
