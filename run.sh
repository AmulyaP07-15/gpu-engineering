#!/usr/bin/env bash
# Usage: bash run.sh <path/to/file.cu> [extra nvcc flags]
# Compiles with nvcc, runs the binary, and writes <dir>/output.txt
# with the GPU name, nvcc version, and exact compile command at the top.
set -euo pipefail

src="$1"; shift || true
dir="$(dirname "$src")"
bin="$dir/$(basename "$src" .cu)"
cmd="nvcc -O3 -arch=native $* $src -o $bin"

{
  echo "date:  $(date -u +%Y-%m-%dT%H:%MZ)"
  echo "gpu:   $(nvidia-smi --query-gpu=name,driver_version --format=csv,noheader)"
  echo "nvcc:  $(nvcc --version | tail -n 2 | head -n 1)"
  echo "cmd:   $cmd"
  echo "----------------------------------------"
} > "$dir/output.txt"

eval "$cmd"
"$bin" | tee -a "$dir/output.txt"
