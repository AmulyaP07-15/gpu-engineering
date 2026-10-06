// 00: Print the properties of every visible GPU.
// First sanity check that the CUDA toolchain + runtime work.
#include <cstdio>
#include <cuda_runtime.h>

int main() {
    int count = 0;
    cudaError_t err = cudaGetDeviceCount(&count);
    if (err != cudaSuccess) {
        printf("cudaGetDeviceCount failed: %s\n", cudaGetErrorString(err));
        return 1;
    }
    printf("CUDA devices: %d\n", count);

    for (int d = 0; d < count; ++d) {
        cudaDeviceProp p;
        cudaGetDeviceProperties(&p, d);
        printf("\n[%d] %s\n", d, p.name);
        printf("  compute capability : %d.%d\n", p.major, p.minor);
        printf("  SMs                : %d\n", p.multiProcessorCount);
        printf("  global memory      : %.1f GiB\n", p.totalGlobalMem / (1024.0 * 1024 * 1024));
        printf("  shared mem / block : %zu KiB\n", p.sharedMemPerBlock / 1024);
        printf("  registers / block  : %d\n", p.regsPerBlock);
        printf("  warp size          : %d\n", p.warpSize);
        printf("  max threads / block: %d\n", p.maxThreadsPerBlock);
        printf("  L2 cache           : %d KiB\n", p.l2CacheSize / 1024);
        printf("  memory bus width   : %d bits\n", p.memoryBusWidth);
    }
    return 0;
}
