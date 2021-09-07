# RISC-V Assembly First Steps

The following procedure should get you started with a clean running RISC-V Assembly project.

### Prerequisites

#### Please Download & Read:

- [RISC-V Book](http://riscvbook.com/spanish/) cap 1 to 3.
- [RISC-V Green Card](http://riscvbook.com/greencard-20181213.pdf)

#### Please Install:

- RISC-V GNU Compiler Toolchain from [here](https://github.com/riscv/riscv-gnu-toolchain), with **--enable-multilib** option
  - Add to your ~/.bashrc file:

  ```sh
  # assume RISC-V is installed to /opt/riscv/
  export RISCV_PATH=/opt/riscv
  export PATH=$PATH:$RISCV_PATH/bin
  ```
- Icarus Verilog from [here](https://iverilog.fandom.com/wiki/Installation_Guide), **compile from source**

### Test tools before proceeding 

- RISC-V GNU Compiler Toolchain
  ```sh
  riscv64-unknown-elf-gcc --version
  ```
  ```sh
  riscv64-unknown-elf-objcopy --version
  ```
- Iverilog
  - Follow the [guide](https://iverilog.fandom.com/wiki/Getting_Started)

