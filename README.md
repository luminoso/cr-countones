![Diagram](https://github.com/luminoso/cr-countones/raw/master/doc/design_1.png)

# Reconfigurable computing using FPGA demo

Developed at  [Aveiro University](https://www.ua.pt) in the course [47979 -Re-configurable Computing](https://www.ua.pt/ensino/uc/5211) this demo has the purpose of demonstrate the various concepts of re-configurable computing and direct interaction using GPIO. This project was tested using a *Diligent Nexys 4 DDR* with a *Xilinx Artix-7* FPGA with *Xilinx Vivado 2016.4 on Fedora Linux*. It should also compatible with other boards, such as *Xilinx Zybo* if the proper board's constraint file is used. The final result is the count of the maximum number of consecutive ones in a 16 x 16 bit array. 

## Concept 

This intends to be a demonstration of various concepts of FPGA and VHDL programming using Xilinx software, including:

1. IP Core Integrator to manage modules
2. Microblaze as a cpu processor
3. GPIO as communication and transfer of data between the software and the hardware (FPGA as a hardware accelerator)
4. Finite State Machines to develop the algorithm
5. Distributed memory usage
6. Outputs demonstrations using: LEDs, 7 segment display and VGA

### Workflow

1. Fill FPGA memory 8 words of 8 bits via Vivado SKD and GPIO Microblaze interface
2. Unroll the ROM and find the maximum of consecutive ones of a 256 bit array using a Finite State Machine
3. Write the result to a second ram
4. Read and print the result using GPIO and SDK
5. Display the result in the SDK, 7 segment display and VGA

## How to run

In order to run this demo it is required to install Xilinx Vivado 2016.4 or higher with SDK module. 

Open Microblaze project using Xilinx Vivado. Included is a constraint file and a pre-compiled bitstream file for *Nexys 4 DDR Student Edition*, but other boards can be used as long the constraint file matches the ports of the required input and output ports of the project.

Step-by-step:
1. If a different board change the constraints file and re-run *Bitstream Generator*
2. Export bitstream to SDK using Vivado
3. Program the FPGA with the bitstream
3. Launch SDK and run FillRam.c (included in the SDK project *FillRam*)

The 7 segment display and the SDK console and VGA should display the number of consecutive ones of the array.

To change the input array edit [FillRam.c](Microblaze/Microblaze.sdk/FillRam/src/FillRam.c).

## Structure

The next diagram represents the solution architecture. SDK uses the MicroBlaze to communicate with the FPGA via Nexys GPIO interface, which fills the memory block.

<p align="center"> 
	<img src="https://github.com/luminoso/cr-countones/blob/master/doc/diagram.png" alt="High Level Architecture">
</p>

After memory is filled, a bit of the GPIO output signals FSM to calculate the number of consecutive ones of the array, storing the value in ram. Then it signals the SDK via GPIO and 7 segment display controller which reads the result. SDK then fills the VGA memory block.

### Project Components

The project itself is organized in the following structure:

| Folder       | Description                                                               |
|--------------|---------------------------------------------------------------------------|
| FSM_tester   | FSMCountOnes tester without SDK. Loads memory contents directly from file |
| FSMCountOnes | Finite State Machine project (core algorithm)                             |
| IP           | Folder with the various IP blocks                                         |
| Microblaze   | Main project folder with the complete solution                            |


### Internal Components

These project is composed of several modules, both internals of the FPGA main program as well the project itself. The IP blocks are the following:

| IP Block            | Description                                                         |
|---------------------|---------------------------------------------------------------------|
| BinToBCD            | Converts the binary number to BCD format for the 7 segment displays |
| Coount_Ones         | Finite State Machine that counts the number of consequtive ones     |
| EightDisplayControl | Controls the 7 segment displays of the Nexys board                  |
| Unroll_rom_last     | Unrolls a predefined number of RAM/ROM positions to a single vector |
| VGA_for_block       | VGA module controller                                               |
	

## Running examples

Example of counting 240 bits in a row. Led output can be used as a probe for debugging, but in this case it is displaying the same result as the 7 segment display.

<p align="center">
    <img src="https://github.com/luminoso/cr-countones/blob/master/doc/nexys4_640.jpg" alt="Final result">
</p>

# Bugs

[Due to a Vivado bug](https://forums.xilinx.com/t5/Welcome-Join/SDK-Internal-Error-The-folder-quot-metadata-quot-is-read-only/td-p/675165) the project folder path cannot run in a directory containing spaces.

## Licence

MIT
