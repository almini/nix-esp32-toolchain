{
  description = "ESP32 Toolchain";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs = {self, nixpkgs}: {
    defaultPackage.x86_64-linux =
      with import nixpkgs { system = "x86_64-linux"; };

      stdenv.mkDerivation rec {
        name = "esp32-toolchain-${version}";

        version = "2021r2-patch3";

        src = fetchurl {
          url = "https://github.com/espressif/crosstool-NG/releases/download/esp-${version}/xtensa-esp32-elf-gcc8_4_0-esp-${version}-linux-amd64.tar.gz";
          sha256 = "sha256-nt0ed2J2iPQ1Vhki0UKZ9qACG6H2/2fkcuEQhpWmnlM=";
        };

        dontConfigure = true;
        dontBuild = true;

        installPhase = ''
          mkdir -p $out
          cp -r * $out
        '';

        meta = with lib; {
          description = "ESP32 compiler toolchain";
          homepage = "https://docs.espressif.com/projects/esp-idf/en/stable/get-started/linux-setup.html";
          license = licenses.gpl3;
          platforms = platforms.linux;
        };
      };
  };
}