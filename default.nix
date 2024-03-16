{ pkgs ? import <nixpkgs> {}
, lib ? pkgs.lib
}:

with pkgs.python3Packages;

buildPythonPackage rec {
  pname = "cbor2";
  version = "5.6.3-1";

  src = lib.cleanSourceWith {
    src = ./.;
    filter = name: type: let baseName = baseNameOf (toString name); in
      (builtins.match ".*.un~" baseName == null)
      && (baseName != "dist")
      && (baseName != "result")
      && (baseName != "results")
      && (baseName != "__pycache__")
      && (baseName != ".mypy_cache")
      && (baseName != ".pytest_cache")
      ;
  };

  nativeBuildInputs = [
    setuptools
    setuptools-scm
  ];

  nativeCheckInputs = [
    hypothesis
    pytestCheckHook
  ];
}
