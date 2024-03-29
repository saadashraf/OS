#ifndef _KERN_LIB_TRAP_H_
#define _KERN_LIB_TRAP_H_

#define PFE_PR		0x1	/* Page fault caused by protection violation */


typedef
struct pushregs {
	uint32_t edi;
	uint32_t esi;
	uint32_t ebp;
	uint32_t oesp;		/* Useless */
	uint32_t ebx;
	uint32_t edx;
	uint32_t ecx;
	uint32_t eax;
} pushregs;

typedef
struct tf_t {
	/* registers and other info we push manually in trapasm.S */
	pushregs regs;
	uint16_t es;		uint16_t padding_es;
	uint16_t ds;		uint16_t padding_ds;
	uint32_t trapno;

	/* format from here on determined by x86 hardware architecture */
	uint32_t err;
	uintptr_t eip;
	uint16_t cs;		uint16_t padding_cs;
	uint32_t eflags;

	/* rest included only when crossing rings, e.g., user to kernel */
	uintptr_t esp;
	uint16_t ss;		uint16_t padding_ss;
} tf_t;

void trap_return(tf_t *);

#endif /* !_KERN_LIB_TRAP_H_ */