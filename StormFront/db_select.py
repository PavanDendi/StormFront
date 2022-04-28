import ipywidgets as w
from . import CONTEXT
from .utils import get_sql_eps, JDBC


class DBStateSingleton(object):
    _instance = None
    debug = w.Textarea(layout=w.Layout(width="100%", height="10em"))

    def __new__(cls, debug_ext: w.Textarea = None):
        if cls._instance == None:
            # print("Creating DB state singleton")
            # print(f"received args: debug: {debug_ext}")
            cls._instance = super().__new__(cls)
            cls._instance.debug = debug_ext if debug_ext else cls._instance.debug
            cls._instance.debug.value = "[db_state] DB state start"
            # cls._instance.jdbc_conn = {}

            cls._instance.db_sel = DBListSingleton()
            # cls._instance.file_tabs = TabsWidgetSingleton()
        return cls._instance


class DBListSingleton(w.VBox):
    _instance = None

    def __new__(cls):
        if cls._instance == None:
            # print("Creating DB list singleton")
            cls._instance = super().__new__(cls)
            cls._instance.debug.value = "[db_list] DB select start"
            cls._instance.dblist = []
            cls._instance.db_sel = w.Select(
                options=cls._instance.dblist,
                # value=default_db,
                layout=w.Layout(width='20em', height='11em'),
                description="Select DB:"
            )
            # cls._instance.file_tabs = TabsWidgetSingleton()
            # cls._instance.
        return cls._instance


class SQLEPConfig(w.HBox):

    def __init__(self, token: str, host: str = CONTEXT.host, ws_name: str = "current"):

        self.name = f"DB SQL [{ws_name}]"
        self.eps = get_sql_eps(token, host)
        self.ep_names = list(self.eps.keys())
        default_ep = None if len(self.ep_names) == 0 else self.ep_names[0]
        self.ep_list = w.Select(
            options=self.ep_names,
            value=None if len(self.ep_names) == 0 else self.ep_names[0],
            layout=w.Layout(width='300px', height='11em'),
            description="Select Endpoint:",
            style={'description_width': 'initial'}
        )
        self.default_db = w.Text(
            value="",
            description="Database: ",
            placeholder="default",
            layout=w.Layout(width="300px"),
            style={"description_width": "initial"}
        )
        self.ep_select = w.VBox(
            (self.ep_list, self.default_db),
            # layout=w.Layout(width='400px')
        )
        self.ep_details = w.Textarea(
            value=self.eps.get(default_ep).format_str,
            disabled=True,
            layout=w.Layout(width="400px", height="100%")
        )
        self.ep_list.observe(self._on_val, names="value")
        super().__init__([self.ep_select, self.ep_details],
                         layout=w.Layout(width='100%', height="20em"))

    def _on_val(self, change):
        new_ep = change['new']
        # debug.value += "\nnew_ep: " + new_ep
        self.ep_details.value = self.eps.get(new_ep).format_str

    def get_jdbc(self, log_level=None) -> JDBC:
        value = self.default_db.value
        default_val = self.default_db.placeholder
        database = value if value != "" else default_val
        sel_ep = self.ep_list.value
        log_level = f";LogLevel={log_level}" if log_level else ""
        jdbc = self.eps[sel_ep].odbc_params.string.replace(
            '{database}', database) + log_level
        return JDBC(jdbc)


# def jdbc_selector(config=None):
#     container = w.VBox(layout=w.Layout(width='100%'))
#     jdbc_init = "jdbc:db://..."
#     jdbc_value = config.get("jdbc_str", None) if config else None
#     jdbc = w.Text(
#         value=jdbc_value,
#         placeholder=jdbc_init,
#         layout=w.Layout(width='50em'),
#         description="JDBC String"
#     )
#     username = w.Text(
#         description="Username"
#     )
#     password = w.Password(
#         description="Password"
#     )
#     db = config.get("db", None)
#     if db:
#         conn_config.update({db: {}})
#         conn_config[db]['jdbc_w'] = jdbc
#         conn_config[db]['user_w'] = username
#         conn_config[db]['pass_w'] = password
#     container.children = [jdbc, username, password]
#     return container

# conn_selectors = {}
# conn_selector_map = {
#     "DB SQL": sqlep_selector,
#     "JDBC": jdbc_selector
# }

# def on_dbtype_change(change):
#     new_db = change['new']
#     # debug.value = "on_db_change: " + new_db
#     change_conn_selector(new_db)


# def change_conn_selector(db, config):
#     global conn_config, container, conn_selectors, conn_selector_map
#     config = conn_config
#     # debug.value += "\nchange_conn_selector: " + db
#     selector = conn_selectors.get(db, conn_selector_map.get(
#         db, jdbc_selector)(config.get(db, {"db": db})))
#     # debug.value += "\ndb before adding: " + db
#     conn_selectors[db] = selector
#     container.children = [db_sel, selector]
