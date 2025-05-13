{
  pkgs ? <nixpkgs> { },
  ...
}:
pkgs.mkShell {
  shellHook = ''
    echo -e "\u001b[35m
    ⠀⠀⠀⠀⣾⣿⣿⣷⣄
    ⠀⠀⠀⢸⣿⣿⣿⣿⣿⣧⣴⣶⣶⣶⣄
    ⠀⠀⠀⣀⣿⣿⡿⠻⣿⣿⣿⣿⣿⣿⣿⡄
    ⠀⠀⠀⢇⠠⣏⡖⠒⣿⣿⣿⣿⣿⣿⣿⣧⡀
    ⠀⠀⢀⣷⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷
    ⠀⠀⢸⣿⣿⡿⢋⠁⠀⠀⠀⠀⠉⡙⢿⣿⣿⡇
    ⠀⠀⠘⣿⣿⠀⣿⠇⠀⢀⠀⠀⠘⣿⠀⣿⡿⠁
    ⠀⠀⠀⠈⠙⠷⠤⣀⣀⣐⣂⣀⣠⠤⠾⠋⠁
    "

    export NH_FLAKE=$(git rev-parse --show-toplevel);
  '';

  nativeBuildInputs = with pkgs; [
    nh
  ];
}
