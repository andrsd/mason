do_download() {
  curl -L -O $URI || exit 2
}

do_unpack() {
  tar xf $DISTFILES/$FILE_NAME -C $PROOT/src
}

do_configure() {
  CFLAGS=$CFLAGS \
  CXXFLAGS=$CXXFLAGS \
  FCFLAGS=$FCFLAGS \
  F90FLAGS=$F90FLAGS \
  F77FLAGS=$F77FLAGS \
  $PSRC/configure $MCONF || exit 1
}

do_cmake() {
  cmake $PSRC \
    -DCMAKE_INSTALL_PREFIX=$PIDIR $MCMAKE || exit 1
}

mdownload() {
  do_download
}

munpack() {
  do_unpack
}

mconfigure() {
  MCONF="--prefix=$PIDIR"
}

mmake() {
  make -j$JOBS
}

minstall() {
  make install
}

mpostinstall() {
  :
}

# Core functions
core_download() {
  echo "*** Downloading..."
  if [ ! -z $URI ] ; then
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
  echo "*** Unpacking..."
  rm -rf $PROOT/src
  mkdir -p $PROOT/src
  cd $PROOT/src
  munpack
}

core_configure() {
  mkdir -p $PBUILD
  cd $PBUILD
  mconfigure
  if [[ ! -z $MCONF ]] ; then
    echo "*** Configuring..."
    do_configure
  elif [[ ! -z $MCMAKE ]] ; then
    echo "*** CMaking..."
    do_cmake
  fi
}

core_make() {
  echo "*** Building..."
  cd $PBUILD
  mmake || exit 4
}

core_install() {
  echo "*** Installing..."
  cd $PBUILD
  minstall || exit 5
}

core_postinstall() {
  echo "*** Post install..."
  mpostinstall || exit 7
}
