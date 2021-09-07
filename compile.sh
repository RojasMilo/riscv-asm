#!/bin/bash

# clean previos program
./reset.sh

#create folder if not exist
if [ ! -d dumped_files ]; then
  mkdir dumped_files
fi
linker="./progInC/ram.lds"
start="./progInC/start.S"
if [ ! -z $2 ]; then
	linker=$2
	start="./progInC/start_bus.S"
fi

# Compile the progInC (just a dummy progInC)
riscv64-unknown-elf-gcc -c $start -o ./dumped_files/start.o -march=rv32im -mabi=ilp32


# Compile the your program to assembly
riscv64-unknown-elf-gcc -c ./$1 -o ./dumped_files/main.S -march=rv32im -mabi=ilp32 -S


# Compile the assembly to object
riscv64-unknown-elf-gcc -c ./dumped_files/main.S -o ./dumped_files/main.o -march=rv32im -mabi=ilp32

# assemble your program
riscv64-unknown-elf-gcc ./dumped_files/start.o ./dumped_files/main.o -o ./dumped_files/boot.elf -march=rv32im -mabi=ilp32 -Os -ffreestanding -nostdlib -Wl,-Bstatic,-T,$linker,-Map,./dumped_files/boot.map,--strip-debug -lgcc



# Just dump the assembly, for fun
riscv64-unknown-elf-objdump -D ./dumped_files/boot.elf -M no-aliases,numeric > ./dumped_files/boot.noaliases.dump

riscv64-unknown-elf-objdump -D ./dumped_files/boot.elf > ./dumped_files/boot.dump

# Get the binary machine code
riscv64-unknown-elf-objcopy -O binary ./dumped_files/boot.elf ./dumped_files/boot.bin

# Get the silly hex file for verilog techbench
od -t x4 -An -w4 -v ./dumped_files/boot.bin > boot.mem

cat ./dumped_files/boot.dump
echo "the number of instructions its: "
< boot.mem wc -l
cp boot.mem ../testbench/ncsim_tb/ram.mem
cp boot.mem ../testbench/ncsim_tb/boot.mem
