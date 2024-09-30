# { lib
# , python3Packages
# , fetchPypi
# }:
with import <nixpkgs>{};
with pkgs.python3Packages;
(let
  hash = "sha256-duhFk4x8qtE75tXJUP9seIUoLjDPzewjPHSH3NbHO6w=";
  imagecodecs = python3Packages.buildPythonPackage rec {
  pname = "imagecodecs";
  version = "3efbf73fdbada9def98d7eada9e9a4ccb985ba69";

  # src = fetchPypi {
  #   inherit pname version;
  #   hash  = "sha256-/qCAG0AI0l6XGRjZkTl6NRu+dids+pju0t5Uy4folKM=";
  # };
  src = fetchFromGitHub {
    owner = "afermg";
    repo = "imagecodecs";
    rev = "${version}";
    hash  = "${hash}";
  };

  build-system = with python3Packages; [
    setuptools
  ];

  nativeBuildInputs = [
    cython
    # openjpeg # this is not detected, removed from my fork
    # jxrlib # not detected
    # lz4
  ];
  # preConfigure = ''
  #   export CFLAGS="-I${lz4}/include"
  #   export CPPFLAGS="-I${lz4}/include"
  # '';
  nativeCheckInputs =  [ pytest ];
  propagatedBuildInputs = [
    numpy
    lcms
    lerc
    # lz4
    # brotli
  ];
  # dependencies = with python3Packages; [
  #   tornado
  #   python-daemon
  # ];

  doCheck = "false";
  meta = {
    # ...
  };
};
in python3.buildEnv.override rec {
  extraLibs = [imagecodecs];
}
)
