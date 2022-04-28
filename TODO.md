## sql file chooser
test UI stability for resolution/size
incorporate functionality to read a folder path of sql files
- use ipyfilechooser for selecting folder?
add root dir and dirtab cache so state is kept when user changes root
disable dirs that don't contain any sql files?

## sql file viewer/editor?
path.name/file.name

## query randomizer/sequencer
modify dbstress or dUI?

## delta optimizer
https://github.com/PavanDendi/delta-optimizer

## dbstress
****** surface dbstress output/errors

## sql endpoint chooser
database picker?
clear/populate/disable caching?
detect UC and choose catalog?
create endpoint?

## process/show results
pull query history and profile after runs



removed code trying to implement caching:
```
# caches store objects for later retrieval so they maintain state
# cls._instance.root_dir_cache = {cls._instance.root: root_dir_row}
# cls._instance.dirtabs_cache = cls._instance.dirtabs
# find dirs not in cache and add them
# cache_dir_rows = [d.dir_row for d in self.dirtabs_cache.values()]
# add_dirs = set(new_dirs) - set(self.dirtabs_cache.keys())
# self.debug.value += f"\n[state][change_root] add_dirs: {pformat([d.path.name for d in add_dirs])}"
# for dir in add_dirs:
    # old_files = self.dirtabs_cache
    # self.dirtabs_cache.update({dir: self._ls_sql(dir.path)})

# self.debug.value += f"\n[state][change_root] cache update: {pformat(self.dirtabs_cache.keys())}"

# remove deleted dirs from cache
# del_dirs = set(self.dirtabs) - set(new_dirs)
# self.debug.value += f"\n[state][change_root] del_dirs: {pformat([d.path.name for d in del_dirs])}"
# for dir in del_dirs:
    # self.dirtabs_cache.pop(dir)

# load new root dirs from cache and update dir selector and tabs
# self.dirtabs = {dir: self.dirtabs_cache[dir] for dir in new_dirs}
# self.debug.value += f"\n[state][change_root] dirtabs: {pformat(self.dirtabs.keys())}"
```