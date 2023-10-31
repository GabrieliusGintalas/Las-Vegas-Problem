#!/bin/bash


#Author: Gabrielius Gintalas
#Date: 08/30/23
#Program name: Assignment 01 - Las Vegas

rm -f *.o
rm -f *.out

echo "Assemble the module fp-io.asm"
nasm -f elf64 -l lasvegas.lis -o lasvegas.o lasvegas.asm

echo "Compile the C++ module fp-io-driver.cpp"
g++ -c -m64 -Wall -o main.o main.cpp -fno-pie -no-pie -std=c++17

echo "Link the two object files already created"
g++ -m64 -o lasvegas.out main.o lasvegas.o -fno-pie -no-pie -std=c++17 -lc

echo "Run the program - Las Vegas"
./lasvegas.out

echo "The bash script file is now closing."