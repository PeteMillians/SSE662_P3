#include <stdio.h>
#include <iostream>
#include <stdlib.h>
#include <time.h>

using namespace std;

#define N (2048*2048)
#define THREADS_PER_BLOCK 512

void random_ints(int *data, int n);

// All device methods must use pointers, because the host just gives memory addresses
__global__ void add(int *a, int *b, int *c) {
    int index = threadIdx.x + blockIdx.x * blockDim.x;
    c[index] = a[index] + b[index];
}


int main(void) {

    // Host (CPU) copies of a, b, and c
    int *a, *b, *c; 

    // Device (GPU) copies of a, b, and c
    int *d_a, *d_b, *d_c;

    // Size of memory to allocate in Device for a, b, and c
    int size = N * sizeof(int);

    // Allocate space for device copies of a, b, c
    cudaMalloc((void **)&d_a, size);
    cudaMalloc((void **)&d_b, size);
    cudaMalloc((void **)&d_c, size);

    // Allocate space for Host (CPU) copies of a, b, and c and setup input values
    a = (int *)malloc(size); random_ints(a, N);
    b = (int *)malloc(size); random_ints(b, N);
    c = (int *)malloc(size);

    // Copy the address of Host memory a to the value of device d_a
    cudaMemcpy(d_a, a, size, cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, b, size, cudaMemcpyHostToDevice);

    // Launch add() on GPU with N / THREADS_PER_BLOCK blocks, and THREADS_PER_BLOCK threads
    add<<<N / THREADS_PER_BLOCK, THREADS_PER_BLOCK>>>(d_a, d_b, d_c);

    // Copy the Device memory to the Host memory
    cudaMemcpy(c, d_c, size, cudaMemcpyDeviceToHost);

    // Free the memory in the Host
    free(a); free(b); free(c);
    cudaFree(d_a); cudaFree(d_b); cudaFree(d_c);

    // Exit
    return 0;
}

void random_ints(int *data, int n) {
    // Seed the RNG once per program run
    static int seeded = 0;
    if (!seeded) {
        srand((unsigned int)time(NULL));
        seeded = 1;
    }

    for (int i = 0; i < n; i++) {
        data[i] = rand() % 100;   // random integer 0–99
    }
}
