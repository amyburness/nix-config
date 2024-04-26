{
  lib,
  fetchFromGitHub,
  makeWrapper,
  mkDerivation,
  substituteAll,
  wrapGAppsHook,
  wrapQtAppsHook,
  withGrass ? true,
  withWebKit ? false,
  bison,
  cmake,
  draco,
  exiv2,
  fcgi,
  flex,
  geos,
  grass,
  gsl,
  hdf5,
  libspatialindex,
  libspatialite,
  libzip,
  netcdf,
  ninja,
  openssl,
  pdal,
  postgresql,
  proj,
  protobuf,
  python3,
  qca-qt5,
  qscintilla,
  qt3d,
  qtbase,
  qtkeychain,
  qtlocation,
  qtmultimedia,
  qtsensors,
  qtserialport,
  qtwebkit,
  qtxmlpatterns,
  qwt,
  saga,
  sqlite,
  txt2tags,
  zstd,
}: let
  py = python3.override {
    packageOverrides = self: super: {
      pyqt5 = super.pyqt5.override {
        withLocation = true;
        withSerialPort = true;
      };
    };
  };

  pythonBuildInputs = with py.pkgs; [
    chardet
    debugpy # Added by Tim for debugging
    future
    gdal
    jinja2
    matplotlib
    numpy
    owslib
    pandas
    geopandas
    plotly
    psycopg2
    pygments
    pyqt5
    pyqt5_with_qtwebkit # Added by Tim for InaSAFE
    pyqt-builder
    pyqtgraph # Added by Tim for QGIS Animation workbench (should probably be standard)
    python-dateutil
    pytz
    pyyaml
    qscintilla-qt5
    rasterio # Added by Tim for GEEST
    requests
    setuptools
    sip
    six
    sqlalchemy # Added by Tim for QGIS Animation workbench
    urllib3
  ];
in
  mkDerivation rec {
    #version = "master";
    version = "3.36.2";
    pname = "qgis-master";

    #src = fetchGit {
    #  url = "/home/timlinux/dev/cpp/QGIS";
    #  rev = "581589aa0a4af3bb62a4f7e88cacaf94be752050";
    #};
    #src = fetchFromGitHub {
    #  owner = "qgis";
    #  repo = "QGIS";
    #  rev = "master";
    #  hash = "sha256-w+glJxacDItEng8/rENmjB5FRyjLUpeOiOEkl+XO++0=";
    #  #hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
    #};
    #version = "3.36.2";
    #pname = "qgis-unwrapped";

    src = fetchFromGitHub {
      owner = "qgis";
      repo = "QGIS";
      rev = "final-${lib.replaceStrings ["."] ["_"] version}";
      hash = "sha256-/8mpzl/6UpjrMVjae2nqpS2DBRCq86rE+B3INzoRz8g=";
    };

    passthru = {
      inherit pythonBuildInputs;
      inherit py;
    };

    nativeBuildInputs = [
      makeWrapper
      wrapGAppsHook
      wrapQtAppsHook

      cmake
      flex
      bison
      ninja
    ];

    buildInputs =
      [
        draco
        exiv2
        fcgi
        geos
        gsl
        hdf5
        libspatialindex
        libspatialite
        libzip
        netcdf
        openssl
        pdal
        postgresql
        proj
        protobuf
        qca-qt5
        qscintilla
        qt3d
        qtbase
        qtkeychain
        qtlocation
        qtmultimedia
        qtsensors
        qtserialport
        qtwebkit
        qtxmlpatterns
        qwt
        saga # Probably not needed for build
        sqlite
        txt2tags
        zstd
      ]
      ++ lib.optional withGrass grass
      ++ lib.optional withWebKit qtwebkit
      ++ pythonBuildInputs;

    patches = [
      (substituteAll {
        src = ./set-pyqt-package-dirs.patch;
        pyQt5PackageDir = "${py.pkgs.pyqt5}/${py.pkgs.python.sitePackages}";
        qsciPackageDir = "${py.pkgs.qscintilla-qt5}/${py.pkgs.python.sitePackages}";
      })
    ];

    # Add path to Qt platform plugins
    # (offscreen is needed by "${APIS_SRC_DIR}/generate_console_pap.py")
    preBuild = ''
      export QT_QPA_PLATFORM_PLUGIN_PATH=${qtbase.bin}/lib/qt-${qtbase.version}/plugins/platforms
    '';

    cmakeFlags =
      [
        "-DCMAKE_BUILD_TYPE=Release"
        "-DWITH_3D=True"
        "-DWITH_PDAL=TRUE"
        "-DENABLE_TESTS=FALSE"
        "-DWITH_SERVER=FALSE"
      ]
      ++ lib.optional (!withWebKit) "-DWITH_QTWEBKIT=OFF"
      ++ lib.optional withGrass (
        let
          gmajor = lib.versions.major grass.version;
          gminor = lib.versions.minor grass.version;
        in "-DGRASS_PREFIX${gmajor}=${grass}/grass${gmajor}${gminor}"
      );

    qtWrapperArgs = [
      "--set QT_QPA_PLATFORM_PLUGIN_PATH ${qtbase.bin}/lib/qt-${qtbase.version}/plugins/platforms"
    ];

    dontWrapGApps = true; # wrapper params passed below

    postFixup = lib.optionalString withGrass ''
      # GRASS has to be available on the command line even though we baked in
      # the path at build time using GRASS_PREFIX.
      # Using wrapGAppsHook also prevents file dialogs from crashing the program
      # on non-NixOS.
      wrapProgram $out/bin/qgis \
        "''${gappsWrapperArgs[@]}" \
        --prefix PATH : ${lib.makeBinPath [grass]}
      #mv qgis $out/bin/qgis-master
    '';

    meta = with lib; {
      description = "A Free and Open Source Geographic Information System";
      homepage = "https://www.qgis.org";
      license = lib.licenses.gpl2Plus;
      maintainers = with maintainers; teams.geospatial.members ++ [lsix];
      platforms = with platforms; linux;
    };
  }
