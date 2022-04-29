from __future__ import annotations

import json
import os
import sys
from pathlib import Path
from pprint import pformat, pprint
from typing import NamedTuple
import datetime

import ipywidgets as w
from . import CONTEXT


class PathSelect(NamedTuple):
    path: os.PathLike = None
    selected: bool = False


class DirSelectRow(w.HBox):

    def __init__(self, dir: PathSelect):
        self.state = StateSingleton()
        self.debug = self.state.debug
        self.path = Path(dir.path)
        self.selected = dir.selected
        self.dir_b = w.Button(
            # value=self.selected,
            disabled=True,
            description=self.path.name,
            icon='folder-open' if self.path==self.state.root else 'folder',
            button_style='',  # 'success', 'info', 'warning', 'danger' or ''
            layout=w.Layout(width="100%"),
            style={'description_width': 'initial'},
        )
        # self.dir_b.observe(self.__on_toggle__, names="value")

        self.all_b = w.Button(description="All", layout=w.Layout(width="4em"))
        self.all_b.on_click(self.__on_click__)

        self.none_b = w.Button(
            description="None", layout=w.Layout(width="8em"), style={'description_width': 'initial'})
        self.none_b.on_click(self.__on_click__)

        super().__init__([self.dir_b, self.all_b, self.none_b])

    # def __on_toggle__(self, change):
    #     self.debug.value += f"\n{datetime.datetime.now()}[DirRow] '{self.path.name}' received: {pformat(change)}"
    #     # self.dir_b.icon = 'folder-open' if self.dir_b.value else 'folder'
    #     # self.selected = self.dir_b.value
    #     self.state.update_tabs(change)

    def __on_click__(self, change):
        self.debug.value += f"\n[DirRow] '{self.path.name}' click: {pformat(change)}"
        # test = self.state.dirtabs.keys()
        files = self.state.dirtabs.get(self.path).clist.children
        # self.debug.value += f"\n[DirRow] '{self.path}' dirtabs: {pformat(files)}"

        # index = list(self.state.dirtabs.keys()).index(self.path.name)
        index = list(self.state.dirtabs.keys()).index(self.path)
        self.debug.value += f"\n[DirRow] '{self.path}' tab index: {pformat(index)}"
        self.state.file_tabs.selected_index = index

        select_all = {"All": True, "None": False}.get(change.description)
        for f in files:
            f.value = select_all
        # if change.description == "All":
        #     # self.dir_b.value = True
        #     # self.selected = True
        #     for file in files:
        #         file.value = True
        # elif change.description == "None":
        #     for file in files:
        #         file.value = False
        # self.state.update_tabs(change, self.path)



class FileCheckList(w.VBox):

    def __init__(self, files: list[PathSelect] = []):
        self.state = StateSingleton()
        self.debug = self.state.debug
        self.checklist = [w.Checkbox(
            description=Path(file.path).name,
            value=file.selected,
            indent=False,
        ) for file in files]
        [file.observe(self.__on_select__) for file in self.checklist]
        self.selected = [
            file.description for file in self.checklist if file.value]
        super().__init__(self.checklist)
        # layout=w.Layout(grid_template_columns="repeat(3, 100px)")

    def __on_select__(self, change):
        self.debug.value += f"\n[FileList] received event: {pformat(change)}"
        # TODO: maybe change to do append() and pop()
        self.selected = [
            file.description for file in self.checklist if file.value]


class DirTab(NamedTuple):
    dir_sel: DirSelectRow
    clist: FileCheckList


