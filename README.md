MASON
=====
Simple building tool


Initial setup
-------------

Setup curl (which is used for downloading packages)
```
# touch ~/.curlrc
```

If behind a proxy, do:
```
# echo "proxy = \"http://host:port\"" >> ~/.curlrc
```

If your proxy needs authentication, do:
```
# echo "proxy-user = \"username:password\"" >> ~/.curlrc
```

Get the package repository:
```
# cd packages
# git clone http://github.com/andrsd/mason-base
```

Or possibly another repo


Override global setting, if needed in `~/.mason/conf`:
```
BUILD_ROOT=/path/where/everything/is/build
PACKAGE_HOME=/path/where/we/install/local/packages
PACKAGE_SOURCES="/path/to/repo1 /path/to/repo2"
DISTFILES=/path/where/we/download/source/code
```

Install modules:
```
$ ./mason system/modules-3.2.10
# source ~/.env.d/00-modules.bashrc
```
