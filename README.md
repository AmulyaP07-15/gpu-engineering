# GPU Engineering

My hands-on log of learning CUDA / C++ GPU programming, from first kernels up to LLM-inference kernels.
Each folder is one exercise: source code, the raw output from a real GPU run, and short notes.

## Progress log

| # | Topic | GPU | Key result | Date |
|---|-------|-----|------------|------|
| 00 | [Device query](00-device-query/) | — | — | — |

## Layout

```
NN-topic/
  *.cu          source
  output.txt    raw program output + GPU name, nvcc version, compile command (written by run.sh)
  notes.md      what I tried, what worked, what surprised me
```

## How I run code (Google Colab, GPU runtime)

```python
# 1. Clone (first cell of every session)
!git clone https://github.com/AmulyaP07-15/gpu-engineering.git
%cd gpu-engineering

# 2. Compile + run + save output (records GPU name and nvcc version)
!bash run.sh 00-device-query/device_query.cu

# 3. Push results back (token: GitHub → Settings → Developer settings → fine-grained token, Contents: read/write)
from getpass import getpass
token = getpass("GitHub token: ")
!git config user.name "Amulya Penikalapati"
!git config user.email "YOUR_GITHUB_EMAIL"
!git add -A && git commit -m "00: device query on Colab GPU"
!git push https://{token}@github.com/AmulyaP07-15/gpu-engineering.git main
```

Timings depend on the GPU (T4 vs L4 vs A100), so every `output.txt` records which one produced it.
