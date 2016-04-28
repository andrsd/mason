do_download() {
  curl -L -O $URI || exit 2
}

do_unpack() {
  echo "*** Unpacking..."
  tar xf $DISTFILES/$FILE_NAME -C $PROOT/src
}

do_make() {
  echo "*** Now, building..."
  make -j$JOBS
}

do_configure() {
  echo "*** Configuring... --prefix="$PIDIR $MCONF
  CFLAGS=$CFLAGS \
    CXXFLAGS=$CXXFLAGS \
    FCFLAGS=$FCFLAGS \
    F90FLAGS=$F90FLAGS \
    F77FLAGS=$F77FLAGS \
    $PSRC/configure --prefix=$PIDIR $MCONF || exit 1
}

do_install() {
  echo "*** And, installing..."
  make install
}

do_postinstall() {
  :
}


mdownload() {
  do_download
}

munpack() {
  do_unpack
}

mconfigure() {
  :
}

mmake() {
  do_make
}

minstall() {
  do_install
}

mpostinstall() {
  do_postinstall
}

# Core functions
core_download() {
  if [ ! -z $URI ] ; then
    # download
    mkdir -p $DISTFILES
    if [ -f $DISTFILES/$FILE_NAME ] ; then
      echo "*** Distribution file in place, skipping download..."
    else
      cd $DISTFILES
      mdownload
    fi
  fi
}

core_unpack() {
  # unpack
  rm -rf $PROOT/src
  mkdir -p $PROOT/src
  cd $PROOT/src
  munpack
}

core_configure() {
  # make dir for build
  mkdir -p $PBUILD
  cd $PBUILD
  # configure
  MCONF=''
  mconfigure
  do_configure
}

core_make() {
  # make
  cd $PBUILD
  mmake || exit 4
}

core_install() {
  # install
  cd $PBUILD
  minstall || exit 5
}

core_postinstall() {
  mpostinstall || exit 7
}
