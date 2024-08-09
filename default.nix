{ pkgs ? import <nixpkgs> {config.cudaSupport = true; }, lib ? pkgs.lib }:

let
 nixglhost-sources = pkgs.fetchFromGitHub {
   owner = "numtide";
   repo = "nix-gl-host";
   rev = "main";
   # Replace this with the hash Nix will complain about, TOFU style.
   hash = "sha256-mSGjMNnwHuS8OUjquGbokWsue6CIDTy+MIZIguCKSQE=";
 };

 nixglhost = pkgs.callPackage "${nixglhost-sources}/default.nix" { };

 xgboost-gpu = pkgs.rPackages.buildRPackage {
   name = "xgboost-gpu";
   src = pkgs.fetchzip {
       url = "https://s3-us-west-2.amazonaws.com/xgboost-nightly-builds/release_2.1.0/xgboost_r_gpu_linux_e36d361674cb1b8fd599da891e1e91a427bb4159.tar.gz";
       sha256 = "sha256-vXQUmnVnwcUK6xAZZB6vpGrmHyfbZcKN43P6XonY2go=";
      };
   propagatedBuildInputs = with pkgs; [ rPackages.data_table rPackages.Matrix rPackages.jsonlite ];
 };

in pkgs.mkShell {
  buildInputs = [
    nixglhost
    xgboost-gpu
    pkgs.R
  ];
}