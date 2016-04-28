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

Install modules:
```
$ ./mason system/modules-3.2.10
# source ~/.env.d/00-modules.bashrc
```
