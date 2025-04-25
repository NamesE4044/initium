# **μstart**
**μstart** is a Linux CLI Firmware Development Project Generator Focused on Bare-Metal Minimalism

## Features
- Minimal startup files (`startup.s`, `linker.ld`, `main.c`)
- No vendor library dependencies 
- Modular project templates for different MCU families

## Installation

### Prerequisites
#### Core
- rsync
- tree (**NOT MANDATORY**, script will fallback to ls -R if not found)
#### Family-Specific
- GNU ARM Toolchain (`arm-none-eabi-gcc`, `arm-none-eabi-ld`)
- stlink-tools (`st-flash`)

### Installation Commands
```bash
git clone https://github.com/NamesE4044/ustart.git
cd ustart
bash install.sh
```

## Usage
```bash
ustart new --name new_project --dest . --template STM32F1 --variant f103c8t6 --readme n
```
- Generates a new project named "new_project" in the current working directory targeting a STM32F103C8T6 MCU and skips generating a README.md file

## Currently Supported MCU Families
- STM32F1xx

## Roadmap
### Future MCU Family Support
- STM32F4xx (Cortex-M4)
- GD32VF1xx (RISC-V)

## License
μstart - Copyright © 2025 Eric Robyn-Hardy
This project is licensed under the MIT License.
See the [LICENSE](./LICENSE) file for full details.
