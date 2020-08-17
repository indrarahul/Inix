C_SOURCES = $(wildcard kernel/*.c drivers/*.c)
HEADERS = $(wildcard kernel/*.h drivers/*.h)

OBJ = ${C_SOURCES:.c=.o}

all: os-image

run: all
	qemu-system-i386 -fda os-image

os-image: boot/boot_sector.bin kernel.bin
	cat $^ > os-image

kernel.bin: boot/kernel_entry.o ${OBJ}
	ld -o $@ -Ttext 0x1000 $^ --oformat binary

%.o : %.c ${HEADERS}
	gcc -ffreestanding -c $< -o $@

%.o : %.asm
	nasm $< -f elf64 -o $@

%.bin : %.asm
	nasm $< -f bin -o $@

clean:
	rm -fr *.bin *.dis *.o os-image
	rm -fr kernel/*.o boot/*.bin boot/*.o drivers/*.o