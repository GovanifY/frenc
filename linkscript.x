OUTPUT_ARCH(h8300:h8300s)
ENTRY(_startp)


MEMORY
{
	rom (rx) : ORIGIN = 0x0, LENGTH = 128K
	ram (!rx): ORIGIN = 0xffe080, LENGTH = 3968
	tiny (!rx): ORIGIN = 0xffff00, LENGTH = 128
}

SECTIONS 
{
	.vectors 0x0 : { *(.vectors) } >rom
	.text 0x200 : {
		*(.text);
		*(.rodata);
		_etext = ALIGN(4);
	} >rom

	.data : {
		_rom_data = LOADADDR(.data);
		_data = .;
		*(.data);
		_edata = .;
	} >ram AT>rom

	.bss : {
		_bss = .;
		*(.bss);
		_ebss = .;
	} >ram

	.stack : {
		_stack_last = .;
		. += 0x80;
		_stack = .;
		_stack_first = .;
		*(.stack)
	} >ram
}
