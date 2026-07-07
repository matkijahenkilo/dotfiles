final: prev: {
  micro = prev.micro.overrideAttrs (oldAttrs: {
    patches = (oldAttrs.patches or [ ]) ++ [
      ./Add-string-interpolation-support-to-nix.patch
    ];
  });
}
