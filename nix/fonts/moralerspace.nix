{ lib, stdenvNoCC, fetchzip }:

stdenvNoCC.mkDerivation rec {
  pname = "moralerspace";
  version = "1.1.0";

  src = fetchzip {
    url = "https://github.com/yuru7/moralerspace/releases/download/v${version}/MoralerspaceHWNF_v${version}.zip";
    hash = "sha256-XRdDcfgwbP5g26xh9rlHRp9i//k5PdRhMExMy3ibN/4=";
		# stripRoot = false;
  };

  installPhase = ''
    runHook preInstall

    install -Dm644 *.ttf -t $out/share/fonts/MoralerspaceHWNF

    runHook postInstall
  '';

  meta = with lib; {
		description = "Moralerspace は、欧文フォント Monaspace と日本語フォント IBM Plex Sans JP などを合成したプログラミング向けフォントです。";
    homepage = "https://github.com/yuru7/moralerspace";
    license = [ licenses.ofl licenses.mit ];
    maintainers = [ ];
  };
}
