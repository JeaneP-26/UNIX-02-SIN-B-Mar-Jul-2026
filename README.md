El sistema que vamos a construir tiene tres componentes:

1. **Kernel Linux** - el nucleo del sistema operativo.
2. **BusyBox** - proporciona las utilidades basicas de Unix (ls, pwd, vi,etc.) en un solo binario
3. **Syslinux** - el bootloader que carga todo al arrancar

sudo apt update:
sudo apt upgrade: 
sudo apt install -y git vim make gcc libncurses-dev flex bison bc cpio libelf-dev libssl-dev syslinux dosfstools qemu-system-x86


**Para que sirve cada paquete?**
- `gcc` , `make` - compilacion del kernel y BusyBox
- `libncurses-dev` -menus interactivos de configuracion (`menuconfig`)
- `flex` , `bison` , `bc` - requeridos por el proceso de build del kernel
- `cpio` - para crear el inittramfs
- `libelf-dev` , `libssl-dev` - dependencias del kernel
- `syslinux` - el bootloader
- `dosfstools` - para crear el filesystem FAT
- `qemu-system-x86` - para probar la imagen sin neecsidad de hardware real

Clona el repositorio del kernel (solo el ultimo commit para ahorrar tiempo y espacio):
git clone --depth 1 https://github.com/torvalds/linux.git
cd linux
make menuconfig
make -j 2
