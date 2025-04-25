# **μstart**
**μstart** is a CLI Firmware Development Project Generator Focused on Bare-Metal Minimalism

## Features
- Minimal startup files (startup.s, linker.ld, main.c)
- No vendor library dependencies 
- Modular project templates for different MCU families

## Installation

### Prerequisites
- rsync

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
