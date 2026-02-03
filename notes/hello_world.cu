#include <stdio.h>
#include <iostream>

using namespace std;

// All device methods must use pointers, because the host just gives memory addresses
__global__ void add(int *a, int *b, int *c) {
    *c = *a + *b;
}

int main(void) {

    // Host (CPU) copies of a, b, and c
    int a, b, c; 

    // Device (GPU) copies of a, b, and c
    int *d_a, *d_b, *d_c;

    // Size of memory to allocate in Device for a, b, and c
    int size = sizeof(int);


    // Allocate space for device copies of a, b, c
    cudaMalloc((void **)&d_a, size);
    cudaMalloc((void **)&d_b, size);
    cudaMalloc((void **)&d_c, size);


    // Setup input values
    a = 2;
    b = 7;

    // Copy the address of Host memory a to the value of device d_a
    cudaMemcpy(d_a, &a, size, cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, &b, size, cudaMemcpyHostToDevice);

    // Launch add() kernel on GPU
    add<<<1,1>>>(d_a, d_b, d_c);

    // Copy the Device memory to the Host memory
    cudaMemcpy(&c, d_c, size, cudaMemcpyDeviceToHost);

    // Free the memory in the Host
    cudaFree(d_a); cudaFree(d_b); cudaFree(d_c);

    cout << a << " + " << b << " = " << c << endl;

    // Exit
    return 0;
}