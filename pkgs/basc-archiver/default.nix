{ stdenv, pkgs, lib, pythonPackages }:

let
  inherit (pythonPackages) python buildPythonApplication buildPythonPackage;
  basc-py4chan = buildPythonPackage rec {
      pname = "basc-py4chan";
      version = "0.6.5";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/90/72/17092df1b71891b38d067621a0643ba24b574eb716f3f2710b092eba003d/BASC-py4chan-0.6.5.tar.gz";
        sha256 = "481769eb69825e1645135857aa112c44675ba419cb1c6ec308634130cbcb700e";
      };

      doCheck = false;

      propagatedBuildInputs = [
        pythonPackages.requests
      ];
      meta = {
        homepage = "http://github.com/bibanon/BASC-py4chan";
        license = lib.licenses.wtfpl;
        description = "Python 4chan API Wrapper. Improved version of Edgeworth's original py-4chan wrapper.";
      };
    };
in
buildPythonApplication rec {
  pname = "basc-archiver";
  version = "0.9.9";

  src = pkgs.fetchurl {
    url = "https://files.pythonhosted.org/packages/dc/98/19653779cd991010c4b4052d7388fae5b965ece9acd7f5e80fed2c0a2c25/BASC-Archiver-0.9.9.tar.gz";
    sha256 = "a09d6001d5e58d92fd90245b7ba9056b7836cfd57d95f10e4aa36b45e40fa9e6";
  };

  doCheck = false;
  propagatedBuildInputs = [
    basc-py4chan
    pythonPackages.docopt
    pythonPackages.requests
  ];

  meta = {
    homepage = "https://github.com/bibanon/BASC-Archiver";
    description = "Makes a complete archive of imageboard threads including images, HTML, and JSON.";
    license = lib.licenses.lgpl3;
  };
}
