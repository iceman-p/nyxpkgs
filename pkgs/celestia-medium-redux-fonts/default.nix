{pkgs, lib, stdenv, fetchFromGitHub}:

stdenv.mkDerivation rec {
  pname = "celestia-medium-redux-fonts";
  version = "1.55";

  src = fetchFromGitHub {
    owner = "JotaRandom";
    repo = "Celestia-Medium-Redux";
    rev = "964d68333bf6df030b2a1acd11bb82d5844e52c3";
    sha256 = "02g9rpx95k6855glpg7ybd49bjys66gvdpk9p63ph15rd6pdwjjn";
  };

  installPhase = ''
    find ./Fonts -name '*.ttf' -exec install -m444 -Dt $out/share/fonts/truetype {} \;
    install -m444 -Dt $out/share/doc/${pname}-${version} LICENSE README WAIVER
  '';

  meta = with lib; {
    description = "Celestia Medium Redux";
    license = licenses.publicDomain;
    homepage = "https://github.com/JotaRandom/Celestia-Medium-Redux";
  };
}
