#include <stdio.h>
#include <iostream>
#include <stdlib.h>
#include <cuda_runtime.h>

using namespace std;

bool _printProperties();

int main (void) {
    // Main method to call subsequent helper methods to find the number of devices on the system and output their properties

    if (!_printProperties()) {
        cout << "ERROR: Could not retrieve device properties" << endl;
        return 1;
    }

    return 0;
}

bool _printProperties() {
    // Utilizes built-in CUDA libraries to find the number of devices in the system, and then print the properties of each device

    // Initialize an integer to track the number of devices
    int numDevices;

    // Get the number of devices on the machine
    cudaError_t success = cudaGetDeviceCount(&numDevices);

    switch (success) {

        // Success from the device count
        case cudaSuccess:
            break;

        // Could not find a device using the CUDA driver, throw error
        case cudaErrorNoDevice:
            return false;
            break;
        
        // Outdated CUDA driver, throw error
        case cudaErrorInsufficientDriver:
            return false;
            break;            
    }   


    // For each device, print the system properties
    for (int i = 0; i < numDevices; i++) {

        // Get the properties of each device in the list of devices
        cudaDeviceProp properties;
        success = cudaGetDeviceProperties(&properties, i);

        switch (success) {

            // Success from the device properties
            case cudaSuccess:
                break;

            // Device was invalid, throw error
            case cudaErrorInvalidDevice:
                return false;
                break; 
        }  

        // Print a header line to start the device
        cout << "----- Device " << i + 1 << " -----" << endl;

        // Print each property of the device
        cout << "Name: " << properties.name << endl;
        cout << "Major: " << properties.major << endl;
        cout << "Minor: " << properties.minor << endl;
        cout << "MultiProcessor Count: " << properties.multiProcessorCount  << endl;
        cout << "Max Threads per MultiProcessor: " << properties.maxThreadsPerMultiProcessor << endl;
        cout << "Max Threads per Block: " << properties.maxThreadsPerBlock << endl;
        cout << endl;   // Print a blank line to separate each device
    }

    return true;

}