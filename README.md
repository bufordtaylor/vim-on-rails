vimconf
=======
* Super easy to install
* Everything in vimrc is explained
* Autocomplete, syntax checker, plugin manager and much more

\* **Packages required by plugins:** clang, ruby, ctags, jedi (python-package)   
See .vimrc for more info.   

Installation
------------

    git clone https://github.com/bufordtaylor/vimconf.git
    cd vimconf
    ./install.sh
    ln -s vimconf/.vimrc ~/.vimrc
    vim

Configuration
-------------
If you choose to symlink your `~/.vimrc` you can easily maintain an updated
version of this vim configuration by using the local additions.

`~/.vimrc.bundles`  Add your personal bundles here.   
`~/.vimrc.first`    Prerequisites only, as it will be overwritten by whatever below.   
`~/.vimrc.last`     Overrides everything. Generally use this.   

