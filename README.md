# Exploring CUDA Basics - Device Properties Retrieval

The Device Properties Retrieval module finds all available CUDA devices on the running machine and outputs their properties. This module iterates through each available device, from 0 to N. Additionally, errors in the system are caught via the built-in *cudaError_t* object. Through the execution of this script, one can discover all CUDA devices on his machine and see their properties.

## Usage
Compilation of the Device Properties Retrieval module is simple, as the CUDA compiler resembles C++ closely. The following command compiles the module:

```
nvcc src/device_properties.cu -o device_properties
```

The above command will create an executable file which discovers all CUDA components in the machine. Executing this file requires the following command:

```
device_properties
```

