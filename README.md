# Disassembler with Capstone

## Index

  - [Overview](#overview) 
  - [Getting Started](#getting-started)
  - [Usage](#Usage)
  - [Demo](#Demo)

## Overview

- This is an **disassembler** that was implemented using **Capstone**. 
- Disassembly was implemented in a **linear** and **recursive** method.
- This code is based on Practical Binary Analysis and [binary-loader](#https://github.com/topcue/binary-loader).
- Additionally, there is a code to find a **rop gadget** using capstone.

## Getting Started

### Dependencies

- binutils-dev

```
sudo apt-get install -y binutils-dev
```

- capstone-4.0.2

```
wget https://github.com/aquynh/capstone/archive/4.0.2.tar.gz
tar -xzvf 4.0.2.tar.gz
rm *.tar.gz && mv capstone-* capstone

cd capstone
make
sudo make install
```

## Usage

Usage: `./linear_disassembler <binary>`

Usage: `./recursive_disassembler <binary>`

Usage: `./rop_gadget_finder <binary>`

## Demo

- `linear_disassembler`

```
$ ./linear_disassembler test_bin/ls | head

0x0000000000004da0: e8 ab f9 ff ff                                  call         0x4750
0x0000000000004da5: e8 a6 f9 ff ff                                  call         0x4750
0x0000000000004daa: e8 a1 f9 ff ff                                  call         0x4750
0x0000000000004daf: e8 9c f9 ff ff                                  call         0x4750
0x0000000000004db4: e8 97 f9 ff ff                                  call         0x4750
0x0000000000004db9: e8 92 f9 ff ff                                  call         0x4750
0x0000000000004dbe: e8 8d f9 ff ff                                  call         0x4750
0x0000000000004dc3: e8 88 f9 ff ff                                  call         0x4750
0x0000000000004dc8: e8 83 f9 ff ff                                  call         0x4750
0x0000000000004dcd: e8 7e f9 ff ff                                  call         0x4750
```

- `recursive_disassembler`

```
$ ./recursive_disassembler test_bin/ls | head

entry point: 0x00000000000067d0
function symbol: 0x0000000000016c60
function symbol: 0x0000000000016a80
function symbol: 0x0000000000016bf0
function symbol: 0x0000000000016bb0
function symbol: 0x0000000000016aa0
function symbol: 0x0000000000016ac0
0x00000000000067d0: f3 0f 1e fa                                     endbr64
0x00000000000067d4: 31 ed                                           xor          ebp, ebp
0x00000000000067d6: 49 89 d1                                        mov          r9, rdx
```

- `rop_gadget_finder`

```
$ ./rop_gadget_finder test_bin/ls | head

adc al, 0xd9; add dword ptr [rax], eax; ret 	[ 0x6900 ]
adc bl, al; nop dword ptr [rax]; endbr64 ; mov rax, qword ptr [rdi + 0x18]; ret 	[ 0xf007 ]
adc byte ptr [r11 + 0x5d], bl; pop r12; ret 	[ 0x10bf7 0x10da7 ]
adc byte ptr [r8], r8b; mov qword ptr [rdi], rax; movabs rax, 0x3fb4fdf43f4ccccd; mov qword ptr [rdi + 8], rax; ret 	[ 0xf49f ]
adc byte ptr [rax - 0x77], cl; ret 	[ 0x10c38 0x10d1e 0x10de8 0x10ece ]
adc byte ptr [rax - 0x7d], cl; ret 	[ 0x85d9 0xd233 ]
adc byte ptr [rax], al; mov qword ptr [rdi], rax; movabs rax, 0x3fb4fdf43f4ccccd; mov qword ptr [rdi + 8], rax; ret 	[ 0xf4a0 ]
adc byte ptr [rbx + 0x5d], bl; pop r12; ret 	[ 0x10bf8 0x10da8 ]
adc byte ptr [rcx + rcx*4 - 0x20], cl; pop rbx; pop rbp; pop r12; ret 	[ 0xfc5a ]
adc byte ptr [rcx + rdi + 0x4f], cl; or byte ptr [rdi - 0x10], dh; ret 	[ 0xf398 ]
```

