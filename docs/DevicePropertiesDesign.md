# CUDA Device Properties

The CUDA (Compute Unified Device Architecture) Device Properties module retrieves device information from the machine and outputs system properties. The CUDA Device Properties architecture allows the property retrieval of multiple devices on a system.

## Requirements
- CUDA software
- Can access devices on the system
- Can output properties of each device

## Public Methods
***int main(void) {}***

    Main method to call subsequent helper methods to find the number of devices on the system and output their properties

## Private Methods
***void _printProperties(void) {}***

    Utilizes built-in CUDA libraries to find the number of devices in the system, and then print the properties of each device