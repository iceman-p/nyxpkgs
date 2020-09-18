{ config, stdenv, pkgs, lib }:

let
  desktopFile = pkgs.makeDesktopItem {
    name = "derpibooru-downloader";
    exec = "@out@/bin/DerpibooruDownloaderGui";
    icon = "Derpibooru_Downloader_128";
    comment = "Downloads images from any Philomena booru using a variety of options";
    desktopName = "Derpibooru Downloader";
    categories = "Network";
  };
in
stdenv.mkDerivation rec {
  pname = "derpibooru-downloader";
  version = "2.1.0";

  src = pkgs.fetchFromGitHub {
    owner = "Sibusten";
    repo = "derpibooru-downloader";
    rev = "b040c4f9296b0406d81d01b80e857bbcbc4c8c03";
    sha256 = "15l952xcrjdyf3k4pirwdwydafbd4vf7jxcxxrmm9klj32xx7bm8";
  };

  nativeBuildInputs = [
    pkgs.qt5.qmake
    pkgs.qt5.qttools
    pkgs.qt5.wrapQtAppsHook
  ];

  # Fixes settings so that it lets Qt handle putting them in the default
  # location, instead of dumping them in a non-hidden file in the home
  # directory, or just being broken in the command line tool.
  #
  # This was changed in 1820f0510, saying that it was for portability, but
  # there's no way this was tested on Linux, and I bet this also breaks OSX.
  patches = [
    ./fix-broken-settings.diff
  ];

  enableParallelBuilding = true;

  installPhase = ''
    mkdir -p "$out/bin"
    cp "DerpibooruDownloaderGui/DerpibooruDownloaderGui" "$out/bin/"
    cp "DerpibooruDownloaderCmd/DerpibooruDownloaderCmd" "$out/bin/"

    wrapQtApp "$out/bin/DerpibooruDownloaderGui"

    mkdir -p "$out/share/icons/hicolor/128x128/apps"
    cp $src/DerpibooruDownloaderGui/icon128.png $out/share/icons/hicolor/128x128/apps/Derpibooru_Downloader_128.png

    mkdir -p "$out/share/applications"
    substituteAll ${desktopFile}/share/applications/derpibooru-downloader.desktop $out/share/applications/derpibooru-downloader.desktop
  '';

  meta = {
    description = "Downloads images from any Philomena booru using a variety of options";
    homepage = "https://github.com/Sibusten/derpibooru-downloader";
    license = lib.licenses.gpl3;
  };
}