class StateSingleton(object):
    _instance = None
    default_root = f'/Workspace/User/{CONTEXT.user}/' if CONTEXT.DBR else os.getcwd()
    debug = w.Textarea(layout=w.Layout(width="100%", height="10em"))

    @staticmethod
    def _ls_sql(path: os.PathLike, selectAll: bool = False) -> FileCheckList:
        path = Path(path).resolve()
        sql_paths = sorted(list(path.glob('./*.sql')))
        return FileCheckList([PathSelect(p.name, selectAll) for p in sql_paths])

    @staticmethod
    def _ls_dirs(path: os.PathLike) -> list[DirSelectRow]:
        path = Path(path).resolve()
        paths = [PathSelect(path, True)] + \
            sorted(PathSelect(d) for d in path.iterdir() if d.is_dir())
        return [DirSelectRow(p) for p in paths]

    def __new__(cls, debug_ext: w.Textarea = None):
        if cls._instance == None:
            # print("Creating state singleton")
            # print(f"received args: debug: {debug_ext}")
            cls._instance = super().__new__(cls)
            cls._instance.debug = debug_ext if debug_ext else cls._instance.debug
            cls._instance.debug.value = "[state] state start"
            cls._instance.root = Path(cls.default_root).resolve()
            cls._instance.dirtabs = {}

            cls._instance.path_select = PathSelectSingleton()
            cls._instance.path_select.setup()
            cls._instance.dir_select = DirSelectSingleton()
            cls._instance.file_tabs = TabsWidgetSingleton()
        return cls._instance

    def change_root(self, new_root: str = None) -> None:
        old_root = Path(self.root).resolve() # if self.root else Path(  // not needed since set in new
            # self.default_root).resolve()
        new_root = Path(new_root).resolve() if new_root else old_root
        new_dirs = self._ls_dirs(new_root)
        self.debug.value += f"\n{datetime.datetime.now()}[state][change_root] old: {old_root}  new: {new_root}"
        # TODO: implement root_dir and dirtab cache

        # check if new root is actually new or sub dirs have changed
        if (old_root != new_root) or (len(self.dirtabs) != len(new_dirs)):
            self.root = new_root
            # update path_select widget to start arg; this should only happen once when state singleton is created
            # Is this needed?
            # val = self.path_select.path_t.value
            # self.debug.value += f"\n{datetime.datetime.now()}[state][change_root] updating path_select: {val} -> {self.root}"
            # self.debug.value += f"\n{datetime.datetime.now()}[state][change_root] len(dirtabs): {len(self.dirtabs)}  len(new_dirs): {len(new_dirs)}"
            # if val == "":
            #     self.path_select.path_t.value = str(self.root)

            self.dirtabs = {}
            for d in self._ls_dirs(self.root):
                clist = self._ls_sql(d.path)
                dir_sel = DirSelectRow(PathSelect(d.path))
                self.dirtabs.update({d.path: DirTab(dir_sel, clist)})
            
            # self.dirtabs[self.root].dir_sel.dir_b.value = True  # why is this being executed inside for loop?

            self.debug.value += f"\n{datetime.datetime.now()}[state][change_root] changing dirs: {pformat([p.name for p in self.dirtabs.keys()])}"
            self.dir_select.children = [dt.dir_sel for dt in self.dirtabs.values()]
            self.debug.value += f"\n{datetime.datetime.now()}[state][change_root] updating tabs"
            
            tabs = [dt.clist for dt in self.dirtabs.values()]
            # self.debug.value += f"\n{datetime.datetime.now()}[state][update_tabs] tab children: {pformat(tabs)}"
            self.file_tabs.children = tabs
            for i, dir in enumerate(self.dirtabs.keys()):
                self.file_tabs.set_title(i, dir.name)
            
            # self.update_tabs("change_root")

    # def update_tabs(self, change, path_click: os.PathLike = None) -> None:
    #     # if path_click == None:
    #     #     if change == "change_root":
    #     #         self.debug.value += f"\n{datetime.datetime.now()}[state][update_tabs] root change"
    #     #         self.debug.value += f"\n{datetime.datetime.now()}[state][update_tabs] new dirs: {pformat([self.active_dirtabs.keys()])}"
    #     #     else:
    #     #         self.debug.value += f"\n{datetime.datetime.now()}[state][update_tabs] dir toggle"
    #     # else:
    #     #     self.debug.value += f"\n[state][update_tabs] {path_click} {pformat(change.description)} button"

    #     # dirs = list(self.dirtabs.keys())
    #     # self.active_dirtabs = {    #// comment out for now so we don't dynamically show tabs
    #     #     dt.dir_sel: dt.clist for dt in self.dirtabs.values() if dt.dir_sel.selected}
    #     self.active_dirtabs = { dt.dir_sel: dt.clist for dt in self.dirtabs.values()}
    #     children = [dt.clist for dt in self.dirtabs.values()]
    #     # children = list(self.active_dirtabs.values())
    #     self.file_tabs.children = children
    #     self.debug.value += f"\n{datetime.datetime.now()}[state][update_tabs] tab children: {pformat(children)}"
    #     self.debug.value += f"\n{datetime.datetime.now()}[state][update_tabs] setting tab titles"
    #     for i, dir in enumerate(self.active_dirtabs.keys()):
    #         self.file_tabs.set_title(i, dir.path.name)


class DirSelectSingleton(w.VBox):
    _instance = None

    def __new__(cls):
        if cls._instance == None:
            # print("[dir_select] Creating dir_select singleton")
            cls._instance = super().__new__(cls)
            cls._instance.state = StateSingleton()
            cls._instance.debug = cls._instance.state.debug
            cls._instance.layout = w.Layout(width="25em")
        return cls._instance


class TabsWidgetSingleton(w.Tab):
    _instance = None

    def __new__(cls):
        if cls._instance == None:
            # print("[file_tabs] Creating file_tabs singleton")
            cls._instance = super().__new__(cls)
            cls._instance.state = StateSingleton()
            cls._instance.debug = cls._instance.state.debug
            cls._instance.layout = w.Layout(width="100%", height="40em")
        return cls._instance


class PathSelectSingleton(w.HBox):
    _instance = None

    def __new__(cls):
        if cls._instance == None:
            # print(f"{datetime.datetime.now()}[path_select] Creating path_select singleton")
            cls._instance = super().__new__(cls)
            cls._instance.state = StateSingleton()
            cls._instance.debug = cls._instance.state.debug
            cls._instance.submit_b = w.Button(
                description="Submit",
                icon="refresh",
                button_style='primary',         # 'success', 'info', 'warning', 'danger' or ''
                layout=w.Layout(width="16em")
            )
            cls._instance.path_t = w.Text(
                value=cls._instance.state.default_root,
                layout=w.Layout(width="100%"),
                description="Queries Path: ",
                # placeholder=cls._instance.state.default_root,
                style={"description_width": "7em"}
            )
        return cls._instance

    # additional setup method to operate on widgets after init. they don't work if inside own cls.__new__()
    # this gets called from StateSingleton.__new__
    def setup(self):
        self.submit_b.on_click(self.on_change)
        self.path_t.on_submit(self.on_change)
        self.children = [self.submit_b, self.path_t]

    def on_change(self, change) -> None:
        # if not self.path_t.value:
        #     self.path_t.value = self.path_t.placeholder
        new_path_str = self.path_t.value
        self.debug.value += f"\n{datetime.datetime.now()}[path_select] Changing path to: {new_path_str}"
        try:
            self.state.change_root(new_path_str)
        except BaseException as e:
            self.debug.value += f"\n[path_select] PATH CHANGE ERROR"
            self.debug.value += pformat(e)
            return(None)
