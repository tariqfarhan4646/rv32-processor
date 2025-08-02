
Single-cycle **RV32I RISC-V core** written in **Verilog**, built and simulated using **Xilinx Vivado**.

## Features
- Implements RV32I base integer instructions  
- Single-cycle datapath (every instruction completes in one clock cycle)  
- RTL modules: ALU, Control Unit, Register File, Program Counter, Data/Instruction Memory, MUXes  
- Testbenches included for verification  

## Target FPGA
- **Xilinx Artix-7** XC7A100TCSG324-1

## Usage
1. Open or create a Vivado project.  
2. Add Verilog files from `rtl/` and testbenches from `tb/`.  
3. Run Behavioral Simulation to verify functionality.  
4. Synthesize and implement for the target FPGA.  


- **Target FPGA:** Xilinx Artix-7 XC7A100TCSG324-1  


## Tools
- Verilog HDL  
- Xilinx Vivado

## License
MIT License

## Author
Farhan Tariq — (tariqfarhan4646@gmail.com)
