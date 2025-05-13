{
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage rec {
  pname = "dtkit-patch";
  version = "0.1.6";

  src = fetchFromGitHub {
    owner = "manshanko";
    repo = pname;
    tag = version;
    hash = "sha256-pGTS0Jk6ZxJj36cjQty/fLKDi67SVPBOp/wyylIfWZ0=";
  };

  cargoHash = "sha256-mn9Ii8SqsE7px0Dw2vSG3MM+94fL+b1Y3u16nU2lO5g=";

  useFetchCargoVendor = true;
}
