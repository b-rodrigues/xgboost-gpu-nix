# xgboost with GPU acceleration in a Nix shell

A simple test script to test the experimental gpu-accelerated xgboost R package
in a Nix shell. Uses nixglhost to launch a "gpu-aware" Nix shell.

First, drop in the shell with `nix-shell`. Then, start R: `nixglhost R`. Run the
included script with `source("script.R")` and watch your GPU getting warm using
a tool like `btop`.

Inspired by [https://anatolii.nz/posts/2024/xgboost-gpu-r](https://anatolii.nz/posts/2024/xgboost-gpu-r).
