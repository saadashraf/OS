
obj/boot/boot1.elf:     file format elf32-i386


Disassembly of section .text:

00007e00 <start>:
    7e00:	fa                   	cli    
    7e01:	fc                   	cld    

00007e02 <seta20.1>:
    7e02:	e4 64                	in     $0x64,%al
    7e04:	a8 02                	test   $0x2,%al
    7e06:	75 fa                	jne    7e02 <seta20.1>
    7e08:	b0 d1                	mov    $0xd1,%al
    7e0a:	e6 64                	out    %al,$0x64

00007e0c <seta20.2>:
    7e0c:	e4 64                	in     $0x64,%al
    7e0e:	a8 02                	test   $0x2,%al
    7e10:	75 fa                	jne    7e0c <seta20.2>
    7e12:	b0 df                	mov    $0xdf,%al
    7e14:	e6 60                	out    %al,$0x60

00007e16 <set_video_mode.2>:
    7e16:	be ab 7e e8 81       	mov    $0x81e87eab,%esi
    7e1b:	00               	add    %ah,0x31(%esi)

00007e1c <e820>:
    7e1c:	66 31 db             	xor    %bx,%bx
    7e1f:	66 ba 50 41          	mov    $0x4150,%dx
    7e23:	4d                   	dec    %ebp
    7e24:	53                   	push   %ebx
    7e25:	bf 2a 7f         	mov    $0xb9667f2a,%edi

00007e28 <e820.1>:
    7e28:	66 b9 14 00          	mov    $0x14,%cx
    7e2c:	00 00                	add    %al,(%eax)
    7e2e:	66 b8 20 e8          	mov    $0xe820,%ax
    7e32:	00 00                	add    %al,(%eax)
    7e34:	cd 15                	int    $0x15

00007e36 <e820.2>:
    7e36:	72 24                	jb     7e5c <e820.fail>
    7e38:	66 3d 50 41          	cmp    $0x4150,%ax
    7e3c:	4d                   	dec    %ebp
    7e3d:	53                   	push   %ebx
    7e3e:	75 1c                	jne    7e5c <e820.fail>

00007e40 <e820.3>:
    7e40:	66 c7 45 fc 14 00    	movw   $0x14,-0x4(%ebp)
    7e46:	00 00                	add    %al,(%eax)
    7e48:	83 c7 18             	add    $0x18,%edi
    7e4b:	66 83 fb 00          	cmp    $0x0,%bx
    7e4f:	74 02                	je     7e53 <e820.4>
    7e51:	eb d5                	jmp    7e28 <e820.1>

00007e53 <e820.4>:
    7e53:	30 c0                	xor    %al,%al
    7e55:	b9 14 00 f3 aa       	mov    $0xaaf30014,%ecx
    7e5a:	eb 09                	jmp    7e65 <switch_prot>

00007e5c <e820.fail>:
    7e5c:	be bd 7e e8 3b       	mov    $0x3be87ebd,%esi
    7e61:	00 eb                	add    %ch,%bl
    7e63:	00                 	add    %dh,%ah

00007e64 <spin16>:
    7e64:	f4                   	hlt    

00007e65 <switch_prot>:
    7e65:	0f 01 16             	lgdtl  (%esi)
    7e68:	20 7f 0f             	and    %bh,0xf(%edi)
    7e6b:	20 c0                	and    %al,%al
    7e6d:	66 83 c8 01          	or     $0x1,%ax
    7e71:	0f 22 c0             	mov    %eax,%cr0
    7e74:	ea 79 7e 08 00   	ljmp   $0xb866,$0x87e79

00007e79 <protcseg>:
    7e79:	66 b8 10 00          	mov    $0x10,%ax
    7e7d:	8e d8                	mov    %eax,%ds
    7e7f:	8e c0                	mov    %eax,%es
    7e81:	8e e0                	mov    %eax,%fs
    7e83:	8e e8                	mov    %eax,%gs
    7e85:	8e d0                	mov    %eax,%ss
    7e87:	68 26 7f 00 00       	push   $0x7f26
    7e8c:	68 00 7c 00 00       	push   $0x7c00
    7e91:	a1 fc 7b 00 00       	mov    0x7bfc,%eax
    7e96:	50                   	push   %eax
    7e97:	e8 32 10 00 00       	call   8ece <boot1main>

00007e9c <spin>:
    7e9c:	f4                   	hlt    

00007e9d <putstr>:
    7e9d:	60                   	pusha  
    7e9e:	b4 0e                	mov    $0xe,%ah

00007ea0 <putstr.1>:
    7ea0:	ac                   	lods   %ds:(%esi),%al
    7ea1:	3c 00                	cmp    $0x0,%al
    7ea3:	74 04                	je     7ea9 <putstr.2>
    7ea5:	cd 10                	int    $0x10
    7ea7:	eb f7                	jmp    7ea0 <putstr.1>

00007ea9 <putstr.2>:
    7ea9:	61                   	popa   
    7eaa:	c3                   	ret    

00007eab <STARTUP_MSG>:
    7eab:	53                   	push   %ebx
    7eac:	74 61                	je     7f0f <gdt+0x17>
    7eae:	72 74                	jb     7f24 <gdtdesc+0x4>
    7eb0:	20 62 6f             	and    %ah,0x6f(%edx)
    7eb3:	6f                   	outsl  %ds:(%esi),(%dx)
    7eb4:	74 31                	je     7ee7 <NO_BOOTABLE_MSG+0x8>
    7eb6:	20 2e                	and    %ch,(%esi)
    7eb8:	2e 2e 0d 0a 00   	cs cs or $0x7265000a,%eax

00007ebd <E820_FAIL_MSG>:
    7ebd:	65 72 72             	gs jb  7f32 <smap+0xc>
    7ec0:	6f                   	outsl  %ds:(%esi),(%dx)
    7ec1:	72 20                	jb     7ee3 <NO_BOOTABLE_MSG+0x4>
    7ec3:	77 68                	ja     7f2d <smap+0x7>
    7ec5:	65 6e                	outsb  %gs:(%esi),(%dx)
    7ec7:	20 64 65 74          	and    %ah,0x74(%ebp,%eiz,2)
    7ecb:	65 63 74 69 6e       	arpl   %si,%gs:0x6e(%ecx,%ebp,2)
    7ed0:	67 20 6d 65          	and    %ch,0x65(%di)
    7ed4:	6d                   	insl   (%dx),%es:(%edi)
    7ed5:	6f                   	outsl  %ds:(%esi),(%dx)
    7ed6:	72 79                	jb     7f51 <smap+0x2b>
    7ed8:	20 6d 61             	and    %ch,0x61(%ebp)
    7edb:	70 0d                	jo     7eea <NO_BOOTABLE_MSG+0xb>
    7edd:	0a 00                	or     (%eax),%al

00007edf <NO_BOOTABLE_MSG>:
    7edf:	4e                   	dec    %esi
    7ee0:	6f                   	outsl  %ds:(%esi),(%dx)
    7ee1:	20 62 6f             	and    %ah,0x6f(%edx)
    7ee4:	6f                   	outsl  %ds:(%esi),(%dx)
    7ee5:	74 61                	je     7f48 <smap+0x22>
    7ee7:	62 6c 65 20          	bound  %ebp,0x20(%ebp,%eiz,2)
    7eeb:	70 61                	jo     7f4e <smap+0x28>
    7eed:	72 74                	jb     7f63 <smap+0x3d>
    7eef:	69 74 69 6f 6e 2e 0d 	imul   $0xa0d2e6e,0x6f(%ecx,%ebp,2),%esi
    7ef6:	0a 
    7ef7:	00                 	add    %al,(%eax)

00007ef8 <gdt>:
    7ef8:	00 00                	add    %al,(%eax)
    7efa:	00 00                	add    %al,(%eax)
    7efc:	00 00                	add    %al,(%eax)
    7efe:	00 00                	add    %al,(%eax)
    7f00:	ff                   	(bad)  
    7f01:	ff 00                	incl   (%eax)
    7f03:	00 00                	add    %al,(%eax)
    7f05:	9a cf 00 ff ff 00 00 	lcall  $0x0,$0xffff00cf
    7f0c:	00 92 cf 00 ff ff    	add    %dl,-0xff31(%edx)
    7f12:	00 00                	add    %al,(%eax)
    7f14:	00 9e 00 00 ff ff    	add    %bl,-0x10000(%esi)
    7f1a:	00 00                	add    %al,(%eax)
    7f1c:	00 92 00 00      	add    %dl,0x270000(%edx)

00007f20 <gdtdesc>:
    7f20:	27                   	daa    
    7f21:	00 f8                	add    %bh,%al
    7f23:	7e 00                	jle    7f25 <gdtdesc+0x5>
    7f25:	00                 	add    %al,(%eax)

00007f26 <smap>:
    7f26:	00 00                	add    %al,(%eax)
    7f28:	00 00                	add    %al,(%eax)
    7f2a:	00 00                	add    %al,(%eax)
    7f2c:	00 00                	add    %al,(%eax)
    7f2e:	00 00                	add    %al,(%eax)
    7f30:	00 00                	add    %al,(%eax)
    7f32:	00 00                	add    %al,(%eax)
    7f34:	00 00                	add    %al,(%eax)
    7f36:	00 00                	add    %al,(%eax)
    7f38:	00 00                	add    %al,(%eax)
    7f3a:	00 00                	add    %al,(%eax)
    7f3c:	00 00                	add    %al,(%eax)
    7f3e:	00 00                	add    %al,(%eax)
    7f40:	00 00                	add    %al,(%eax)
    7f42:	00 00                	add    %al,(%eax)
    7f44:	00 00                	add    %al,(%eax)
    7f46:	00 00                	add    %al,(%eax)
    7f48:	00 00                	add    %al,(%eax)
    7f4a:	00 00                	add    %al,(%eax)
    7f4c:	00 00                	add    %al,(%eax)
    7f4e:	00 00                	add    %al,(%eax)
    7f50:	00 00                	add    %al,(%eax)
    7f52:	00 00                	add    %al,(%eax)
    7f54:	00 00                	add    %al,(%eax)
    7f56:	00 00                	add    %al,(%eax)
    7f58:	00 00                	add    %al,(%eax)
    7f5a:	00 00                	add    %al,(%eax)
    7f5c:	00 00                	add    %al,(%eax)
    7f5e:	00 00                	add    %al,(%eax)
    7f60:	00 00                	add    %al,(%eax)
    7f62:	00 00                	add    %al,(%eax)
    7f64:	00 00                	add    %al,(%eax)
    7f66:	00 00                	add    %al,(%eax)
    7f68:	00 00                	add    %al,(%eax)
    7f6a:	00 00                	add    %al,(%eax)
    7f6c:	00 00                	add    %al,(%eax)
    7f6e:	00 00                	add    %al,(%eax)
    7f70:	00 00                	add    %al,(%eax)
    7f72:	00 00                	add    %al,(%eax)
    7f74:	00 00                	add    %al,(%eax)
    7f76:	00 00                	add    %al,(%eax)
    7f78:	00 00                	add    %al,(%eax)
    7f7a:	00 00                	add    %al,(%eax)
    7f7c:	00 00                	add    %al,(%eax)
    7f7e:	00 00                	add    %al,(%eax)
    7f80:	00 00                	add    %al,(%eax)
    7f82:	00 00                	add    %al,(%eax)
    7f84:	00 00                	add    %al,(%eax)
    7f86:	00 00                	add    %al,(%eax)
    7f88:	00 00                	add    %al,(%eax)
    7f8a:	00 00                	add    %al,(%eax)
    7f8c:	00 00                	add    %al,(%eax)
    7f8e:	00 00                	add    %al,(%eax)
    7f90:	00 00                	add    %al,(%eax)
    7f92:	00 00                	add    %al,(%eax)
    7f94:	00 00                	add    %al,(%eax)
    7f96:	00 00                	add    %al,(%eax)
    7f98:	00 00                	add    %al,(%eax)
    7f9a:	00 00                	add    %al,(%eax)
    7f9c:	00 00                	add    %al,(%eax)
    7f9e:	00 00                	add    %al,(%eax)
    7fa0:	00 00                	add    %al,(%eax)
    7fa2:	00 00                	add    %al,(%eax)
    7fa4:	00 00                	add    %al,(%eax)
    7fa6:	00 00                	add    %al,(%eax)
    7fa8:	00 00                	add    %al,(%eax)
    7faa:	00 00                	add    %al,(%eax)
    7fac:	00 00                	add    %al,(%eax)
    7fae:	00 00                	add    %al,(%eax)
    7fb0:	00 00                	add    %al,(%eax)
    7fb2:	00 00                	add    %al,(%eax)
    7fb4:	00 00                	add    %al,(%eax)
    7fb6:	00 00                	add    %al,(%eax)
    7fb8:	00 00                	add    %al,(%eax)
    7fba:	00 00                	add    %al,(%eax)
    7fbc:	00 00                	add    %al,(%eax)
    7fbe:	00 00                	add    %al,(%eax)
    7fc0:	00 00                	add    %al,(%eax)
    7fc2:	00 00                	add    %al,(%eax)
    7fc4:	00 00                	add    %al,(%eax)
    7fc6:	00 00                	add    %al,(%eax)
    7fc8:	00 00                	add    %al,(%eax)
    7fca:	00 00                	add    %al,(%eax)
    7fcc:	00 00                	add    %al,(%eax)
    7fce:	00 00                	add    %al,(%eax)
    7fd0:	00 00                	add    %al,(%eax)
    7fd2:	00 00                	add    %al,(%eax)
    7fd4:	00 00                	add    %al,(%eax)
    7fd6:	00 00                	add    %al,(%eax)
    7fd8:	00 00                	add    %al,(%eax)
    7fda:	00 00                	add    %al,(%eax)
    7fdc:	00 00                	add    %al,(%eax)
    7fde:	00 00                	add    %al,(%eax)
    7fe0:	00 00                	add    %al,(%eax)
    7fe2:	00 00                	add    %al,(%eax)
    7fe4:	00 00                	add    %al,(%eax)
    7fe6:	00 00                	add    %al,(%eax)
    7fe8:	00 00                	add    %al,(%eax)
    7fea:	00 00                	add    %al,(%eax)
    7fec:	00 00                	add    %al,(%eax)
    7fee:	00 00                	add    %al,(%eax)
    7ff0:	00 00                	add    %al,(%eax)
    7ff2:	00 00                	add    %al,(%eax)
    7ff4:	00 00                	add    %al,(%eax)
    7ff6:	00 00                	add    %al,(%eax)
    7ff8:	00 00                	add    %al,(%eax)
    7ffa:	00 00                	add    %al,(%eax)
    7ffc:	00 00                	add    %al,(%eax)
    7ffe:	00 00                	add    %al,(%eax)
    8000:	00 00                	add    %al,(%eax)
    8002:	00 00                	add    %al,(%eax)
    8004:	00 00                	add    %al,(%eax)
    8006:	00 00                	add    %al,(%eax)
    8008:	00 00                	add    %al,(%eax)
    800a:	00 00                	add    %al,(%eax)
    800c:	00 00                	add    %al,(%eax)
    800e:	00 00                	add    %al,(%eax)
    8010:	00 00                	add    %al,(%eax)
    8012:	00 00                	add    %al,(%eax)
    8014:	00 00                	add    %al,(%eax)
    8016:	00 00                	add    %al,(%eax)
    8018:	00 00                	add    %al,(%eax)
    801a:	00 00                	add    %al,(%eax)
    801c:	00 00                	add    %al,(%eax)
    801e:	00 00                	add    %al,(%eax)
    8020:	00 00                	add    %al,(%eax)
    8022:	00 00                	add    %al,(%eax)
    8024:	00 00                	add    %al,(%eax)
    8026:	00 00                	add    %al,(%eax)
    8028:	00 00                	add    %al,(%eax)
    802a:	00 00                	add    %al,(%eax)
    802c:	00 00                	add    %al,(%eax)
    802e:	00 00                	add    %al,(%eax)
    8030:	00 00                	add    %al,(%eax)
    8032:	00 00                	add    %al,(%eax)
    8034:	00 00                	add    %al,(%eax)
    8036:	00 00                	add    %al,(%eax)
    8038:	00 00                	add    %al,(%eax)
    803a:	00 00                	add    %al,(%eax)
    803c:	00 00                	add    %al,(%eax)
    803e:	00 00                	add    %al,(%eax)
    8040:	00 00                	add    %al,(%eax)
    8042:	00 00                	add    %al,(%eax)
    8044:	00 00                	add    %al,(%eax)
    8046:	00 00                	add    %al,(%eax)
    8048:	00 00                	add    %al,(%eax)
    804a:	00 00                	add    %al,(%eax)
    804c:	00 00                	add    %al,(%eax)
    804e:	00 00                	add    %al,(%eax)
    8050:	00 00                	add    %al,(%eax)
    8052:	00 00                	add    %al,(%eax)
    8054:	00 00                	add    %al,(%eax)
    8056:	00 00                	add    %al,(%eax)
    8058:	00 00                	add    %al,(%eax)
    805a:	00 00                	add    %al,(%eax)
    805c:	00 00                	add    %al,(%eax)
    805e:	00 00                	add    %al,(%eax)
    8060:	00 00                	add    %al,(%eax)
    8062:	00 00                	add    %al,(%eax)
    8064:	00 00                	add    %al,(%eax)
    8066:	00 00                	add    %al,(%eax)
    8068:	00 00                	add    %al,(%eax)
    806a:	00 00                	add    %al,(%eax)
    806c:	00 00                	add    %al,(%eax)
    806e:	00 00                	add    %al,(%eax)
    8070:	00 00                	add    %al,(%eax)
    8072:	00 00                	add    %al,(%eax)
    8074:	00 00                	add    %al,(%eax)
    8076:	00 00                	add    %al,(%eax)
    8078:	00 00                	add    %al,(%eax)
    807a:	00 00                	add    %al,(%eax)
    807c:	00 00                	add    %al,(%eax)
    807e:	00 00                	add    %al,(%eax)
    8080:	00 00                	add    %al,(%eax)
    8082:	00 00                	add    %al,(%eax)
    8084:	00 00                	add    %al,(%eax)
    8086:	00 00                	add    %al,(%eax)
    8088:	00 00                	add    %al,(%eax)
    808a:	00 00                	add    %al,(%eax)
    808c:	00 00                	add    %al,(%eax)
    808e:	00 00                	add    %al,(%eax)
    8090:	00 00                	add    %al,(%eax)
    8092:	00 00                	add    %al,(%eax)
    8094:	00 00                	add    %al,(%eax)
    8096:	00 00                	add    %al,(%eax)
    8098:	00 00                	add    %al,(%eax)
    809a:	00 00                	add    %al,(%eax)
    809c:	00 00                	add    %al,(%eax)
    809e:	00 00                	add    %al,(%eax)
    80a0:	00 00                	add    %al,(%eax)
    80a2:	00 00                	add    %al,(%eax)
    80a4:	00 00                	add    %al,(%eax)
    80a6:	00 00                	add    %al,(%eax)
    80a8:	00 00                	add    %al,(%eax)
    80aa:	00 00                	add    %al,(%eax)
    80ac:	00 00                	add    %al,(%eax)
    80ae:	00 00                	add    %al,(%eax)
    80b0:	00 00                	add    %al,(%eax)
    80b2:	00 00                	add    %al,(%eax)
    80b4:	00 00                	add    %al,(%eax)
    80b6:	00 00                	add    %al,(%eax)
    80b8:	00 00                	add    %al,(%eax)
    80ba:	00 00                	add    %al,(%eax)
    80bc:	00 00                	add    %al,(%eax)
    80be:	00 00                	add    %al,(%eax)
    80c0:	00 00                	add    %al,(%eax)
    80c2:	00 00                	add    %al,(%eax)
    80c4:	00 00                	add    %al,(%eax)
    80c6:	00 00                	add    %al,(%eax)
    80c8:	00 00                	add    %al,(%eax)
    80ca:	00 00                	add    %al,(%eax)
    80cc:	00 00                	add    %al,(%eax)
    80ce:	00 00                	add    %al,(%eax)
    80d0:	00 00                	add    %al,(%eax)
    80d2:	00 00                	add    %al,(%eax)
    80d4:	00 00                	add    %al,(%eax)
    80d6:	00 00                	add    %al,(%eax)
    80d8:	00 00                	add    %al,(%eax)
    80da:	00 00                	add    %al,(%eax)
    80dc:	00 00                	add    %al,(%eax)
    80de:	00 00                	add    %al,(%eax)
    80e0:	00 00                	add    %al,(%eax)
    80e2:	00 00                	add    %al,(%eax)
    80e4:	00 00                	add    %al,(%eax)
    80e6:	00 00                	add    %al,(%eax)
    80e8:	00 00                	add    %al,(%eax)
    80ea:	00 00                	add    %al,(%eax)
    80ec:	00 00                	add    %al,(%eax)
    80ee:	00 00                	add    %al,(%eax)
    80f0:	00 00                	add    %al,(%eax)
    80f2:	00 00                	add    %al,(%eax)
    80f4:	00 00                	add    %al,(%eax)
    80f6:	00 00                	add    %al,(%eax)
    80f8:	00 00                	add    %al,(%eax)
    80fa:	00 00                	add    %al,(%eax)
    80fc:	00 00                	add    %al,(%eax)
    80fe:	00 00                	add    %al,(%eax)
    8100:	00 00                	add    %al,(%eax)
    8102:	00 00                	add    %al,(%eax)
    8104:	00 00                	add    %al,(%eax)
    8106:	00 00                	add    %al,(%eax)
    8108:	00 00                	add    %al,(%eax)
    810a:	00 00                	add    %al,(%eax)
    810c:	00 00                	add    %al,(%eax)
    810e:	00 00                	add    %al,(%eax)
    8110:	00 00                	add    %al,(%eax)
    8112:	00 00                	add    %al,(%eax)
    8114:	00 00                	add    %al,(%eax)
    8116:	00 00                	add    %al,(%eax)
    8118:	00 00                	add    %al,(%eax)
    811a:	00 00                	add    %al,(%eax)
    811c:	00 00                	add    %al,(%eax)
    811e:	00 00                	add    %al,(%eax)
    8120:	00 00                	add    %al,(%eax)
    8122:	00 00                	add    %al,(%eax)
    8124:	00 00                	add    %al,(%eax)
    8126:	00 00                	add    %al,(%eax)
    8128:	00 00                	add    %al,(%eax)
    812a:	00 00                	add    %al,(%eax)
    812c:	00 00                	add    %al,(%eax)
    812e:	00 00                	add    %al,(%eax)
    8130:	00 00                	add    %al,(%eax)
    8132:	00 00                	add    %al,(%eax)
    8134:	00 00                	add    %al,(%eax)
    8136:	00 00                	add    %al,(%eax)
    8138:	00 00                	add    %al,(%eax)
    813a:	00 00                	add    %al,(%eax)
    813c:	00 00                	add    %al,(%eax)
    813e:	00 00                	add    %al,(%eax)
    8140:	00 00                	add    %al,(%eax)
    8142:	00 00                	add    %al,(%eax)
    8144:	00 00                	add    %al,(%eax)
    8146:	00 00                	add    %al,(%eax)
    8148:	00 00                	add    %al,(%eax)
    814a:	00 00                	add    %al,(%eax)
    814c:	00 00                	add    %al,(%eax)
    814e:	00 00                	add    %al,(%eax)
    8150:	00 00                	add    %al,(%eax)
    8152:	00 00                	add    %al,(%eax)
    8154:	00 00                	add    %al,(%eax)
    8156:	00 00                	add    %al,(%eax)
    8158:	00 00                	add    %al,(%eax)
    815a:	00 00                	add    %al,(%eax)
    815c:	00 00                	add    %al,(%eax)
    815e:	00 00                	add    %al,(%eax)
    8160:	00 00                	add    %al,(%eax)
    8162:	00 00                	add    %al,(%eax)
    8164:	00 00                	add    %al,(%eax)
    8166:	00 00                	add    %al,(%eax)
    8168:	00 00                	add    %al,(%eax)
    816a:	00 00                	add    %al,(%eax)
    816c:	00 00                	add    %al,(%eax)
    816e:	00 00                	add    %al,(%eax)
    8170:	00 00                	add    %al,(%eax)
    8172:	00 00                	add    %al,(%eax)
    8174:	00 00                	add    %al,(%eax)
    8176:	00 00                	add    %al,(%eax)
    8178:	00 00                	add    %al,(%eax)
    817a:	00 00                	add    %al,(%eax)
    817c:	00 00                	add    %al,(%eax)
    817e:	00 00                	add    %al,(%eax)
    8180:	00 00                	add    %al,(%eax)
    8182:	00 00                	add    %al,(%eax)
    8184:	00 00                	add    %al,(%eax)
    8186:	00 00                	add    %al,(%eax)
    8188:	00 00                	add    %al,(%eax)
    818a:	00 00                	add    %al,(%eax)
    818c:	00 00                	add    %al,(%eax)
    818e:	00 00                	add    %al,(%eax)
    8190:	00 00                	add    %al,(%eax)
    8192:	00 00                	add    %al,(%eax)
    8194:	00 00                	add    %al,(%eax)
    8196:	00 00                	add    %al,(%eax)
    8198:	00 00                	add    %al,(%eax)
    819a:	00 00                	add    %al,(%eax)
    819c:	00 00                	add    %al,(%eax)
    819e:	00 00                	add    %al,(%eax)
    81a0:	00 00                	add    %al,(%eax)
    81a2:	00 00                	add    %al,(%eax)
    81a4:	00 00                	add    %al,(%eax)
    81a6:	00 00                	add    %al,(%eax)
    81a8:	00 00                	add    %al,(%eax)
    81aa:	00 00                	add    %al,(%eax)
    81ac:	00 00                	add    %al,(%eax)
    81ae:	00 00                	add    %al,(%eax)
    81b0:	00 00                	add    %al,(%eax)
    81b2:	00 00                	add    %al,(%eax)
    81b4:	00 00                	add    %al,(%eax)
    81b6:	00 00                	add    %al,(%eax)
    81b8:	00 00                	add    %al,(%eax)
    81ba:	00 00                	add    %al,(%eax)
    81bc:	00 00                	add    %al,(%eax)
    81be:	00 00                	add    %al,(%eax)
    81c0:	00 00                	add    %al,(%eax)
    81c2:	00 00                	add    %al,(%eax)
    81c4:	00 00                	add    %al,(%eax)
    81c6:	00 00                	add    %al,(%eax)
    81c8:	00 00                	add    %al,(%eax)
    81ca:	00 00                	add    %al,(%eax)
    81cc:	00 00                	add    %al,(%eax)
    81ce:	00 00                	add    %al,(%eax)
    81d0:	00 00                	add    %al,(%eax)
    81d2:	00 00                	add    %al,(%eax)
    81d4:	00 00                	add    %al,(%eax)
    81d6:	00 00                	add    %al,(%eax)
    81d8:	00 00                	add    %al,(%eax)
    81da:	00 00                	add    %al,(%eax)
    81dc:	00 00                	add    %al,(%eax)
    81de:	00 00                	add    %al,(%eax)
    81e0:	00 00                	add    %al,(%eax)
    81e2:	00 00                	add    %al,(%eax)
    81e4:	00 00                	add    %al,(%eax)
    81e6:	00 00                	add    %al,(%eax)
    81e8:	00 00                	add    %al,(%eax)
    81ea:	00 00                	add    %al,(%eax)
    81ec:	00 00                	add    %al,(%eax)
    81ee:	00 00                	add    %al,(%eax)
    81f0:	00 00                	add    %al,(%eax)
    81f2:	00 00                	add    %al,(%eax)
    81f4:	00 00                	add    %al,(%eax)
    81f6:	00 00                	add    %al,(%eax)
    81f8:	00 00                	add    %al,(%eax)
    81fa:	00 00                	add    %al,(%eax)
    81fc:	00 00                	add    %al,(%eax)
    81fe:	00 00                	add    %al,(%eax)
    8200:	00 00                	add    %al,(%eax)
    8202:	00 00                	add    %al,(%eax)
    8204:	00 00                	add    %al,(%eax)
    8206:	00 00                	add    %al,(%eax)
    8208:	00 00                	add    %al,(%eax)
    820a:	00 00                	add    %al,(%eax)
    820c:	00 00                	add    %al,(%eax)
    820e:	00 00                	add    %al,(%eax)
    8210:	00 00                	add    %al,(%eax)
    8212:	00 00                	add    %al,(%eax)
    8214:	00 00                	add    %al,(%eax)
    8216:	00 00                	add    %al,(%eax)
    8218:	00 00                	add    %al,(%eax)
    821a:	00 00                	add    %al,(%eax)
    821c:	00 00                	add    %al,(%eax)
    821e:	00 00                	add    %al,(%eax)
    8220:	00 00                	add    %al,(%eax)
    8222:	00 00                	add    %al,(%eax)
    8224:	00 00                	add    %al,(%eax)
    8226:	00 00                	add    %al,(%eax)
    8228:	00 00                	add    %al,(%eax)
    822a:	00 00                	add    %al,(%eax)
    822c:	00 00                	add    %al,(%eax)
    822e:	00 00                	add    %al,(%eax)
    8230:	00 00                	add    %al,(%eax)
    8232:	00 00                	add    %al,(%eax)
    8234:	00 00                	add    %al,(%eax)
    8236:	00 00                	add    %al,(%eax)
    8238:	00 00                	add    %al,(%eax)
    823a:	00 00                	add    %al,(%eax)
    823c:	00 00                	add    %al,(%eax)
    823e:	00 00                	add    %al,(%eax)
    8240:	00 00                	add    %al,(%eax)
    8242:	00 00                	add    %al,(%eax)
    8244:	00 00                	add    %al,(%eax)
    8246:	00 00                	add    %al,(%eax)
    8248:	00 00                	add    %al,(%eax)
    824a:	00 00                	add    %al,(%eax)
    824c:	00 00                	add    %al,(%eax)
    824e:	00 00                	add    %al,(%eax)
    8250:	00 00                	add    %al,(%eax)
    8252:	00 00                	add    %al,(%eax)
    8254:	00 00                	add    %al,(%eax)
    8256:	00 00                	add    %al,(%eax)
    8258:	00 00                	add    %al,(%eax)
    825a:	00 00                	add    %al,(%eax)
    825c:	00 00                	add    %al,(%eax)
    825e:	00 00                	add    %al,(%eax)
    8260:	00 00                	add    %al,(%eax)
    8262:	00 00                	add    %al,(%eax)
    8264:	00 00                	add    %al,(%eax)
    8266:	00 00                	add    %al,(%eax)
    8268:	00 00                	add    %al,(%eax)
    826a:	00 00                	add    %al,(%eax)
    826c:	00 00                	add    %al,(%eax)
    826e:	00 00                	add    %al,(%eax)
    8270:	00 00                	add    %al,(%eax)
    8272:	00 00                	add    %al,(%eax)
    8274:	00 00                	add    %al,(%eax)
    8276:	00 00                	add    %al,(%eax)
    8278:	00 00                	add    %al,(%eax)
    827a:	00 00                	add    %al,(%eax)
    827c:	00 00                	add    %al,(%eax)
    827e:	00 00                	add    %al,(%eax)
    8280:	00 00                	add    %al,(%eax)
    8282:	00 00                	add    %al,(%eax)
    8284:	00 00                	add    %al,(%eax)
    8286:	00 00                	add    %al,(%eax)
    8288:	00 00                	add    %al,(%eax)
    828a:	00 00                	add    %al,(%eax)
    828c:	00 00                	add    %al,(%eax)
    828e:	00 00                	add    %al,(%eax)
    8290:	00 00                	add    %al,(%eax)
    8292:	00 00                	add    %al,(%eax)
    8294:	00 00                	add    %al,(%eax)
    8296:	00 00                	add    %al,(%eax)
    8298:	00 00                	add    %al,(%eax)
    829a:	00 00                	add    %al,(%eax)
    829c:	00 00                	add    %al,(%eax)
    829e:	00 00                	add    %al,(%eax)
    82a0:	00 00                	add    %al,(%eax)
    82a2:	00 00                	add    %al,(%eax)
    82a4:	00 00                	add    %al,(%eax)
    82a6:	00 00                	add    %al,(%eax)
    82a8:	00 00                	add    %al,(%eax)
    82aa:	00 00                	add    %al,(%eax)
    82ac:	00 00                	add    %al,(%eax)
    82ae:	00 00                	add    %al,(%eax)
    82b0:	00 00                	add    %al,(%eax)
    82b2:	00 00                	add    %al,(%eax)
    82b4:	00 00                	add    %al,(%eax)
    82b6:	00 00                	add    %al,(%eax)
    82b8:	00 00                	add    %al,(%eax)
    82ba:	00 00                	add    %al,(%eax)
    82bc:	00 00                	add    %al,(%eax)
    82be:	00 00                	add    %al,(%eax)
    82c0:	00 00                	add    %al,(%eax)
    82c2:	00 00                	add    %al,(%eax)
    82c4:	00 00                	add    %al,(%eax)
    82c6:	00 00                	add    %al,(%eax)
    82c8:	00 00                	add    %al,(%eax)
    82ca:	00 00                	add    %al,(%eax)
    82cc:	00 00                	add    %al,(%eax)
    82ce:	00 00                	add    %al,(%eax)
    82d0:	00 00                	add    %al,(%eax)
    82d2:	00 00                	add    %al,(%eax)
    82d4:	00 00                	add    %al,(%eax)
    82d6:	00 00                	add    %al,(%eax)
    82d8:	00 00                	add    %al,(%eax)
    82da:	00 00                	add    %al,(%eax)
    82dc:	00 00                	add    %al,(%eax)
    82de:	00 00                	add    %al,(%eax)
    82e0:	00 00                	add    %al,(%eax)
    82e2:	00 00                	add    %al,(%eax)
    82e4:	00 00                	add    %al,(%eax)
    82e6:	00 00                	add    %al,(%eax)
    82e8:	00 00                	add    %al,(%eax)
    82ea:	00 00                	add    %al,(%eax)
    82ec:	00 00                	add    %al,(%eax)
    82ee:	00 00                	add    %al,(%eax)
    82f0:	00 00                	add    %al,(%eax)
    82f2:	00 00                	add    %al,(%eax)
    82f4:	00 00                	add    %al,(%eax)
    82f6:	00 00                	add    %al,(%eax)
    82f8:	00 00                	add    %al,(%eax)
    82fa:	00 00                	add    %al,(%eax)
    82fc:	00 00                	add    %al,(%eax)
    82fe:	00 00                	add    %al,(%eax)
    8300:	00 00                	add    %al,(%eax)
    8302:	00 00                	add    %al,(%eax)
    8304:	00 00                	add    %al,(%eax)
    8306:	00 00                	add    %al,(%eax)
    8308:	00 00                	add    %al,(%eax)
    830a:	00 00                	add    %al,(%eax)
    830c:	00 00                	add    %al,(%eax)
    830e:	00 00                	add    %al,(%eax)
    8310:	00 00                	add    %al,(%eax)
    8312:	00 00                	add    %al,(%eax)
    8314:	00 00                	add    %al,(%eax)
    8316:	00 00                	add    %al,(%eax)
    8318:	00 00                	add    %al,(%eax)
    831a:	00 00                	add    %al,(%eax)
    831c:	00 00                	add    %al,(%eax)
    831e:	00 00                	add    %al,(%eax)
    8320:	00 00                	add    %al,(%eax)
    8322:	00 00                	add    %al,(%eax)
    8324:	00 00                	add    %al,(%eax)
    8326:	00 00                	add    %al,(%eax)
    8328:	00 00                	add    %al,(%eax)
    832a:	00 00                	add    %al,(%eax)
    832c:	00 00                	add    %al,(%eax)
    832e:	00 00                	add    %al,(%eax)
    8330:	00 00                	add    %al,(%eax)
    8332:	00 00                	add    %al,(%eax)
    8334:	00 00                	add    %al,(%eax)
    8336:	00 00                	add    %al,(%eax)
    8338:	00 00                	add    %al,(%eax)
    833a:	00 00                	add    %al,(%eax)
    833c:	00 00                	add    %al,(%eax)
    833e:	00 00                	add    %al,(%eax)
    8340:	00 00                	add    %al,(%eax)
    8342:	00 00                	add    %al,(%eax)
    8344:	00 00                	add    %al,(%eax)
    8346:	00 00                	add    %al,(%eax)
    8348:	00 00                	add    %al,(%eax)
    834a:	00 00                	add    %al,(%eax)
    834c:	00 00                	add    %al,(%eax)
    834e:	00 00                	add    %al,(%eax)
    8350:	00 00                	add    %al,(%eax)
    8352:	00 00                	add    %al,(%eax)
    8354:	00 00                	add    %al,(%eax)
    8356:	00 00                	add    %al,(%eax)
    8358:	00 00                	add    %al,(%eax)
    835a:	00 00                	add    %al,(%eax)
    835c:	00 00                	add    %al,(%eax)
    835e:	00 00                	add    %al,(%eax)
    8360:	00 00                	add    %al,(%eax)
    8362:	00 00                	add    %al,(%eax)
    8364:	00 00                	add    %al,(%eax)
    8366:	00 00                	add    %al,(%eax)
    8368:	00 00                	add    %al,(%eax)
    836a:	00 00                	add    %al,(%eax)
    836c:	00 00                	add    %al,(%eax)
    836e:	00 00                	add    %al,(%eax)
    8370:	00 00                	add    %al,(%eax)
    8372:	00 00                	add    %al,(%eax)
    8374:	00 00                	add    %al,(%eax)
    8376:	00 00                	add    %al,(%eax)
    8378:	00 00                	add    %al,(%eax)
    837a:	00 00                	add    %al,(%eax)
    837c:	00 00                	add    %al,(%eax)
    837e:	00 00                	add    %al,(%eax)
    8380:	00 00                	add    %al,(%eax)
    8382:	00 00                	add    %al,(%eax)
    8384:	00 00                	add    %al,(%eax)
    8386:	00 00                	add    %al,(%eax)
    8388:	00 00                	add    %al,(%eax)
    838a:	00 00                	add    %al,(%eax)
    838c:	00 00                	add    %al,(%eax)
    838e:	00 00                	add    %al,(%eax)
    8390:	00 00                	add    %al,(%eax)
    8392:	00 00                	add    %al,(%eax)
    8394:	00 00                	add    %al,(%eax)
    8396:	00 00                	add    %al,(%eax)
    8398:	00 00                	add    %al,(%eax)
    839a:	00 00                	add    %al,(%eax)
    839c:	00 00                	add    %al,(%eax)
    839e:	00 00                	add    %al,(%eax)
    83a0:	00 00                	add    %al,(%eax)
    83a2:	00 00                	add    %al,(%eax)
    83a4:	00 00                	add    %al,(%eax)
    83a6:	00 00                	add    %al,(%eax)
    83a8:	00 00                	add    %al,(%eax)
    83aa:	00 00                	add    %al,(%eax)
    83ac:	00 00                	add    %al,(%eax)
    83ae:	00 00                	add    %al,(%eax)
    83b0:	00 00                	add    %al,(%eax)
    83b2:	00 00                	add    %al,(%eax)
    83b4:	00 00                	add    %al,(%eax)
    83b6:	00 00                	add    %al,(%eax)
    83b8:	00 00                	add    %al,(%eax)
    83ba:	00 00                	add    %al,(%eax)
    83bc:	00 00                	add    %al,(%eax)
    83be:	00 00                	add    %al,(%eax)
    83c0:	00 00                	add    %al,(%eax)
    83c2:	00 00                	add    %al,(%eax)
    83c4:	00 00                	add    %al,(%eax)
    83c6:	00 00                	add    %al,(%eax)
    83c8:	00 00                	add    %al,(%eax)
    83ca:	00 00                	add    %al,(%eax)
    83cc:	00 00                	add    %al,(%eax)
    83ce:	00 00                	add    %al,(%eax)
    83d0:	00 00                	add    %al,(%eax)
    83d2:	00 00                	add    %al,(%eax)
    83d4:	00 00                	add    %al,(%eax)
    83d6:	00 00                	add    %al,(%eax)
    83d8:	00 00                	add    %al,(%eax)
    83da:	00 00                	add    %al,(%eax)
    83dc:	00 00                	add    %al,(%eax)
    83de:	00 00                	add    %al,(%eax)
    83e0:	00 00                	add    %al,(%eax)
    83e2:	00 00                	add    %al,(%eax)
    83e4:	00 00                	add    %al,(%eax)
    83e6:	00 00                	add    %al,(%eax)
    83e8:	00 00                	add    %al,(%eax)
    83ea:	00 00                	add    %al,(%eax)
    83ec:	00 00                	add    %al,(%eax)
    83ee:	00 00                	add    %al,(%eax)
    83f0:	00 00                	add    %al,(%eax)
    83f2:	00 00                	add    %al,(%eax)
    83f4:	00 00                	add    %al,(%eax)
    83f6:	00 00                	add    %al,(%eax)
    83f8:	00 00                	add    %al,(%eax)
    83fa:	00 00                	add    %al,(%eax)
    83fc:	00 00                	add    %al,(%eax)
    83fe:	00 00                	add    %al,(%eax)
    8400:	00 00                	add    %al,(%eax)
    8402:	00 00                	add    %al,(%eax)
    8404:	00 00                	add    %al,(%eax)
    8406:	00 00                	add    %al,(%eax)
    8408:	00 00                	add    %al,(%eax)
    840a:	00 00                	add    %al,(%eax)
    840c:	00 00                	add    %al,(%eax)
    840e:	00 00                	add    %al,(%eax)
    8410:	00 00                	add    %al,(%eax)
    8412:	00 00                	add    %al,(%eax)
    8414:	00 00                	add    %al,(%eax)
    8416:	00 00                	add    %al,(%eax)
    8418:	00 00                	add    %al,(%eax)
    841a:	00 00                	add    %al,(%eax)
    841c:	00 00                	add    %al,(%eax)
    841e:	00 00                	add    %al,(%eax)
    8420:	00 00                	add    %al,(%eax)
    8422:	00 00                	add    %al,(%eax)
    8424:	00 00                	add    %al,(%eax)
    8426:	00 00                	add    %al,(%eax)
    8428:	00 00                	add    %al,(%eax)
    842a:	00 00                	add    %al,(%eax)
    842c:	00 00                	add    %al,(%eax)
    842e:	00 00                	add    %al,(%eax)
    8430:	00 00                	add    %al,(%eax)
    8432:	00 00                	add    %al,(%eax)
    8434:	00 00                	add    %al,(%eax)
    8436:	00 00                	add    %al,(%eax)
    8438:	00 00                	add    %al,(%eax)
    843a:	00 00                	add    %al,(%eax)
    843c:	00 00                	add    %al,(%eax)
    843e:	00 00                	add    %al,(%eax)
    8440:	00 00                	add    %al,(%eax)
    8442:	00 00                	add    %al,(%eax)
    8444:	00 00                	add    %al,(%eax)
    8446:	00 00                	add    %al,(%eax)
    8448:	00 00                	add    %al,(%eax)
    844a:	00 00                	add    %al,(%eax)
    844c:	00 00                	add    %al,(%eax)
    844e:	00 00                	add    %al,(%eax)
    8450:	00 00                	add    %al,(%eax)
    8452:	00 00                	add    %al,(%eax)
    8454:	00 00                	add    %al,(%eax)
    8456:	00 00                	add    %al,(%eax)
    8458:	00 00                	add    %al,(%eax)
    845a:	00 00                	add    %al,(%eax)
    845c:	00 00                	add    %al,(%eax)
    845e:	00 00                	add    %al,(%eax)
    8460:	00 00                	add    %al,(%eax)
    8462:	00 00                	add    %al,(%eax)
    8464:	00 00                	add    %al,(%eax)
    8466:	00 00                	add    %al,(%eax)
    8468:	00 00                	add    %al,(%eax)
    846a:	00 00                	add    %al,(%eax)
    846c:	00 00                	add    %al,(%eax)
    846e:	00 00                	add    %al,(%eax)
    8470:	00 00                	add    %al,(%eax)
    8472:	00 00                	add    %al,(%eax)
    8474:	00 00                	add    %al,(%eax)
    8476:	00 00                	add    %al,(%eax)
    8478:	00 00                	add    %al,(%eax)
    847a:	00 00                	add    %al,(%eax)
    847c:	00 00                	add    %al,(%eax)
    847e:	00 00                	add    %al,(%eax)
    8480:	00 00                	add    %al,(%eax)
    8482:	00 00                	add    %al,(%eax)
    8484:	00 00                	add    %al,(%eax)
    8486:	00 00                	add    %al,(%eax)
    8488:	00 00                	add    %al,(%eax)
    848a:	00 00                	add    %al,(%eax)
    848c:	00 00                	add    %al,(%eax)
    848e:	00 00                	add    %al,(%eax)
    8490:	00 00                	add    %al,(%eax)
    8492:	00 00                	add    %al,(%eax)
    8494:	00 00                	add    %al,(%eax)
    8496:	00 00                	add    %al,(%eax)
    8498:	00 00                	add    %al,(%eax)
    849a:	00 00                	add    %al,(%eax)
    849c:	00 00                	add    %al,(%eax)
    849e:	00 00                	add    %al,(%eax)
    84a0:	00 00                	add    %al,(%eax)
    84a2:	00 00                	add    %al,(%eax)
    84a4:	00 00                	add    %al,(%eax)
    84a6:	00 00                	add    %al,(%eax)
    84a8:	00 00                	add    %al,(%eax)
    84aa:	00 00                	add    %al,(%eax)
    84ac:	00 00                	add    %al,(%eax)
    84ae:	00 00                	add    %al,(%eax)
    84b0:	00 00                	add    %al,(%eax)
    84b2:	00 00                	add    %al,(%eax)
    84b4:	00 00                	add    %al,(%eax)
    84b6:	00 00                	add    %al,(%eax)
    84b8:	00 00                	add    %al,(%eax)
    84ba:	00 00                	add    %al,(%eax)
    84bc:	00 00                	add    %al,(%eax)
    84be:	00 00                	add    %al,(%eax)
    84c0:	00 00                	add    %al,(%eax)
    84c2:	00 00                	add    %al,(%eax)
    84c4:	00 00                	add    %al,(%eax)
    84c6:	00 00                	add    %al,(%eax)
    84c8:	00 00                	add    %al,(%eax)
    84ca:	00 00                	add    %al,(%eax)
    84cc:	00 00                	add    %al,(%eax)
    84ce:	00 00                	add    %al,(%eax)
    84d0:	00 00                	add    %al,(%eax)
    84d2:	00 00                	add    %al,(%eax)
    84d4:	00 00                	add    %al,(%eax)
    84d6:	00 00                	add    %al,(%eax)
    84d8:	00 00                	add    %al,(%eax)
    84da:	00 00                	add    %al,(%eax)
    84dc:	00 00                	add    %al,(%eax)
    84de:	00 00                	add    %al,(%eax)
    84e0:	00 00                	add    %al,(%eax)
    84e2:	00 00                	add    %al,(%eax)
    84e4:	00 00                	add    %al,(%eax)
    84e6:	00 00                	add    %al,(%eax)
    84e8:	00 00                	add    %al,(%eax)
    84ea:	00 00                	add    %al,(%eax)
    84ec:	00 00                	add    %al,(%eax)
    84ee:	00 00                	add    %al,(%eax)
    84f0:	00 00                	add    %al,(%eax)
    84f2:	00 00                	add    %al,(%eax)
    84f4:	00 00                	add    %al,(%eax)
    84f6:	00 00                	add    %al,(%eax)
    84f8:	00 00                	add    %al,(%eax)
    84fa:	00 00                	add    %al,(%eax)
    84fc:	00 00                	add    %al,(%eax)
    84fe:	00 00                	add    %al,(%eax)
    8500:	00 00                	add    %al,(%eax)
    8502:	00 00                	add    %al,(%eax)
    8504:	00 00                	add    %al,(%eax)
    8506:	00 00                	add    %al,(%eax)
    8508:	00 00                	add    %al,(%eax)
    850a:	00 00                	add    %al,(%eax)
    850c:	00 00                	add    %al,(%eax)
    850e:	00 00                	add    %al,(%eax)
    8510:	00 00                	add    %al,(%eax)
    8512:	00 00                	add    %al,(%eax)
    8514:	00 00                	add    %al,(%eax)
    8516:	00 00                	add    %al,(%eax)
    8518:	00 00                	add    %al,(%eax)
    851a:	00 00                	add    %al,(%eax)
    851c:	00 00                	add    %al,(%eax)
    851e:	00 00                	add    %al,(%eax)
    8520:	00 00                	add    %al,(%eax)
    8522:	00 00                	add    %al,(%eax)
    8524:	00 00                	add    %al,(%eax)
    8526:	00 00                	add    %al,(%eax)
    8528:	00 00                	add    %al,(%eax)
    852a:	00 00                	add    %al,(%eax)
    852c:	00 00                	add    %al,(%eax)
    852e:	00 00                	add    %al,(%eax)
    8530:	00 00                	add    %al,(%eax)
    8532:	00 00                	add    %al,(%eax)
    8534:	00 00                	add    %al,(%eax)
    8536:	00 00                	add    %al,(%eax)
    8538:	00 00                	add    %al,(%eax)
    853a:	00 00                	add    %al,(%eax)
    853c:	00 00                	add    %al,(%eax)
    853e:	00 00                	add    %al,(%eax)
    8540:	00 00                	add    %al,(%eax)
    8542:	00 00                	add    %al,(%eax)
    8544:	00 00                	add    %al,(%eax)
    8546:	00 00                	add    %al,(%eax)
    8548:	00 00                	add    %al,(%eax)
    854a:	00 00                	add    %al,(%eax)
    854c:	00 00                	add    %al,(%eax)
    854e:	00 00                	add    %al,(%eax)
    8550:	00 00                	add    %al,(%eax)
    8552:	00 00                	add    %al,(%eax)
    8554:	00 00                	add    %al,(%eax)
    8556:	00 00                	add    %al,(%eax)
    8558:	00 00                	add    %al,(%eax)
    855a:	00 00                	add    %al,(%eax)
    855c:	00 00                	add    %al,(%eax)
    855e:	00 00                	add    %al,(%eax)
    8560:	00 00                	add    %al,(%eax)
    8562:	00 00                	add    %al,(%eax)
    8564:	00 00                	add    %al,(%eax)
    8566:	00 00                	add    %al,(%eax)
    8568:	00 00                	add    %al,(%eax)
    856a:	00 00                	add    %al,(%eax)
    856c:	00 00                	add    %al,(%eax)
    856e:	00 00                	add    %al,(%eax)
    8570:	00 00                	add    %al,(%eax)
    8572:	00 00                	add    %al,(%eax)
    8574:	00 00                	add    %al,(%eax)
    8576:	00 00                	add    %al,(%eax)
    8578:	00 00                	add    %al,(%eax)
    857a:	00 00                	add    %al,(%eax)
    857c:	00 00                	add    %al,(%eax)
    857e:	00 00                	add    %al,(%eax)
    8580:	00 00                	add    %al,(%eax)
    8582:	00 00                	add    %al,(%eax)
    8584:	00 00                	add    %al,(%eax)
    8586:	00 00                	add    %al,(%eax)
    8588:	00 00                	add    %al,(%eax)
    858a:	00 00                	add    %al,(%eax)
    858c:	00 00                	add    %al,(%eax)
    858e:	00 00                	add    %al,(%eax)
    8590:	00 00                	add    %al,(%eax)
    8592:	00 00                	add    %al,(%eax)
    8594:	00 00                	add    %al,(%eax)
    8596:	00 00                	add    %al,(%eax)
    8598:	00 00                	add    %al,(%eax)
    859a:	00 00                	add    %al,(%eax)
    859c:	00 00                	add    %al,(%eax)
    859e:	00 00                	add    %al,(%eax)
    85a0:	00 00                	add    %al,(%eax)
    85a2:	00 00                	add    %al,(%eax)
    85a4:	00 00                	add    %al,(%eax)
    85a6:	00 00                	add    %al,(%eax)
    85a8:	00 00                	add    %al,(%eax)
    85aa:	00 00                	add    %al,(%eax)
    85ac:	00 00                	add    %al,(%eax)
    85ae:	00 00                	add    %al,(%eax)
    85b0:	00 00                	add    %al,(%eax)
    85b2:	00 00                	add    %al,(%eax)
    85b4:	00 00                	add    %al,(%eax)
    85b6:	00 00                	add    %al,(%eax)
    85b8:	00 00                	add    %al,(%eax)
    85ba:	00 00                	add    %al,(%eax)
    85bc:	00 00                	add    %al,(%eax)
    85be:	00 00                	add    %al,(%eax)
    85c0:	00 00                	add    %al,(%eax)
    85c2:	00 00                	add    %al,(%eax)
    85c4:	00 00                	add    %al,(%eax)
    85c6:	00 00                	add    %al,(%eax)
    85c8:	00 00                	add    %al,(%eax)
    85ca:	00 00                	add    %al,(%eax)
    85cc:	00 00                	add    %al,(%eax)
    85ce:	00 00                	add    %al,(%eax)
    85d0:	00 00                	add    %al,(%eax)
    85d2:	00 00                	add    %al,(%eax)
    85d4:	00 00                	add    %al,(%eax)
    85d6:	00 00                	add    %al,(%eax)
    85d8:	00 00                	add    %al,(%eax)
    85da:	00 00                	add    %al,(%eax)
    85dc:	00 00                	add    %al,(%eax)
    85de:	00 00                	add    %al,(%eax)
    85e0:	00 00                	add    %al,(%eax)
    85e2:	00 00                	add    %al,(%eax)
    85e4:	00 00                	add    %al,(%eax)
    85e6:	00 00                	add    %al,(%eax)
    85e8:	00 00                	add    %al,(%eax)
    85ea:	00 00                	add    %al,(%eax)
    85ec:	00 00                	add    %al,(%eax)
    85ee:	00 00                	add    %al,(%eax)
    85f0:	00 00                	add    %al,(%eax)
    85f2:	00 00                	add    %al,(%eax)
    85f4:	00 00                	add    %al,(%eax)
    85f6:	00 00                	add    %al,(%eax)
    85f8:	00 00                	add    %al,(%eax)
    85fa:	00 00                	add    %al,(%eax)
    85fc:	00 00                	add    %al,(%eax)
    85fe:	00 00                	add    %al,(%eax)
    8600:	00 00                	add    %al,(%eax)
    8602:	00 00                	add    %al,(%eax)
    8604:	00 00                	add    %al,(%eax)
    8606:	00 00                	add    %al,(%eax)
    8608:	00 00                	add    %al,(%eax)
    860a:	00 00                	add    %al,(%eax)
    860c:	00 00                	add    %al,(%eax)
    860e:	00 00                	add    %al,(%eax)
    8610:	00 00                	add    %al,(%eax)
    8612:	00 00                	add    %al,(%eax)
    8614:	00 00                	add    %al,(%eax)
    8616:	00 00                	add    %al,(%eax)
    8618:	00 00                	add    %al,(%eax)
    861a:	00 00                	add    %al,(%eax)
    861c:	00 00                	add    %al,(%eax)
    861e:	00 00                	add    %al,(%eax)
    8620:	00 00                	add    %al,(%eax)
    8622:	00 00                	add    %al,(%eax)
    8624:	00 00                	add    %al,(%eax)
    8626:	00 00                	add    %al,(%eax)
    8628:	00 00                	add    %al,(%eax)
    862a:	00 00                	add    %al,(%eax)
    862c:	00 00                	add    %al,(%eax)
    862e:	00 00                	add    %al,(%eax)
    8630:	00 00                	add    %al,(%eax)
    8632:	00 00                	add    %al,(%eax)
    8634:	00 00                	add    %al,(%eax)
    8636:	00 00                	add    %al,(%eax)
    8638:	00 00                	add    %al,(%eax)
    863a:	00 00                	add    %al,(%eax)
    863c:	00 00                	add    %al,(%eax)
    863e:	00 00                	add    %al,(%eax)
    8640:	00 00                	add    %al,(%eax)
    8642:	00 00                	add    %al,(%eax)
    8644:	00 00                	add    %al,(%eax)
    8646:	00 00                	add    %al,(%eax)
    8648:	00 00                	add    %al,(%eax)
    864a:	00 00                	add    %al,(%eax)
    864c:	00 00                	add    %al,(%eax)
    864e:	00 00                	add    %al,(%eax)
    8650:	00 00                	add    %al,(%eax)
    8652:	00 00                	add    %al,(%eax)
    8654:	00 00                	add    %al,(%eax)
    8656:	00 00                	add    %al,(%eax)
    8658:	00 00                	add    %al,(%eax)
    865a:	00 00                	add    %al,(%eax)
    865c:	00 00                	add    %al,(%eax)
    865e:	00 00                	add    %al,(%eax)
    8660:	00 00                	add    %al,(%eax)
    8662:	00 00                	add    %al,(%eax)
    8664:	00 00                	add    %al,(%eax)
    8666:	00 00                	add    %al,(%eax)
    8668:	00 00                	add    %al,(%eax)
    866a:	00 00                	add    %al,(%eax)
    866c:	00 00                	add    %al,(%eax)
    866e:	00 00                	add    %al,(%eax)
    8670:	00 00                	add    %al,(%eax)
    8672:	00 00                	add    %al,(%eax)
    8674:	00 00                	add    %al,(%eax)
    8676:	00 00                	add    %al,(%eax)
    8678:	00 00                	add    %al,(%eax)
    867a:	00 00                	add    %al,(%eax)
    867c:	00 00                	add    %al,(%eax)
    867e:	00 00                	add    %al,(%eax)
    8680:	00 00                	add    %al,(%eax)
    8682:	00 00                	add    %al,(%eax)
    8684:	00 00                	add    %al,(%eax)
    8686:	00 00                	add    %al,(%eax)
    8688:	00 00                	add    %al,(%eax)
    868a:	00 00                	add    %al,(%eax)
    868c:	00 00                	add    %al,(%eax)
    868e:	00 00                	add    %al,(%eax)
    8690:	00 00                	add    %al,(%eax)
    8692:	00 00                	add    %al,(%eax)
    8694:	00 00                	add    %al,(%eax)
    8696:	00 00                	add    %al,(%eax)
    8698:	00 00                	add    %al,(%eax)
    869a:	00 00                	add    %al,(%eax)
    869c:	00 00                	add    %al,(%eax)
    869e:	00 00                	add    %al,(%eax)
    86a0:	00 00                	add    %al,(%eax)
    86a2:	00 00                	add    %al,(%eax)
    86a4:	00 00                	add    %al,(%eax)
    86a6:	00 00                	add    %al,(%eax)
    86a8:	00 00                	add    %al,(%eax)
    86aa:	00 00                	add    %al,(%eax)
    86ac:	00 00                	add    %al,(%eax)
    86ae:	00 00                	add    %al,(%eax)
    86b0:	00 00                	add    %al,(%eax)
    86b2:	00 00                	add    %al,(%eax)
    86b4:	00 00                	add    %al,(%eax)
    86b6:	00 00                	add    %al,(%eax)
    86b8:	00 00                	add    %al,(%eax)
    86ba:	00 00                	add    %al,(%eax)
    86bc:	00 00                	add    %al,(%eax)
    86be:	00 00                	add    %al,(%eax)
    86c0:	00 00                	add    %al,(%eax)
    86c2:	00 00                	add    %al,(%eax)
    86c4:	00 00                	add    %al,(%eax)
    86c6:	00 00                	add    %al,(%eax)
    86c8:	00 00                	add    %al,(%eax)
    86ca:	00 00                	add    %al,(%eax)
    86cc:	00 00                	add    %al,(%eax)
    86ce:	00 00                	add    %al,(%eax)
    86d0:	00 00                	add    %al,(%eax)
    86d2:	00 00                	add    %al,(%eax)
    86d4:	00 00                	add    %al,(%eax)
    86d6:	00 00                	add    %al,(%eax)
    86d8:	00 00                	add    %al,(%eax)
    86da:	00 00                	add    %al,(%eax)
    86dc:	00 00                	add    %al,(%eax)
    86de:	00 00                	add    %al,(%eax)
    86e0:	00 00                	add    %al,(%eax)
    86e2:	00 00                	add    %al,(%eax)
    86e4:	00 00                	add    %al,(%eax)
    86e6:	00 00                	add    %al,(%eax)
    86e8:	00 00                	add    %al,(%eax)
    86ea:	00 00                	add    %al,(%eax)
    86ec:	00 00                	add    %al,(%eax)
    86ee:	00 00                	add    %al,(%eax)
    86f0:	00 00                	add    %al,(%eax)
    86f2:	00 00                	add    %al,(%eax)
    86f4:	00 00                	add    %al,(%eax)
    86f6:	00 00                	add    %al,(%eax)
    86f8:	00 00                	add    %al,(%eax)
    86fa:	00 00                	add    %al,(%eax)
    86fc:	00 00                	add    %al,(%eax)
    86fe:	00 00                	add    %al,(%eax)
    8700:	00 00                	add    %al,(%eax)
    8702:	00 00                	add    %al,(%eax)
    8704:	00 00                	add    %al,(%eax)
    8706:	00 00                	add    %al,(%eax)
    8708:	00 00                	add    %al,(%eax)
    870a:	00 00                	add    %al,(%eax)
    870c:	00 00                	add    %al,(%eax)
    870e:	00 00                	add    %al,(%eax)
    8710:	00 00                	add    %al,(%eax)
    8712:	00 00                	add    %al,(%eax)
    8714:	00 00                	add    %al,(%eax)
    8716:	00 00                	add    %al,(%eax)
    8718:	00 00                	add    %al,(%eax)
    871a:	00 00                	add    %al,(%eax)
    871c:	00 00                	add    %al,(%eax)
    871e:	00 00                	add    %al,(%eax)
    8720:	00 00                	add    %al,(%eax)
    8722:	00 00                	add    %al,(%eax)
    8724:	00 00                	add    %al,(%eax)
    8726:	00 00                	add    %al,(%eax)
    8728:	00 00                	add    %al,(%eax)
    872a:	00 00                	add    %al,(%eax)
    872c:	00 00                	add    %al,(%eax)
    872e:	00 00                	add    %al,(%eax)
    8730:	00 00                	add    %al,(%eax)
    8732:	00 00                	add    %al,(%eax)
    8734:	00 00                	add    %al,(%eax)
    8736:	00 00                	add    %al,(%eax)
    8738:	00 00                	add    %al,(%eax)
    873a:	00 00                	add    %al,(%eax)
    873c:	00 00                	add    %al,(%eax)
    873e:	00 00                	add    %al,(%eax)
    8740:	00 00                	add    %al,(%eax)
    8742:	00 00                	add    %al,(%eax)
    8744:	00 00                	add    %al,(%eax)
    8746:	00 00                	add    %al,(%eax)
    8748:	00 00                	add    %al,(%eax)
    874a:	00 00                	add    %al,(%eax)
    874c:	00 00                	add    %al,(%eax)
    874e:	00 00                	add    %al,(%eax)
    8750:	00 00                	add    %al,(%eax)
    8752:	00 00                	add    %al,(%eax)
    8754:	00 00                	add    %al,(%eax)
    8756:	00 00                	add    %al,(%eax)
    8758:	00 00                	add    %al,(%eax)
    875a:	00 00                	add    %al,(%eax)
    875c:	00 00                	add    %al,(%eax)
    875e:	00 00                	add    %al,(%eax)
    8760:	00 00                	add    %al,(%eax)
    8762:	00 00                	add    %al,(%eax)
    8764:	00 00                	add    %al,(%eax)
    8766:	00 00                	add    %al,(%eax)
    8768:	00 00                	add    %al,(%eax)
    876a:	00 00                	add    %al,(%eax)
    876c:	00 00                	add    %al,(%eax)
    876e:	00 00                	add    %al,(%eax)
    8770:	00 00                	add    %al,(%eax)
    8772:	00 00                	add    %al,(%eax)
    8774:	00 00                	add    %al,(%eax)
    8776:	00 00                	add    %al,(%eax)
    8778:	00 00                	add    %al,(%eax)
    877a:	00 00                	add    %al,(%eax)
    877c:	00 00                	add    %al,(%eax)
    877e:	00 00                	add    %al,(%eax)
    8780:	00 00                	add    %al,(%eax)
    8782:	00 00                	add    %al,(%eax)
    8784:	00 00                	add    %al,(%eax)
    8786:	00 00                	add    %al,(%eax)
    8788:	00 00                	add    %al,(%eax)
    878a:	00 00                	add    %al,(%eax)
    878c:	00 00                	add    %al,(%eax)
    878e:	00 00                	add    %al,(%eax)
    8790:	00 00                	add    %al,(%eax)
    8792:	00 00                	add    %al,(%eax)
    8794:	00 00                	add    %al,(%eax)
    8796:	00 00                	add    %al,(%eax)
    8798:	00 00                	add    %al,(%eax)
    879a:	00 00                	add    %al,(%eax)
    879c:	00 00                	add    %al,(%eax)
    879e:	00 00                	add    %al,(%eax)
    87a0:	00 00                	add    %al,(%eax)
    87a2:	00 00                	add    %al,(%eax)
    87a4:	00 00                	add    %al,(%eax)
    87a6:	00 00                	add    %al,(%eax)
    87a8:	00 00                	add    %al,(%eax)
    87aa:	00 00                	add    %al,(%eax)
    87ac:	00 00                	add    %al,(%eax)
    87ae:	00 00                	add    %al,(%eax)
    87b0:	00 00                	add    %al,(%eax)
    87b2:	00 00                	add    %al,(%eax)
    87b4:	00 00                	add    %al,(%eax)
    87b6:	00 00                	add    %al,(%eax)
    87b8:	00 00                	add    %al,(%eax)
    87ba:	00 00                	add    %al,(%eax)
    87bc:	00 00                	add    %al,(%eax)
    87be:	00 00                	add    %al,(%eax)
    87c0:	00 00                	add    %al,(%eax)
    87c2:	00 00                	add    %al,(%eax)
    87c4:	00 00                	add    %al,(%eax)
    87c6:	00 00                	add    %al,(%eax)
    87c8:	00 00                	add    %al,(%eax)
    87ca:	00 00                	add    %al,(%eax)
    87cc:	00 00                	add    %al,(%eax)
    87ce:	00 00                	add    %al,(%eax)
    87d0:	00 00                	add    %al,(%eax)
    87d2:	00 00                	add    %al,(%eax)
    87d4:	00 00                	add    %al,(%eax)
    87d6:	00 00                	add    %al,(%eax)
    87d8:	00 00                	add    %al,(%eax)
    87da:	00 00                	add    %al,(%eax)
    87dc:	00 00                	add    %al,(%eax)
    87de:	00 00                	add    %al,(%eax)
    87e0:	00 00                	add    %al,(%eax)
    87e2:	00 00                	add    %al,(%eax)
    87e4:	00 00                	add    %al,(%eax)
    87e6:	00 00                	add    %al,(%eax)
    87e8:	00 00                	add    %al,(%eax)
    87ea:	00 00                	add    %al,(%eax)
    87ec:	00 00                	add    %al,(%eax)
    87ee:	00 00                	add    %al,(%eax)
    87f0:	00 00                	add    %al,(%eax)
    87f2:	00 00                	add    %al,(%eax)
    87f4:	00 00                	add    %al,(%eax)
    87f6:	00 00                	add    %al,(%eax)
    87f8:	00 00                	add    %al,(%eax)
    87fa:	00 00                	add    %al,(%eax)
    87fc:	00 00                	add    %al,(%eax)
    87fe:	00 00                	add    %al,(%eax)
    8800:	00 00                	add    %al,(%eax)
    8802:	00 00                	add    %al,(%eax)
    8804:	00 00                	add    %al,(%eax)
    8806:	00 00                	add    %al,(%eax)
    8808:	00 00                	add    %al,(%eax)
    880a:	00 00                	add    %al,(%eax)
    880c:	00 00                	add    %al,(%eax)
    880e:	00 00                	add    %al,(%eax)
    8810:	00 00                	add    %al,(%eax)
    8812:	00 00                	add    %al,(%eax)
    8814:	00 00                	add    %al,(%eax)
    8816:	00 00                	add    %al,(%eax)
    8818:	00 00                	add    %al,(%eax)
    881a:	00 00                	add    %al,(%eax)
    881c:	00 00                	add    %al,(%eax)
    881e:	00 00                	add    %al,(%eax)
    8820:	00 00                	add    %al,(%eax)
    8822:	00 00                	add    %al,(%eax)
    8824:	00 00                	add    %al,(%eax)
    8826:	00 00                	add    %al,(%eax)
    8828:	00 00                	add    %al,(%eax)
    882a:	00 00                	add    %al,(%eax)
    882c:	00 00                	add    %al,(%eax)
    882e:	00 00                	add    %al,(%eax)
    8830:	00 00                	add    %al,(%eax)
    8832:	00 00                	add    %al,(%eax)
    8834:	00 00                	add    %al,(%eax)
    8836:	00 00                	add    %al,(%eax)
    8838:	00 00                	add    %al,(%eax)
    883a:	00 00                	add    %al,(%eax)
    883c:	00 00                	add    %al,(%eax)
    883e:	00 00                	add    %al,(%eax)
    8840:	00 00                	add    %al,(%eax)
    8842:	00 00                	add    %al,(%eax)
    8844:	00 00                	add    %al,(%eax)
    8846:	00 00                	add    %al,(%eax)
    8848:	00 00                	add    %al,(%eax)
    884a:	00 00                	add    %al,(%eax)
    884c:	00 00                	add    %al,(%eax)
    884e:	00 00                	add    %al,(%eax)
    8850:	00 00                	add    %al,(%eax)
    8852:	00 00                	add    %al,(%eax)
    8854:	00 00                	add    %al,(%eax)
    8856:	00 00                	add    %al,(%eax)
    8858:	00 00                	add    %al,(%eax)
    885a:	00 00                	add    %al,(%eax)
    885c:	00 00                	add    %al,(%eax)
    885e:	00 00                	add    %al,(%eax)
    8860:	00 00                	add    %al,(%eax)
    8862:	00 00                	add    %al,(%eax)
    8864:	00 00                	add    %al,(%eax)
    8866:	00 00                	add    %al,(%eax)
    8868:	00 00                	add    %al,(%eax)
    886a:	00 00                	add    %al,(%eax)
    886c:	00 00                	add    %al,(%eax)
    886e:	00 00                	add    %al,(%eax)
    8870:	00 00                	add    %al,(%eax)
    8872:	00 00                	add    %al,(%eax)
    8874:	00 00                	add    %al,(%eax)
    8876:	00 00                	add    %al,(%eax)
    8878:	00 00                	add    %al,(%eax)
    887a:	00 00                	add    %al,(%eax)
    887c:	00 00                	add    %al,(%eax)
    887e:	00 00                	add    %al,(%eax)
    8880:	00 00                	add    %al,(%eax)
    8882:	00 00                	add    %al,(%eax)
    8884:	00 00                	add    %al,(%eax)
    8886:	00 00                	add    %al,(%eax)
    8888:	00 00                	add    %al,(%eax)
    888a:	00 00                	add    %al,(%eax)
    888c:	00 00                	add    %al,(%eax)
    888e:	00 00                	add    %al,(%eax)
    8890:	00 00                	add    %al,(%eax)
    8892:	00 00                	add    %al,(%eax)
    8894:	00 00                	add    %al,(%eax)
    8896:	00 00                	add    %al,(%eax)
    8898:	00 00                	add    %al,(%eax)
    889a:	00 00                	add    %al,(%eax)
    889c:	00 00                	add    %al,(%eax)
    889e:	00 00                	add    %al,(%eax)
    88a0:	00 00                	add    %al,(%eax)
    88a2:	00 00                	add    %al,(%eax)
    88a4:	00 00                	add    %al,(%eax)
    88a6:	00 00                	add    %al,(%eax)
    88a8:	00 00                	add    %al,(%eax)
    88aa:	00 00                	add    %al,(%eax)
    88ac:	00 00                	add    %al,(%eax)
    88ae:	00 00                	add    %al,(%eax)
    88b0:	00 00                	add    %al,(%eax)
    88b2:	00 00                	add    %al,(%eax)
    88b4:	00 00                	add    %al,(%eax)
    88b6:	00 00                	add    %al,(%eax)
    88b8:	00 00                	add    %al,(%eax)
    88ba:	00 00                	add    %al,(%eax)
    88bc:	00 00                	add    %al,(%eax)
    88be:	00 00                	add    %al,(%eax)
    88c0:	00 00                	add    %al,(%eax)
    88c2:	00 00                	add    %al,(%eax)
    88c4:	00 00                	add    %al,(%eax)
    88c6:	00 00                	add    %al,(%eax)
    88c8:	00 00                	add    %al,(%eax)
    88ca:	00 00                	add    %al,(%eax)
    88cc:	00 00                	add    %al,(%eax)
    88ce:	00 00                	add    %al,(%eax)
    88d0:	00 00                	add    %al,(%eax)
    88d2:	00 00                	add    %al,(%eax)
    88d4:	00 00                	add    %al,(%eax)
    88d6:	00 00                	add    %al,(%eax)
    88d8:	00 00                	add    %al,(%eax)
    88da:	00 00                	add    %al,(%eax)
    88dc:	00 00                	add    %al,(%eax)
    88de:	00 00                	add    %al,(%eax)
    88e0:	00 00                	add    %al,(%eax)
    88e2:	00 00                	add    %al,(%eax)
    88e4:	00 00                	add    %al,(%eax)
    88e6:	00 00                	add    %al,(%eax)
    88e8:	00 00                	add    %al,(%eax)
    88ea:	00 00                	add    %al,(%eax)
    88ec:	00 00                	add    %al,(%eax)
    88ee:	00 00                	add    %al,(%eax)
    88f0:	00 00                	add    %al,(%eax)
    88f2:	00 00                	add    %al,(%eax)
    88f4:	00 00                	add    %al,(%eax)
    88f6:	00 00                	add    %al,(%eax)
    88f8:	00 00                	add    %al,(%eax)
    88fa:	00 00                	add    %al,(%eax)
    88fc:	00 00                	add    %al,(%eax)
    88fe:	00 00                	add    %al,(%eax)
    8900:	00 00                	add    %al,(%eax)
    8902:	00 00                	add    %al,(%eax)
    8904:	00 00                	add    %al,(%eax)
    8906:	00 00                	add    %al,(%eax)
    8908:	00 00                	add    %al,(%eax)
    890a:	00 00                	add    %al,(%eax)
    890c:	00 00                	add    %al,(%eax)
    890e:	00 00                	add    %al,(%eax)
    8910:	00 00                	add    %al,(%eax)
    8912:	00 00                	add    %al,(%eax)
    8914:	00 00                	add    %al,(%eax)
    8916:	00 00                	add    %al,(%eax)
    8918:	00 00                	add    %al,(%eax)
    891a:	00 00                	add    %al,(%eax)
    891c:	00 00                	add    %al,(%eax)
    891e:	00 00                	add    %al,(%eax)
    8920:	00 00                	add    %al,(%eax)
    8922:	00 00                	add    %al,(%eax)
    8924:	00 00                	add    %al,(%eax)
    8926:	00 00                	add    %al,(%eax)
    8928:	00 00                	add    %al,(%eax)
    892a:	00 00                	add    %al,(%eax)
    892c:	00 00                	add    %al,(%eax)
    892e:	00 00                	add    %al,(%eax)
    8930:	00 00                	add    %al,(%eax)
    8932:	00 00                	add    %al,(%eax)
    8934:	00 00                	add    %al,(%eax)
    8936:	00 00                	add    %al,(%eax)
    8938:	00 00                	add    %al,(%eax)
    893a:	00 00                	add    %al,(%eax)
    893c:	00 00                	add    %al,(%eax)
    893e:	00 00                	add    %al,(%eax)
    8940:	00 00                	add    %al,(%eax)
    8942:	00 00                	add    %al,(%eax)
    8944:	00 00                	add    %al,(%eax)
    8946:	00 00                	add    %al,(%eax)
    8948:	00 00                	add    %al,(%eax)
    894a:	00 00                	add    %al,(%eax)
    894c:	00 00                	add    %al,(%eax)
    894e:	00 00                	add    %al,(%eax)
    8950:	00 00                	add    %al,(%eax)
    8952:	00 00                	add    %al,(%eax)
    8954:	00 00                	add    %al,(%eax)
    8956:	00 00                	add    %al,(%eax)
    8958:	00 00                	add    %al,(%eax)
    895a:	00 00                	add    %al,(%eax)
    895c:	00 00                	add    %al,(%eax)
    895e:	00 00                	add    %al,(%eax)
    8960:	00 00                	add    %al,(%eax)
    8962:	00 00                	add    %al,(%eax)
    8964:	00 00                	add    %al,(%eax)
    8966:	00 00                	add    %al,(%eax)
    8968:	00 00                	add    %al,(%eax)
    896a:	00 00                	add    %al,(%eax)
    896c:	00 00                	add    %al,(%eax)
    896e:	00 00                	add    %al,(%eax)
    8970:	00 00                	add    %al,(%eax)
    8972:	00 00                	add    %al,(%eax)
    8974:	00 00                	add    %al,(%eax)
    8976:	00 00                	add    %al,(%eax)
    8978:	00 00                	add    %al,(%eax)
    897a:	00 00                	add    %al,(%eax)
    897c:	00 00                	add    %al,(%eax)
    897e:	00 00                	add    %al,(%eax)
    8980:	00 00                	add    %al,(%eax)
    8982:	00 00                	add    %al,(%eax)
    8984:	00 00                	add    %al,(%eax)
    8986:	00 00                	add    %al,(%eax)
    8988:	00 00                	add    %al,(%eax)
    898a:	00 00                	add    %al,(%eax)
    898c:	00 00                	add    %al,(%eax)
    898e:	00 00                	add    %al,(%eax)
    8990:	00 00                	add    %al,(%eax)
    8992:	00 00                	add    %al,(%eax)
    8994:	00 00                	add    %al,(%eax)
    8996:	00 00                	add    %al,(%eax)
    8998:	00 00                	add    %al,(%eax)
    899a:	00 00                	add    %al,(%eax)
    899c:	00 00                	add    %al,(%eax)
    899e:	00 00                	add    %al,(%eax)
    89a0:	00 00                	add    %al,(%eax)
    89a2:	00 00                	add    %al,(%eax)
    89a4:	00 00                	add    %al,(%eax)
    89a6:	00 00                	add    %al,(%eax)
    89a8:	00 00                	add    %al,(%eax)
    89aa:	00 00                	add    %al,(%eax)
    89ac:	00 00                	add    %al,(%eax)
    89ae:	00 00                	add    %al,(%eax)
    89b0:	00 00                	add    %al,(%eax)
    89b2:	00 00                	add    %al,(%eax)
    89b4:	00 00                	add    %al,(%eax)
    89b6:	00 00                	add    %al,(%eax)
    89b8:	00 00                	add    %al,(%eax)
    89ba:	00 00                	add    %al,(%eax)
    89bc:	00 00                	add    %al,(%eax)
    89be:	00 00                	add    %al,(%eax)
    89c0:	00 00                	add    %al,(%eax)
    89c2:	00 00                	add    %al,(%eax)
    89c4:	00 00                	add    %al,(%eax)
    89c6:	00 00                	add    %al,(%eax)
    89c8:	00 00                	add    %al,(%eax)
    89ca:	00 00                	add    %al,(%eax)
    89cc:	00 00                	add    %al,(%eax)
    89ce:	00 00                	add    %al,(%eax)
    89d0:	00 00                	add    %al,(%eax)
    89d2:	00 00                	add    %al,(%eax)
    89d4:	00 00                	add    %al,(%eax)
    89d6:	00 00                	add    %al,(%eax)
    89d8:	00 00                	add    %al,(%eax)
    89da:	00 00                	add    %al,(%eax)
    89dc:	00 00                	add    %al,(%eax)
    89de:	00 00                	add    %al,(%eax)
    89e0:	00 00                	add    %al,(%eax)
    89e2:	00 00                	add    %al,(%eax)
    89e4:	00 00                	add    %al,(%eax)
    89e6:	00 00                	add    %al,(%eax)
    89e8:	00 00                	add    %al,(%eax)
    89ea:	00 00                	add    %al,(%eax)
    89ec:	00 00                	add    %al,(%eax)
    89ee:	00 00                	add    %al,(%eax)
    89f0:	00 00                	add    %al,(%eax)
    89f2:	00 00                	add    %al,(%eax)
    89f4:	00 00                	add    %al,(%eax)
    89f6:	00 00                	add    %al,(%eax)
    89f8:	00 00                	add    %al,(%eax)
    89fa:	00 00                	add    %al,(%eax)
    89fc:	00 00                	add    %al,(%eax)
    89fe:	00 00                	add    %al,(%eax)
    8a00:	00 00                	add    %al,(%eax)
    8a02:	00 00                	add    %al,(%eax)
    8a04:	00 00                	add    %al,(%eax)
    8a06:	00 00                	add    %al,(%eax)
    8a08:	00 00                	add    %al,(%eax)
    8a0a:	00 00                	add    %al,(%eax)
    8a0c:	00 00                	add    %al,(%eax)
    8a0e:	00 00                	add    %al,(%eax)
    8a10:	00 00                	add    %al,(%eax)
    8a12:	00 00                	add    %al,(%eax)
    8a14:	00 00                	add    %al,(%eax)
    8a16:	00 00                	add    %al,(%eax)
    8a18:	00 00                	add    %al,(%eax)
    8a1a:	00 00                	add    %al,(%eax)
    8a1c:	00 00                	add    %al,(%eax)
    8a1e:	00 00                	add    %al,(%eax)
    8a20:	00 00                	add    %al,(%eax)
    8a22:	00 00                	add    %al,(%eax)
    8a24:	00 00                	add    %al,(%eax)
    8a26:	00 00                	add    %al,(%eax)
    8a28:	00 00                	add    %al,(%eax)
    8a2a:	00 00                	add    %al,(%eax)
    8a2c:	00 00                	add    %al,(%eax)
    8a2e:	00 00                	add    %al,(%eax)
    8a30:	00 00                	add    %al,(%eax)
    8a32:	00 00                	add    %al,(%eax)
    8a34:	00 00                	add    %al,(%eax)
    8a36:	00 00                	add    %al,(%eax)
    8a38:	00 00                	add    %al,(%eax)
    8a3a:	00 00                	add    %al,(%eax)
    8a3c:	00 00                	add    %al,(%eax)
    8a3e:	00 00                	add    %al,(%eax)
    8a40:	00 00                	add    %al,(%eax)
    8a42:	00 00                	add    %al,(%eax)
    8a44:	00 00                	add    %al,(%eax)
    8a46:	00 00                	add    %al,(%eax)
    8a48:	00 00                	add    %al,(%eax)
    8a4a:	00 00                	add    %al,(%eax)
    8a4c:	00 00                	add    %al,(%eax)
    8a4e:	00 00                	add    %al,(%eax)
    8a50:	00 00                	add    %al,(%eax)
    8a52:	00 00                	add    %al,(%eax)
    8a54:	00 00                	add    %al,(%eax)
    8a56:	00 00                	add    %al,(%eax)
    8a58:	00 00                	add    %al,(%eax)
    8a5a:	00 00                	add    %al,(%eax)
    8a5c:	00 00                	add    %al,(%eax)
    8a5e:	00 00                	add    %al,(%eax)
    8a60:	00 00                	add    %al,(%eax)
    8a62:	00 00                	add    %al,(%eax)
    8a64:	00 00                	add    %al,(%eax)
    8a66:	00 00                	add    %al,(%eax)
    8a68:	00 00                	add    %al,(%eax)
    8a6a:	00 00                	add    %al,(%eax)
    8a6c:	00 00                	add    %al,(%eax)
    8a6e:	00 00                	add    %al,(%eax)
    8a70:	00 00                	add    %al,(%eax)
    8a72:	00 00                	add    %al,(%eax)
    8a74:	00 00                	add    %al,(%eax)
    8a76:	00 00                	add    %al,(%eax)
    8a78:	00 00                	add    %al,(%eax)
    8a7a:	00 00                	add    %al,(%eax)
    8a7c:	00 00                	add    %al,(%eax)
    8a7e:	00 00                	add    %al,(%eax)
    8a80:	00 00                	add    %al,(%eax)
    8a82:	00 00                	add    %al,(%eax)
    8a84:	00 00                	add    %al,(%eax)
    8a86:	00 00                	add    %al,(%eax)
    8a88:	00 00                	add    %al,(%eax)
    8a8a:	00 00                	add    %al,(%eax)
    8a8c:	00 00                	add    %al,(%eax)
    8a8e:	00 00                	add    %al,(%eax)
    8a90:	00 00                	add    %al,(%eax)
    8a92:	00 00                	add    %al,(%eax)
    8a94:	00 00                	add    %al,(%eax)
    8a96:	00 00                	add    %al,(%eax)
    8a98:	00 00                	add    %al,(%eax)
    8a9a:	00 00                	add    %al,(%eax)
    8a9c:	00 00                	add    %al,(%eax)
    8a9e:	00 00                	add    %al,(%eax)
    8aa0:	00 00                	add    %al,(%eax)
    8aa2:	00 00                	add    %al,(%eax)
    8aa4:	00 00                	add    %al,(%eax)
    8aa6:	00 00                	add    %al,(%eax)
    8aa8:	00 00                	add    %al,(%eax)
    8aaa:	00 00                	add    %al,(%eax)
    8aac:	00 00                	add    %al,(%eax)
    8aae:	00 00                	add    %al,(%eax)
    8ab0:	00 00                	add    %al,(%eax)
    8ab2:	00 00                	add    %al,(%eax)
    8ab4:	00 00                	add    %al,(%eax)
    8ab6:	00 00                	add    %al,(%eax)
    8ab8:	00 00                	add    %al,(%eax)
    8aba:	00 00                	add    %al,(%eax)
    8abc:	00 00                	add    %al,(%eax)
    8abe:	00 00                	add    %al,(%eax)
    8ac0:	00 00                	add    %al,(%eax)
    8ac2:	00 00                	add    %al,(%eax)
    8ac4:	00 00                	add    %al,(%eax)
    8ac6:	00 00                	add    %al,(%eax)
    8ac8:	00 00                	add    %al,(%eax)
    8aca:	00 00                	add    %al,(%eax)
    8acc:	00 00                	add    %al,(%eax)
    8ace:	00 00                	add    %al,(%eax)
    8ad0:	00 00                	add    %al,(%eax)
    8ad2:	00 00                	add    %al,(%eax)
    8ad4:	00 00                	add    %al,(%eax)
    8ad6:	00 00                	add    %al,(%eax)
    8ad8:	00 00                	add    %al,(%eax)
    8ada:	00 00                	add    %al,(%eax)
    8adc:	00 00                	add    %al,(%eax)
    8ade:	00 00                	add    %al,(%eax)
    8ae0:	00 00                	add    %al,(%eax)
    8ae2:	00 00                	add    %al,(%eax)
    8ae4:	00 00                	add    %al,(%eax)
    8ae6:	00 00                	add    %al,(%eax)
    8ae8:	00 00                	add    %al,(%eax)
    8aea:	00 00                	add    %al,(%eax)
    8aec:	00 00                	add    %al,(%eax)
    8aee:	00 00                	add    %al,(%eax)
    8af0:	00 00                	add    %al,(%eax)
    8af2:	00 00                	add    %al,(%eax)
    8af4:	00 00                	add    %al,(%eax)
    8af6:	00 00                	add    %al,(%eax)
    8af8:	00 00                	add    %al,(%eax)
    8afa:	00 00                	add    %al,(%eax)
    8afc:	00 00                	add    %al,(%eax)
    8afe:	00 00                	add    %al,(%eax)
    8b00:	00 00                	add    %al,(%eax)
    8b02:	00 00                	add    %al,(%eax)
    8b04:	00 00                	add    %al,(%eax)
    8b06:	00 00                	add    %al,(%eax)
    8b08:	00 00                	add    %al,(%eax)
    8b0a:	00 00                	add    %al,(%eax)
    8b0c:	00 00                	add    %al,(%eax)
    8b0e:	00 00                	add    %al,(%eax)
    8b10:	00 00                	add    %al,(%eax)
    8b12:	00 00                	add    %al,(%eax)
    8b14:	00 00                	add    %al,(%eax)
    8b16:	00 00                	add    %al,(%eax)
    8b18:	00 00                	add    %al,(%eax)
    8b1a:	00 00                	add    %al,(%eax)
    8b1c:	00 00                	add    %al,(%eax)
    8b1e:	00 00                	add    %al,(%eax)
    8b20:	00 00                	add    %al,(%eax)
    8b22:	00 00                	add    %al,(%eax)
    8b24:	00 00                	add    %al,(%eax)

00008b26 <putc>:
    8b26:	55                   	push   %ebp
    8b27:	e8 9f 02 00 00       	call   8dcb <__x86.get_pc_thunk.dx>
    8b2c:	81 c2 04 08 00 00    	add    $0x804,%edx
    8b32:	89 e5                	mov    %esp,%ebp
    8b34:	8b 45 08             	mov    0x8(%ebp),%eax
    8b37:	01 c0                	add    %eax,%eax
    8b39:	03 82 30 00 00 00    	add    0x30(%edx),%eax
    8b3f:	8b 55 10             	mov    0x10(%ebp),%edx
    8b42:	88 10                	mov    %dl,(%eax)
    8b44:	8b 55 0c             	mov    0xc(%ebp),%edx
    8b47:	88 50 01             	mov    %dl,0x1(%eax)
    8b4a:	5d                   	pop    %ebp
    8b4b:	c3                   	ret    

00008b4c <puts>:
    8b4c:	55                   	push   %ebp
    8b4d:	89 e5                	mov    %esp,%ebp
    8b4f:	56                   	push   %esi
    8b50:	53                   	push   %ebx
    8b51:	6b 75 08 50          	imul   $0x50,0x8(%ebp),%esi
    8b55:	8b 4d 10             	mov    0x10(%ebp),%ecx
    8b58:	03 75 0c             	add    0xc(%ebp),%esi
    8b5b:	89 f0                	mov    %esi,%eax
    8b5d:	8b 55 14             	mov    0x14(%ebp),%edx
    8b60:	29 f2                	sub    %esi,%edx
    8b62:	0f be 14 02          	movsbl (%edx,%eax,1),%edx
    8b66:	84 d2                	test   %dl,%dl
    8b68:	74 12                	je     8b7c <puts+0x30>
    8b6a:	52                   	push   %edx
    8b6b:	8d 58 01             	lea    0x1(%eax),%ebx
    8b6e:	51                   	push   %ecx
    8b6f:	50                   	push   %eax
    8b70:	e8 b1 ff ff ff       	call   8b26 <putc>
    8b75:	83 c4 0c             	add    $0xc,%esp
    8b78:	89 d8                	mov    %ebx,%eax
    8b7a:	eb e1                	jmp    8b5d <puts+0x11>
    8b7c:	8d 65 f8             	lea    -0x8(%ebp),%esp
    8b7f:	5b                   	pop    %ebx
    8b80:	5e                   	pop    %esi
    8b81:	5d                   	pop    %ebp
    8b82:	c3                   	ret    

00008b83 <putline>:
    8b83:	e8 3f 02 00 00       	call   8dc7 <__x86.get_pc_thunk.ax>
    8b88:	05 a8 07 00 00       	add    $0x7a8,%eax
    8b8d:	55                   	push   %ebp
    8b8e:	8b 90 d8 00 00 00    	mov    0xd8(%eax),%edx
    8b94:	8b 88 34 00 00 00    	mov    0x34(%eax),%ecx
    8b9a:	89 e5                	mov    %esp,%ebp
    8b9c:	53                   	push   %ebx
    8b9d:	83 fa 18             	cmp    $0x18,%edx
    8ba0:	8d 5a 01             	lea    0x1(%edx),%ebx
    8ba3:	7e 02                	jle    8ba7 <putline+0x24>
    8ba5:	31 db                	xor    %ebx,%ebx
    8ba7:	51                   	push   %ecx
    8ba8:	6a 00                	push   $0x0
    8baa:	6a 00                	push   $0x0
    8bac:	53                   	push   %ebx
    8bad:	89 98 d8 00 00 00    	mov    %ebx,0xd8(%eax)
    8bb3:	e8 94 ff ff ff       	call   8b4c <puts>
    8bb8:	ff 75 08             	pushl  0x8(%ebp)
    8bbb:	6a 0f                	push   $0xf
    8bbd:	6a 00                	push   $0x0
    8bbf:	53                   	push   %ebx
    8bc0:	e8 87 ff ff ff       	call   8b4c <puts>
    8bc5:	83 c4 20             	add    $0x20,%esp
    8bc8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    8bcb:	c9                   	leave  
    8bcc:	c3                   	ret    

00008bcd <roll>:
    8bcd:	55                   	push   %ebp
    8bce:	e8 f4 01 00 00       	call   8dc7 <__x86.get_pc_thunk.ax>
    8bd3:	05 5d 07 00 00       	add    $0x75d,%eax
    8bd8:	89 e5                	mov    %esp,%ebp
    8bda:	8b 55 08             	mov    0x8(%ebp),%edx
    8bdd:	5d                   	pop    %ebp
    8bde:	89 90 d8 00 00 00    	mov    %edx,0xd8(%eax)
    8be4:	c3                   	ret    

00008be5 <panic>:
    8be5:	55                   	push   %ebp
    8be6:	89 e5                	mov    %esp,%ebp
    8be8:	ff 75 08             	pushl  0x8(%ebp)
    8beb:	6a 04                	push   $0x4
    8bed:	6a 00                	push   $0x0
    8bef:	6a 00                	push   $0x0
    8bf1:	e8 56 ff ff ff       	call   8b4c <puts>
    8bf6:	83 c4 10             	add    $0x10,%esp
    8bf9:	f4                   	hlt    
    8bfa:	eb fd                	jmp    8bf9 <panic+0x14>

00008bfc <strlen>:
    8bfc:	55                   	push   %ebp
    8bfd:	31 c0                	xor    %eax,%eax
    8bff:	89 e5                	mov    %esp,%ebp
    8c01:	8b 55 08             	mov    0x8(%ebp),%edx
    8c04:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
    8c08:	74 03                	je     8c0d <strlen+0x11>
    8c0a:	40                   	inc    %eax
    8c0b:	eb f7                	jmp    8c04 <strlen+0x8>
    8c0d:	5d                   	pop    %ebp
    8c0e:	c3                   	ret    

00008c0f <reverse>:
    8c0f:	55                   	push   %ebp
    8c10:	89 e5                	mov    %esp,%ebp
    8c12:	56                   	push   %esi
    8c13:	53                   	push   %ebx
    8c14:	8b 4d 08             	mov    0x8(%ebp),%ecx
    8c17:	51                   	push   %ecx
    8c18:	e8 df ff ff ff       	call   8bfc <strlen>
    8c1d:	5a                   	pop    %edx
    8c1e:	48                   	dec    %eax
    8c1f:	31 d2                	xor    %edx,%edx
    8c21:	39 c2                	cmp    %eax,%edx
    8c23:	7d 13                	jge    8c38 <reverse+0x29>
    8c25:	0f b6 34 11          	movzbl (%ecx,%edx,1),%esi
    8c29:	8a 1c 01             	mov    (%ecx,%eax,1),%bl
    8c2c:	88 1c 11             	mov    %bl,(%ecx,%edx,1)
    8c2f:	42                   	inc    %edx
    8c30:	89 f3                	mov    %esi,%ebx
    8c32:	88 1c 01             	mov    %bl,(%ecx,%eax,1)
    8c35:	48                   	dec    %eax
    8c36:	eb e9                	jmp    8c21 <reverse+0x12>
    8c38:	8d 65 f8             	lea    -0x8(%ebp),%esp
    8c3b:	5b                   	pop    %ebx
    8c3c:	5e                   	pop    %esi
    8c3d:	5d                   	pop    %ebp
    8c3e:	c3                   	ret    

00008c3f <itox>:
    8c3f:	55                   	push   %ebp
    8c40:	89 e5                	mov    %esp,%ebp
    8c42:	57                   	push   %edi
    8c43:	56                   	push   %esi
    8c44:	53                   	push   %ebx
    8c45:	31 db                	xor    %ebx,%ebx
    8c47:	83 ec 08             	sub    $0x8,%esp
    8c4a:	8b 45 08             	mov    0x8(%ebp),%eax
    8c4d:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    8c50:	8b 75 14             	mov    0x14(%ebp),%esi
    8c53:	89 45 f0             	mov    %eax,-0x10(%ebp)
    8c56:	8b 45 10             	mov    0x10(%ebp),%eax
    8c59:	8b 55 f0             	mov    -0x10(%ebp),%edx
    8c5c:	89 45 ec             	mov    %eax,-0x14(%ebp)
    8c5f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    8c62:	c1 fa 1f             	sar    $0x1f,%edx
    8c65:	31 d0                	xor    %edx,%eax
    8c67:	29 d0                	sub    %edx,%eax
    8c69:	99                   	cltd   
    8c6a:	8d 7b 01             	lea    0x1(%ebx),%edi
    8c6d:	f7 7d ec             	idivl  -0x14(%ebp)
    8c70:	8a 14 16             	mov    (%esi,%edx,1),%dl
    8c73:	85 c0                	test   %eax,%eax
    8c75:	88 54 39 ff          	mov    %dl,-0x1(%ecx,%edi,1)
    8c79:	89 fa                	mov    %edi,%edx
    8c7b:	7e 04                	jle    8c81 <itox+0x42>
    8c7d:	89 fb                	mov    %edi,%ebx
    8c7f:	eb e8                	jmp    8c69 <itox+0x2a>
    8c81:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    8c85:	79 07                	jns    8c8e <itox+0x4f>
    8c87:	8d 7b 02             	lea    0x2(%ebx),%edi
    8c8a:	c6 04 11 2d          	movb   $0x2d,(%ecx,%edx,1)
    8c8e:	c6 04 39 00          	movb   $0x0,(%ecx,%edi,1)
    8c92:	89 4d 08             	mov    %ecx,0x8(%ebp)
    8c95:	58                   	pop    %eax
    8c96:	5a                   	pop    %edx
    8c97:	5b                   	pop    %ebx
    8c98:	5e                   	pop    %esi
    8c99:	5f                   	pop    %edi
    8c9a:	5d                   	pop    %ebp
    8c9b:	e9 6f ff ff ff       	jmp    8c0f <reverse>

00008ca0 <itoa>:
    8ca0:	e8 22 01 00 00       	call   8dc7 <__x86.get_pc_thunk.ax>
    8ca5:	05 8b 06 00 00       	add    $0x68b,%eax
    8caa:	55                   	push   %ebp
    8cab:	8d 80 24 00 00 00    	lea    0x24(%eax),%eax
    8cb1:	89 e5                	mov    %esp,%ebp
    8cb3:	50                   	push   %eax
    8cb4:	6a 0a                	push   $0xa
    8cb6:	ff 75 0c             	pushl  0xc(%ebp)
    8cb9:	ff 75 08             	pushl  0x8(%ebp)
    8cbc:	e8 7e ff ff ff       	call   8c3f <itox>
    8cc1:	83 c4 10             	add    $0x10,%esp
    8cc4:	c9                   	leave  
    8cc5:	c3                   	ret    

00008cc6 <itoh>:
    8cc6:	e8 fc 00 00 00       	call   8dc7 <__x86.get_pc_thunk.ax>
    8ccb:	05 65 06 00 00       	add    $0x665,%eax
    8cd0:	55                   	push   %ebp
    8cd1:	8d 80 10 00 00 00    	lea    0x10(%eax),%eax
    8cd7:	89 e5                	mov    %esp,%ebp
    8cd9:	50                   	push   %eax
    8cda:	6a 10                	push   $0x10
    8cdc:	ff 75 0c             	pushl  0xc(%ebp)
    8cdf:	ff 75 08             	pushl  0x8(%ebp)
    8ce2:	e8 58 ff ff ff       	call   8c3f <itox>
    8ce7:	83 c4 10             	add    $0x10,%esp
    8cea:	c9                   	leave  
    8ceb:	c3                   	ret    

00008cec <puti>:
    8cec:	55                   	push   %ebp
    8ced:	e8 d5 00 00 00       	call   8dc7 <__x86.get_pc_thunk.ax>
    8cf2:	05 3e 06 00 00       	add    $0x63e,%eax
    8cf7:	89 e5                	mov    %esp,%ebp
    8cf9:	53                   	push   %ebx
    8cfa:	8d 98 b0 00 00 00    	lea    0xb0(%eax),%ebx
    8d00:	53                   	push   %ebx
    8d01:	ff 75 08             	pushl  0x8(%ebp)
    8d04:	e8 bd ff ff ff       	call   8cc6 <itoh>
    8d09:	58                   	pop    %eax
    8d0a:	5a                   	pop    %edx
    8d0b:	89 5d 08             	mov    %ebx,0x8(%ebp)
    8d0e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    8d11:	c9                   	leave  
    8d12:	e9 6c fe ff ff       	jmp    8b83 <putline>

00008d17 <readsector>:
    8d17:	55                   	push   %ebp
    8d18:	89 e5                	mov    %esp,%ebp
    8d1a:	57                   	push   %edi
    8d1b:	bf f7 01 00 00       	mov    $0x1f7,%edi
    8d20:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    8d23:	89 fa                	mov    %edi,%edx
    8d25:	ec                   	in     (%dx),%al
    8d26:	83 e0 c0             	and    $0xffffffc0,%eax
    8d29:	3c 40                	cmp    $0x40,%al
    8d2b:	75 f6                	jne    8d23 <readsector+0xc>
    8d2d:	b0 01                	mov    $0x1,%al
    8d2f:	ba f2 01 00 00       	mov    $0x1f2,%edx
    8d34:	ee                   	out    %al,(%dx)
    8d35:	ba f3 01 00 00       	mov    $0x1f3,%edx
    8d3a:	88 c8                	mov    %cl,%al
    8d3c:	ee                   	out    %al,(%dx)
    8d3d:	89 c8                	mov    %ecx,%eax
    8d3f:	ba f4 01 00 00       	mov    $0x1f4,%edx
    8d44:	c1 e8 08             	shr    $0x8,%eax
    8d47:	ee                   	out    %al,(%dx)
    8d48:	89 c8                	mov    %ecx,%eax
    8d4a:	ba f5 01 00 00       	mov    $0x1f5,%edx
    8d4f:	c1 e8 10             	shr    $0x10,%eax
    8d52:	ee                   	out    %al,(%dx)
    8d53:	89 c8                	mov    %ecx,%eax
    8d55:	ba f6 01 00 00       	mov    $0x1f6,%edx
    8d5a:	c1 e8 18             	shr    $0x18,%eax
    8d5d:	83 c8 e0             	or     $0xffffffe0,%eax
    8d60:	ee                   	out    %al,(%dx)
    8d61:	b0 20                	mov    $0x20,%al
    8d63:	89 fa                	mov    %edi,%edx
    8d65:	ee                   	out    %al,(%dx)
    8d66:	ba f7 01 00 00       	mov    $0x1f7,%edx
    8d6b:	ec                   	in     (%dx),%al
    8d6c:	83 e0 c0             	and    $0xffffffc0,%eax
    8d6f:	3c 40                	cmp    $0x40,%al
    8d71:	75 f8                	jne    8d6b <readsector+0x54>
    8d73:	8b 7d 08             	mov    0x8(%ebp),%edi
    8d76:	b9 80 00 00 00       	mov    $0x80,%ecx
    8d7b:	ba f0 01 00 00       	mov    $0x1f0,%edx
    8d80:	fc                   	cld    
    8d81:	f2 6d                	repnz insl (%dx),%es:(%edi)
    8d83:	5f                   	pop    %edi
    8d84:	5d                   	pop    %ebp
    8d85:	c3                   	ret    

00008d86 <readsection>:
    8d86:	55                   	push   %ebp
    8d87:	89 e5                	mov    %esp,%ebp
    8d89:	57                   	push   %edi
    8d8a:	56                   	push   %esi
    8d8b:	53                   	push   %ebx
    8d8c:	8b 5d 08             	mov    0x8(%ebp),%ebx
    8d8f:	8b 7d 10             	mov    0x10(%ebp),%edi
    8d92:	89 de                	mov    %ebx,%esi
    8d94:	81 e3 00 fe ff 00    	and    $0xfffe00,%ebx
    8d9a:	81 e6 ff ff ff 00    	and    $0xffffff,%esi
    8da0:	c1 ef 09             	shr    $0x9,%edi
    8da3:	03 75 0c             	add    0xc(%ebp),%esi
    8da6:	03 7d 14             	add    0x14(%ebp),%edi
    8da9:	39 f3                	cmp    %esi,%ebx
    8dab:	73 12                	jae    8dbf <readsection+0x39>
    8dad:	57                   	push   %edi
    8dae:	53                   	push   %ebx
    8daf:	47                   	inc    %edi
    8db0:	81 c3 00 02 00 00    	add    $0x200,%ebx
    8db6:	e8 5c ff ff ff       	call   8d17 <readsector>
    8dbb:	58                   	pop    %eax
    8dbc:	5a                   	pop    %edx
    8dbd:	eb ea                	jmp    8da9 <readsection+0x23>
    8dbf:	8d 65 f4             	lea    -0xc(%ebp),%esp
    8dc2:	5b                   	pop    %ebx
    8dc3:	5e                   	pop    %esi
    8dc4:	5f                   	pop    %edi
    8dc5:	5d                   	pop    %ebp
    8dc6:	c3                   	ret    

00008dc7 <__x86.get_pc_thunk.ax>:
    8dc7:	8b 04 24             	mov    (%esp),%eax
    8dca:	c3                   	ret    

00008dcb <__x86.get_pc_thunk.dx>:
    8dcb:	8b 14 24             	mov    (%esp),%edx
    8dce:	c3                   	ret    

00008dcf <load_kernel>:
    8dcf:	55                   	push   %ebp
    8dd0:	89 e5                	mov    %esp,%ebp
    8dd2:	57                   	push   %edi
    8dd3:	56                   	push   %esi
    8dd4:	53                   	push   %ebx
    8dd5:	e8 ae 01 00 00       	call   8f88 <__x86.get_pc_thunk.bx>
    8dda:	81 c3 56 05 00 00    	add    $0x556,%ebx
    8de0:	83 ec 0c             	sub    $0xc,%esp
    8de3:	ff 75 08             	pushl  0x8(%ebp)
    8de6:	6a 00                	push   $0x0
    8de8:	68 00 10 00 00       	push   $0x1000
    8ded:	68 00 00 02 00       	push   $0x20000
    8df2:	e8 8f ff ff ff       	call   8d86 <readsection>
    8df7:	83 c4 10             	add    $0x10,%esp
    8dfa:	81 3d 00 00 02 00 7f 	cmpl   $0x464c457f,0x20000
    8e01:	45 4c 46 
    8e04:	74 12                	je     8e18 <load_kernel+0x49>
    8e06:	8d 83 bd fc ff ff    	lea    -0x343(%ebx),%eax
    8e0c:	83 ec 0c             	sub    $0xc,%esp
    8e0f:	50                   	push   %eax
    8e10:	e8 d0 fd ff ff       	call   8be5 <panic>
    8e15:	83 c4 10             	add    $0x10,%esp
    8e18:	a1 1c 00 02 00       	mov    0x2001c,%eax
    8e1d:	0f b7 35 2c 00 02 00 	movzwl 0x2002c,%esi
    8e24:	8d b8 00 00 02 00    	lea    0x20000(%eax),%edi
    8e2a:	c1 e6 05             	shl    $0x5,%esi
    8e2d:	01 fe                	add    %edi,%esi
    8e2f:	39 f7                	cmp    %esi,%edi
    8e31:	73 19                	jae    8e4c <load_kernel+0x7d>
    8e33:	ff 75 08             	pushl  0x8(%ebp)
    8e36:	ff 77 04             	pushl  0x4(%edi)
    8e39:	83 c7 20             	add    $0x20,%edi
    8e3c:	ff 77 f4             	pushl  -0xc(%edi)
    8e3f:	ff 77 e8             	pushl  -0x18(%edi)
    8e42:	e8 3f ff ff ff       	call   8d86 <readsection>
    8e47:	83 c4 10             	add    $0x10,%esp
    8e4a:	eb e3                	jmp    8e2f <load_kernel+0x60>
    8e4c:	a1 18 00 02 00       	mov    0x20018,%eax
    8e51:	8d 65 f4             	lea    -0xc(%ebp),%esp
    8e54:	5b                   	pop    %ebx
    8e55:	25 ff ff ff 00       	and    $0xffffff,%eax
    8e5a:	5e                   	pop    %esi
    8e5b:	5f                   	pop    %edi
    8e5c:	5d                   	pop    %ebp
    8e5d:	c3                   	ret    

00008e5e <parse_e820>:
    8e5e:	55                   	push   %ebp
    8e5f:	89 e5                	mov    %esp,%ebp
    8e61:	57                   	push   %edi
    8e62:	56                   	push   %esi
    8e63:	53                   	push   %ebx
    8e64:	31 f6                	xor    %esi,%esi
    8e66:	e8 1d 01 00 00       	call   8f88 <__x86.get_pc_thunk.bx>
    8e6b:	81 c3 c5 04 00 00    	add    $0x4c5,%ebx
    8e71:	83 ec 18             	sub    $0x18,%esp
    8e74:	8b 7d 08             	mov    0x8(%ebp),%edi
    8e77:	8d 83 d8 fc ff ff    	lea    -0x328(%ebx),%eax
    8e7d:	50                   	push   %eax
    8e7e:	e8 00 fd ff ff       	call   8b83 <putline>
    8e83:	83 c4 10             	add    $0x10,%esp
    8e86:	8b 44 37 04          	mov    0x4(%edi,%esi,1),%eax
    8e8a:	89 c1                	mov    %eax,%ecx
    8e8c:	0b 4c 37 08          	or     0x8(%edi,%esi,1),%ecx
    8e90:	74 11                	je     8ea3 <parse_e820+0x45>
    8e92:	83 ec 0c             	sub    $0xc,%esp
    8e95:	83 c6 18             	add    $0x18,%esi
    8e98:	50                   	push   %eax
    8e99:	e8 4e fe ff ff       	call   8cec <puti>
    8e9e:	83 c4 10             	add    $0x10,%esp
    8ea1:	eb e3                	jmp    8e86 <parse_e820+0x28>
    8ea3:	8b 54 37 10          	mov    0x10(%edi,%esi,1),%edx
    8ea7:	0b 54 37 0c          	or     0xc(%edi,%esi,1),%edx
    8eab:	75 e5                	jne    8e92 <parse_e820+0x34>
    8ead:	83 7c 37 14 00       	cmpl   $0x0,0x14(%edi,%esi,1)
    8eb2:	75 de                	jne    8e92 <parse_e820+0x34>
    8eb4:	89 b3 7c 00 00 00    	mov    %esi,0x7c(%ebx)
    8eba:	89 bb 80 00 00 00    	mov    %edi,0x80(%ebx)
    8ec0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    8ec3:	8d 83 50 00 00 00    	lea    0x50(%ebx),%eax
    8ec9:	5b                   	pop    %ebx
    8eca:	5e                   	pop    %esi
    8ecb:	5f                   	pop    %edi
    8ecc:	5d                   	pop    %ebp
    8ecd:	c3                   	ret    

00008ece <boot1main>:
    8ece:	55                   	push   %ebp
    8ecf:	89 e5                	mov    %esp,%ebp
    8ed1:	56                   	push   %esi
    8ed2:	53                   	push   %ebx
    8ed3:	e8 b0 00 00 00       	call   8f88 <__x86.get_pc_thunk.bx>
    8ed8:	81 c3 58 04 00 00    	add    $0x458,%ebx
    8ede:	83 ec 0c             	sub    $0xc,%esp
    8ee1:	8b 75 0c             	mov    0xc(%ebp),%esi
    8ee4:	6a 03                	push   $0x3
    8ee6:	e8 e2 fc ff ff       	call   8bcd <roll>
    8eeb:	8d 83 ec fc ff ff    	lea    -0x314(%ebx),%eax
    8ef1:	89 04 24             	mov    %eax,(%esp)
    8ef4:	e8 8a fc ff ff       	call   8b83 <putline>
    8ef9:	83 c4 10             	add    $0x10,%esp
    8efc:	31 c0                	xor    %eax,%eax
    8efe:	89 c2                	mov    %eax,%edx
    8f00:	c1 e2 04             	shl    $0x4,%edx
    8f03:	80 bc 16 be 01 00 00 	cmpb   $0x80,0x1be(%esi,%edx,1)
    8f0a:	80 
    8f0b:	75 0c                	jne    8f19 <boot1main+0x4b>
    8f0d:	83 c0 1b             	add    $0x1b,%eax
    8f10:	c1 e0 04             	shl    $0x4,%eax
    8f13:	8b 74 06 16          	mov    0x16(%esi,%eax,1),%esi
    8f17:	eb 1a                	jmp    8f33 <boot1main+0x65>
    8f19:	40                   	inc    %eax
    8f1a:	83 f8 04             	cmp    $0x4,%eax
    8f1d:	75 df                	jne    8efe <boot1main+0x30>
    8f1f:	8d 83 39 fd ff ff    	lea    -0x2c7(%ebx),%eax
    8f25:	83 ec 0c             	sub    $0xc,%esp
    8f28:	31 f6                	xor    %esi,%esi
    8f2a:	50                   	push   %eax
    8f2b:	e8 b5 fc ff ff       	call   8be5 <panic>
    8f30:	83 c4 10             	add    $0x10,%esp
    8f33:	83 ec 0c             	sub    $0xc,%esp
    8f36:	ff 75 10             	pushl  0x10(%ebp)
    8f39:	e8 20 ff ff ff       	call   8e5e <parse_e820>
    8f3e:	8d 83 01 fd ff ff    	lea    -0x2ff(%ebx),%eax
    8f44:	89 04 24             	mov    %eax,(%esp)
    8f47:	e8 37 fc ff ff       	call   8b83 <putline>
    8f4c:	89 34 24             	mov    %esi,(%esp)
    8f4f:	e8 7b fe ff ff       	call   8dcf <load_kernel>
    8f54:	89 c6                	mov    %eax,%esi
    8f56:	8d 83 12 fd ff ff    	lea    -0x2ee(%ebx),%eax
    8f5c:	89 04 24             	mov    %eax,(%esp)
    8f5f:	e8 1f fc ff ff       	call   8b83 <putline>
    8f64:	58                   	pop    %eax
    8f65:	8d 83 50 00 00 00    	lea    0x50(%ebx),%eax
    8f6b:	5a                   	pop    %edx
    8f6c:	50                   	push   %eax
    8f6d:	56                   	push   %esi
    8f6e:	e8 19 00 00 00       	call   8f8c <exec_kernel>
    8f73:	8d 83 24 fd ff ff    	lea    -0x2dc(%ebx),%eax
    8f79:	89 04 24             	mov    %eax,(%esp)
    8f7c:	e8 64 fc ff ff       	call   8be5 <panic>
    8f81:	8d 65 f8             	lea    -0x8(%ebp),%esp
    8f84:	5b                   	pop    %ebx
    8f85:	5e                   	pop    %esi
    8f86:	5d                   	pop    %ebp
    8f87:	c3                   	ret    

00008f88 <__x86.get_pc_thunk.bx>:
    8f88:	8b 1c 24             	mov    (%esp),%ebx
    8f8b:	c3                   	ret    

00008f8c <exec_kernel>:
    8f8c:	fa                   	cli    
    8f8d:	b8 02 b0 ad 2b       	mov    $0x2badb002,%eax
    8f92:	8b 5c 24 08          	mov    0x8(%esp),%ebx
    8f96:	8b 54 24 04          	mov    0x4(%esp),%edx
    8f9a:	ff e2                	jmp    *%edx

Disassembly of section .rodata:

00008f9c <.rodata>:
    8f9c:	20 20                	and    %ah,(%eax)
    8f9e:	20 20                	and    %ah,(%eax)
    8fa0:	20 20                	and    %ah,(%eax)
    8fa2:	20 20                	and    %ah,(%eax)
    8fa4:	20 20                	and    %ah,(%eax)
    8fa6:	20 20                	and    %ah,(%eax)
    8fa8:	20 20                	and    %ah,(%eax)
    8faa:	20 20                	and    %ah,(%eax)
    8fac:	20 20                	and    %ah,(%eax)
    8fae:	20 20                	and    %ah,(%eax)
    8fb0:	20 20                	and    %ah,(%eax)
    8fb2:	20 20                	and    %ah,(%eax)
    8fb4:	20 20                	and    %ah,(%eax)
    8fb6:	20 20                	and    %ah,(%eax)
    8fb8:	20 20                	and    %ah,(%eax)
    8fba:	20 20                	and    %ah,(%eax)
    8fbc:	20 20                	and    %ah,(%eax)
    8fbe:	20 20                	and    %ah,(%eax)
    8fc0:	20 20                	and    %ah,(%eax)
    8fc2:	20 20                	and    %ah,(%eax)
    8fc4:	20 20                	and    %ah,(%eax)
    8fc6:	20 20                	and    %ah,(%eax)
    8fc8:	20 20                	and    %ah,(%eax)
    8fca:	20 20                	and    %ah,(%eax)
    8fcc:	20 20                	and    %ah,(%eax)
    8fce:	20 20                	and    %ah,(%eax)
    8fd0:	20 20                	and    %ah,(%eax)
    8fd2:	20 20                	and    %ah,(%eax)
    8fd4:	20 20                	and    %ah,(%eax)
    8fd6:	20 20                	and    %ah,(%eax)
    8fd8:	20 20                	and    %ah,(%eax)
    8fda:	20 20                	and    %ah,(%eax)
    8fdc:	20 20                	and    %ah,(%eax)
    8fde:	20 20                	and    %ah,(%eax)
    8fe0:	20 20                	and    %ah,(%eax)
    8fe2:	20 20                	and    %ah,(%eax)
    8fe4:	20 20                	and    %ah,(%eax)
    8fe6:	20 20                	and    %ah,(%eax)
    8fe8:	20 20                	and    %ah,(%eax)
    8fea:	20 20                	and    %ah,(%eax)
    8fec:	00 4b 65             	add    %cl,0x65(%ebx)
    8fef:	72 6e                	jb     905f <exec_kernel+0xd3>
    8ff1:	65 6c                	gs insb (%dx),%es:(%edi)
    8ff3:	20 69 73             	and    %ch,0x73(%ecx)
    8ff6:	20 6e 6f             	and    %ch,0x6f(%esi)
    8ff9:	74 20                	je     901b <exec_kernel+0x8f>
    8ffb:	61                   	popa   
    8ffc:	20 76 61             	and    %dh,0x61(%esi)
    8fff:	6c                   	insb   (%dx),%es:(%edi)
    9000:	69 64 20 65 6c 66 2e 	imul   $0x2e666c,0x65(%eax,%eiz,1),%esp
    9007:	00 
    9008:	2a 20                	sub    (%eax),%ah
    900a:	45                   	inc    %ebp
    900b:	38 32                	cmp    %dh,(%edx)
    900d:	30 20                	xor    %ah,(%eax)
    900f:	4d                   	dec    %ebp
    9010:	65 6d                	gs insl (%dx),%es:(%edi)
    9012:	6f                   	outsl  %ds:(%esi),(%dx)
    9013:	72 79                	jb     908e <exec_kernel+0x102>
    9015:	20 4d 61             	and    %cl,0x61(%ebp)
    9018:	70 20                	jo     903a <exec_kernel+0xae>
    901a:	2a 00                	sub    (%eax),%al
    901c:	53                   	push   %ebx
    901d:	74 61                	je     9080 <exec_kernel+0xf4>
    901f:	72 74                	jb     9095 <exec_kernel+0x109>
    9021:	20 62 6f             	and    %ah,0x6f(%edx)
    9024:	6f                   	outsl  %ds:(%esi),(%dx)
    9025:	74 31                	je     9058 <exec_kernel+0xcc>
    9027:	20 6d 61             	and    %ch,0x61(%ebp)
    902a:	69 6e 20 2e 2e 2e 00 	imul   $0x2e2e2e,0x20(%esi),%ebp
    9031:	4c                   	dec    %esp
    9032:	6f                   	outsl  %ds:(%esi),(%dx)
    9033:	61                   	popa   
    9034:	64 20 6b 65          	and    %ch,%fs:0x65(%ebx)
    9038:	72 6e                	jb     90a8 <exec_kernel+0x11c>
    903a:	65 6c                	gs insb (%dx),%es:(%edi)
    903c:	20 2e                	and    %ch,(%esi)
    903e:	2e 2e 0a 00          	cs or  %cs:(%eax),%al
    9042:	53                   	push   %ebx
    9043:	74 61                	je     90a6 <exec_kernel+0x11a>
    9045:	72 74                	jb     90bb <exec_kernel+0x12f>
    9047:	20 6b 65             	and    %ch,0x65(%ebx)
    904a:	72 6e                	jb     90ba <exec_kernel+0x12e>
    904c:	65 6c                	gs insb (%dx),%es:(%edi)
    904e:	20 2e                	and    %ch,(%esi)
    9050:	2e 2e 0a 00          	cs or  %cs:(%eax),%al
    9054:	46                   	inc    %esi
    9055:	61                   	popa   
    9056:	69 6c 20 74 6f 20 6c 	imul   $0x6f6c206f,0x74(%eax,%eiz,1),%ebp
    905d:	6f 
    905e:	61                   	popa   
    905f:	64 20 6b 65          	and    %ch,%fs:0x65(%ebx)
    9063:	72 6e                	jb     90d3 <exec_kernel+0x147>
    9065:	65 6c                	gs insb (%dx),%es:(%edi)
    9067:	2e 00 43 61          	add    %al,%cs:0x61(%ebx)
    906b:	6e                   	outsb  %ds:(%esi),(%dx)
    906c:	6e                   	outsb  %ds:(%esi),(%dx)
    906d:	6f                   	outsl  %ds:(%esi),(%dx)
    906e:	74 20                	je     9090 <exec_kernel+0x104>
    9070:	66 69 6e 64 20 62    	imul   $0x6220,0x64(%esi),%bp
    9076:	6f                   	outsl  %ds:(%esi),(%dx)
    9077:	6f                   	outsl  %ds:(%esi),(%dx)
    9078:	74 61                	je     90db <exec_kernel+0x14f>
    907a:	62 6c 65 20          	bound  %ebp,0x20(%ebp,%eiz,2)
    907e:	70 61                	jo     90e1 <exec_kernel+0x155>
    9080:	72 74                	jb     90f6 <exec_kernel+0x16a>
    9082:	69                   	.byte 0x69
    9083:	74 69                	je     90ee <exec_kernel+0x162>
    9085:	6f                   	outsl  %ds:(%esi),(%dx)
    9086:	6e                   	outsb  %ds:(%esi),(%dx)
    9087:	21 00                	and    %eax,(%eax)

Disassembly of section .eh_frame:

0000908c <.eh_frame>:
    908c:	14 00                	adc    $0x0,%al
    908e:	00 00                	add    %al,(%eax)
    9090:	00 00                	add    %al,(%eax)
    9092:	00 00                	add    %al,(%eax)
    9094:	01 7a 52             	add    %edi,0x52(%edx)
    9097:	00 01                	add    %al,(%ecx)
    9099:	7c 08                	jl     90a3 <exec_kernel+0x117>
    909b:	01 1b                	add    %ebx,(%ebx)
    909d:	0c 04                	or     $0x4,%al
    909f:	04 88                	add    $0x88,%al
    90a1:	01 00                	add    %eax,(%eax)
    90a3:	00 1c 00             	add    %bl,(%eax,%eax,1)
    90a6:	00 00                	add    %al,(%eax)
    90a8:	1c 00                	sbb    $0x0,%al
    90aa:	00 00                	add    %al,(%eax)
    90ac:	7a fa                	jp     90a8 <exec_kernel+0x11c>
    90ae:	ff                   	(bad)  
    90af:	ff 26                	jmp    *(%esi)
    90b1:	00 00                	add    %al,(%eax)
    90b3:	00 00                	add    %al,(%eax)
    90b5:	41                   	inc    %ecx
    90b6:	0e                   	push   %cs
    90b7:	08 85 02 4d 0d 05    	or     %al,0x50d4d02(%ebp)
    90bd:	57                   	push   %edi
    90be:	c5 0c 04             	lds    (%esp,%eax,1),%ecx
    90c1:	04 00                	add    $0x0,%al
    90c3:	00 24 00             	add    %ah,(%eax,%eax,1)
    90c6:	00 00                	add    %al,(%eax)
    90c8:	3c 00                	cmp    $0x0,%al
    90ca:	00 00                	add    %al,(%eax)
    90cc:	80 fa ff             	cmp    $0xff,%dl
    90cf:	ff 37                	pushl  (%edi)
    90d1:	00 00                	add    %al,(%eax)
    90d3:	00 00                	add    %al,(%eax)
    90d5:	41                   	inc    %ecx
    90d6:	0e                   	push   %cs
    90d7:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
    90dd:	42                   	inc    %edx
    90de:	86 03                	xchg   %al,(%ebx)
    90e0:	83 04 6f c3          	addl   $0xffffffc3,(%edi,%ebp,2)
    90e4:	41                   	inc    %ecx
    90e5:	c6 41 c5 0c          	movb   $0xc,-0x3b(%ecx)
    90e9:	04 04                	add    $0x4,%al
    90eb:	00 20                	add    %ah,(%eax)
    90ed:	00 00                	add    %al,(%eax)
    90ef:	00 64 00 00          	add    %ah,0x0(%eax,%eax,1)
    90f3:	00 8f fa ff ff 4a    	add    %cl,0x4afffffa(%edi)
    90f9:	00 00                	add    %al,(%eax)
    90fb:	00 00                	add    %al,(%eax)
    90fd:	4b                   	dec    %ebx
    90fe:	0e                   	push   %cs
    90ff:	08 85 02 4e 0d 05    	or     %al,0x50d4e02(%ebp)
    9105:	41                   	inc    %ecx
    9106:	83 03 6f             	addl   $0x6f,(%ebx)
    9109:	c5 c3 0c             	(bad)  
    910c:	04 04                	add    $0x4,%al
    910e:	00 00                	add    %al,(%eax)
    9110:	1c 00                	sbb    $0x0,%al
    9112:	00 00                	add    %al,(%eax)
    9114:	88 00                	mov    %al,(%eax)
    9116:	00 00                	add    %al,(%eax)
    9118:	b5 fa                	mov    $0xfa,%ch
    911a:	ff                   	(bad)  
    911b:	ff 18                	lcall  *(%eax)
    911d:	00 00                	add    %al,(%eax)
    911f:	00 00                	add    %al,(%eax)
    9121:	41                   	inc    %ecx
    9122:	0e                   	push   %cs
    9123:	08 85 02 4c 0d 05    	or     %al,0x50d4c02(%ebp)
    9129:	44                   	inc    %esp
    912a:	c5 0c 04             	lds    (%esp,%eax,1),%ecx
    912d:	04 00                	add    $0x0,%al
    912f:	00 18                	add    %bl,(%eax)
    9131:	00 00                	add    %al,(%eax)
    9133:	00 a8 00 00 00 ad    	add    %ch,-0x53000000(%eax)
    9139:	fa                   	cli    
    913a:	ff                   	(bad)  
    913b:	ff 17                	call   *(%edi)
    913d:	00 00                	add    %al,(%eax)
    913f:	00 00                	add    %al,(%eax)
    9141:	41                   	inc    %ecx
    9142:	0e                   	push   %cs
    9143:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
    9149:	00 00                	add    %al,(%eax)
    914b:	00 1c 00             	add    %bl,(%eax,%eax,1)
    914e:	00 00                	add    %al,(%eax)
    9150:	c4 00                	les    (%eax),%eax
    9152:	00 00                	add    %al,(%eax)
    9154:	a8 fa                	test   $0xfa,%al
    9156:	ff                   	(bad)  
    9157:	ff 13                	call   *(%ebx)
    9159:	00 00                	add    %al,(%eax)
    915b:	00 00                	add    %al,(%eax)
    915d:	41                   	inc    %ecx
    915e:	0e                   	push   %cs
    915f:	08 85 02 44 0d 05    	or     %al,0x50d4402(%ebp)
    9165:	4d                   	dec    %ebp
    9166:	c5 0c 04             	lds    (%esp,%eax,1),%ecx
    9169:	04 00                	add    $0x0,%al
    916b:	00 24 00             	add    %ah,(%eax,%eax,1)
    916e:	00 00                	add    %al,(%eax)
    9170:	e4 00                	in     $0x0,%al
    9172:	00 00                	add    %al,(%eax)
    9174:	9b                   	fwait
    9175:	fa                   	cli    
    9176:	ff                   	(bad)  
    9177:	ff 30                	pushl  (%eax)
    9179:	00 00                	add    %al,(%eax)
    917b:	00 00                	add    %al,(%eax)
    917d:	41                   	inc    %ecx
    917e:	0e                   	push   %cs
    917f:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
    9185:	42                   	inc    %edx
    9186:	86 03                	xchg   %al,(%ebx)
    9188:	83 04 68 c3          	addl   $0xffffffc3,(%eax,%ebp,2)
    918c:	41                   	inc    %ecx
    918d:	c6 41 c5 0c          	movb   $0xc,-0x3b(%ecx)
    9191:	04 04                	add    $0x4,%al
    9193:	00 28                	add    %ch,(%eax)
    9195:	00 00                	add    %al,(%eax)
    9197:	00 0c 01             	add    %cl,(%ecx,%eax,1)
    919a:	00 00                	add    %al,(%eax)
    919c:	a3 fa ff ff 61       	mov    %eax,0x61fffffa
    91a1:	00 00                	add    %al,(%eax)
    91a3:	00 00                	add    %al,(%eax)
    91a5:	41                   	inc    %ecx
    91a6:	0e                   	push   %cs
    91a7:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
    91ad:	43                   	inc    %ebx
    91ae:	87 03                	xchg   %eax,(%ebx)
    91b0:	86 04 83             	xchg   %al,(%ebx,%eax,4)
    91b3:	05 02 53 c3 41       	add    $0x41c35302,%eax
    91b8:	c6 41 c7 41          	movb   $0x41,-0x39(%ecx)
    91bc:	c5 0c 04             	lds    (%esp,%eax,1),%ecx
    91bf:	04 1c                	add    $0x1c,%al
    91c1:	00 00                	add    %al,(%eax)
    91c3:	00 38                	add    %bh,(%eax)
    91c5:	01 00                	add    %eax,(%eax)
    91c7:	00 d8                	add    %bl,%al
    91c9:	fa                   	cli    
    91ca:	ff                   	(bad)  
    91cb:	ff 26                	jmp    *(%esi)
    91cd:	00 00                	add    %al,(%eax)
    91cf:	00 00                	add    %al,(%eax)
    91d1:	4b                   	dec    %ebx
    91d2:	0e                   	push   %cs
    91d3:	08 85 02 48 0d 05    	or     %al,0x50d4802(%ebp)
    91d9:	52                   	push   %edx
    91da:	c5 0c 04             	lds    (%esp,%eax,1),%ecx
    91dd:	04 00                	add    $0x0,%al
    91df:	00 1c 00             	add    %bl,(%eax,%eax,1)
    91e2:	00 00                	add    %al,(%eax)
    91e4:	58                   	pop    %eax
    91e5:	01 00                	add    %eax,(%eax)
    91e7:	00 de                	add    %bl,%dh
    91e9:	fa                   	cli    
    91ea:	ff                   	(bad)  
    91eb:	ff 26                	jmp    *(%esi)
    91ed:	00 00                	add    %al,(%eax)
    91ef:	00 00                	add    %al,(%eax)
    91f1:	4b                   	dec    %ebx
    91f2:	0e                   	push   %cs
    91f3:	08 85 02 48 0d 05    	or     %al,0x50d4802(%ebp)
    91f9:	52                   	push   %edx
    91fa:	c5 0c 04             	lds    (%esp,%eax,1),%ecx
    91fd:	04 00                	add    $0x0,%al
    91ff:	00 20                	add    %ah,(%eax)
    9201:	00 00                	add    %al,(%eax)
    9203:	00 78 01             	add    %bh,0x1(%eax)
    9206:	00 00                	add    %al,(%eax)
    9208:	e4 fa                	in     $0xfa,%al
    920a:	ff                   	(bad)  
    920b:	ff 2b                	ljmp   *(%ebx)
    920d:	00 00                	add    %al,(%eax)
    920f:	00 00                	add    %al,(%eax)
    9211:	41                   	inc    %ecx
    9212:	0e                   	push   %cs
    9213:	08 85 02 4c 0d 05    	or     %al,0x50d4c02(%ebp)
    9219:	41                   	inc    %ecx
    921a:	83 03 58             	addl   $0x58,(%ebx)
    921d:	c5 c3 0c             	(bad)  
    9220:	04 04                	add    $0x4,%al
    9222:	00 00                	add    %al,(%eax)
    9224:	20 00                	and    %al,(%eax)
    9226:	00 00                	add    %al,(%eax)
    9228:	9c                   	pushf  
    9229:	01 00                	add    %eax,(%eax)
    922b:	00 eb                	add    %ch,%bl
    922d:	fa                   	cli    
    922e:	ff                   	(bad)  
    922f:	ff 6f 00             	ljmp   *0x0(%edi)
    9232:	00 00                	add    %al,(%eax)
    9234:	00 41 0e             	add    %al,0xe(%ecx)
    9237:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
    923d:	41                   	inc    %ecx
    923e:	87 03                	xchg   %eax,(%ebx)
    9240:	02 69 c7             	add    -0x39(%ecx),%ch
    9243:	41                   	inc    %ecx
    9244:	c5 0c 04             	lds    (%esp,%eax,1),%ecx
    9247:	04 28                	add    $0x28,%al
    9249:	00 00                	add    %al,(%eax)
    924b:	00 c0                	add    %al,%al
    924d:	01 00                	add    %eax,(%eax)
    924f:	00 36                	add    %dh,(%esi)
    9251:	fb                   	sti    
    9252:	ff                   	(bad)  
    9253:	ff 41 00             	incl   0x0(%ecx)
    9256:	00 00                	add    %al,(%eax)
    9258:	00 41 0e             	add    %al,0xe(%ecx)
    925b:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
    9261:	43                   	inc    %ebx
    9262:	87 03                	xchg   %eax,(%ebx)
    9264:	86 04 83             	xchg   %al,(%ebx,%eax,4)
    9267:	05 77 c3 41 c6       	add    $0xc641c377,%eax
    926c:	41                   	inc    %ecx
    926d:	c7 41 c5 0c 04 04 00 	movl   $0x4040c,-0x3b(%ecx)
    9274:	10 00                	adc    %al,(%eax)
    9276:	00 00                	add    %al,(%eax)
    9278:	ec                   	in     (%dx),%al
    9279:	01 00                	add    %eax,(%eax)
    927b:	00 4b fb             	add    %cl,-0x5(%ebx)
    927e:	ff                   	(bad)  
    927f:	ff 04 00             	incl   (%eax,%eax,1)
    9282:	00 00                	add    %al,(%eax)
    9284:	00 00                	add    %al,(%eax)
    9286:	00 00                	add    %al,(%eax)
    9288:	10 00                	adc    %al,(%eax)
    928a:	00 00                	add    %al,(%eax)
    928c:	00 02                	add    %al,(%edx)
    928e:	00 00                	add    %al,(%eax)
    9290:	3b fb                	cmp    %ebx,%edi
    9292:	ff                   	(bad)  
    9293:	ff 04 00             	incl   (%eax,%eax,1)
    9296:	00 00                	add    %al,(%eax)
    9298:	00 00                	add    %al,(%eax)
    929a:	00 00                	add    %al,(%eax)
    929c:	28 00                	sub    %al,(%eax)
    929e:	00 00                	add    %al,(%eax)
    92a0:	14 02                	adc    $0x2,%al
    92a2:	00 00                	add    %al,(%eax)
    92a4:	2b fb                	sub    %ebx,%edi
    92a6:	ff                   	(bad)  
    92a7:	ff 8f 00 00 00 00    	decl   0x0(%edi)
    92ad:	41                   	inc    %ecx
    92ae:	0e                   	push   %cs
    92af:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
    92b5:	43                   	inc    %ebx
    92b6:	87 03                	xchg   %eax,(%ebx)
    92b8:	86 04 83             	xchg   %al,(%ebx,%eax,4)
    92bb:	05 02 80 c3 46       	add    $0x46c38002,%eax
    92c0:	c6 41 c7 41          	movb   $0x41,-0x39(%ecx)
    92c4:	c5 0c 04             	lds    (%esp,%eax,1),%ecx
    92c7:	04 28                	add    $0x28,%al
    92c9:	00 00                	add    %al,(%eax)
    92cb:	00 40 02             	add    %al,0x2(%eax)
    92ce:	00 00                	add    %al,(%eax)
    92d0:	8e fb                	mov    %ebx,%?
    92d2:	ff                   	(bad)  
    92d3:	ff 70 00             	pushl  0x0(%eax)
    92d6:	00 00                	add    %al,(%eax)
    92d8:	00 41 0e             	add    %al,0xe(%ecx)
    92db:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
    92e1:	43                   	inc    %ebx
    92e2:	87 03                	xchg   %eax,(%ebx)
    92e4:	86 04 83             	xchg   %al,(%ebx,%eax,4)
    92e7:	05 02 66 c3 41       	add    $0x41c36602,%eax
    92ec:	c6 41 c7 41          	movb   $0x41,-0x39(%ecx)
    92f0:	c5 0c 04             	lds    (%esp,%eax,1),%ecx
    92f3:	04 24                	add    $0x24,%al
    92f5:	00 00                	add    %al,(%eax)
    92f7:	00 6c 02 00          	add    %ch,0x0(%edx,%eax,1)
    92fb:	00 d2                	add    %dl,%dl
    92fd:	fb                   	sti    
    92fe:	ff                   	(bad)  
    92ff:	ff                   	(bad)  
    9300:	ba 00 00 00 00       	mov    $0x0,%edx
    9305:	41                   	inc    %ecx
    9306:	0e                   	push   %cs
    9307:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
    930d:	42                   	inc    %edx
    930e:	86 03                	xchg   %al,(%ebx)
    9310:	83 04 02 b2          	addl   $0xffffffb2,(%edx,%eax,1)
    9314:	c3                   	ret    
    9315:	41                   	inc    %ecx
    9316:	c6 41 c5 0c          	movb   $0xc,-0x3b(%ecx)
    931a:	04 04                	add    $0x4,%al
    931c:	10 00                	adc    %al,(%eax)
    931e:	00 00                	add    %al,(%eax)
    9320:	94                   	xchg   %eax,%esp
    9321:	02 00                	add    (%eax),%al
    9323:	00 64 fc ff          	add    %ah,-0x1(%esp,%edi,8)
    9327:	ff 04 00             	incl   (%eax,%eax,1)
    932a:	00 00                	add    %al,(%eax)
    932c:	00 00                	add    %al,(%eax)
    932e:	00 00                	add    %al,(%eax)

Disassembly of section .got.plt:

00009330 <_GLOBAL_OFFSET_TABLE_>:
    9330:	00 00                	add    %al,(%eax)
    9332:	00 00                	add    %al,(%eax)
    9334:	00 00                	add    %al,(%eax)
    9336:	00 00                	add    %al,(%eax)
    9338:	00 00                	add    %al,(%eax)
    933a:	00 00                	add    %al,(%eax)

Disassembly of section .data:

00009340 <hex.1142>:
    9340:	30 31                	xor    %dh,(%ecx)
    9342:	32 33                	xor    (%ebx),%dh
    9344:	34 35                	xor    $0x35,%al
    9346:	36 37                	ss aaa 
    9348:	38 39                	cmp    %bh,(%ecx)
    934a:	61                   	popa   
    934b:	62 63 64             	bound  %esp,0x64(%ebx)
    934e:	65 66 00 00          	data16 add %al,%gs:(%eax)
    9352:	00 00                	add    %al,(%eax)

00009354 <dec.1137>:
    9354:	30 31                	xor    %dh,(%ecx)
    9356:	32 33                	xor    (%ebx),%dh
    9358:	34 35                	xor    $0x35,%al
    935a:	36 37                	ss aaa 
    935c:	38 39                	cmp    %bh,(%ecx)
    935e:	00 00                	add    %al,(%eax)

00009360 <video>:
    9360:	00 80 0b 00      	add    %al,-0x7063fff5(%eax)

00009364 <blank>:
    9364:	9c                   	pushf  
    9365:	8f 00                	popl   (%eax)
    9367:	00 00                	add    %al,(%eax)
    9369:	00 00                	add    %al,(%eax)
    936b:	00 00                	add    %al,(%eax)
    936d:	00 00                	add    %al,(%eax)
    936f:	00 00                	add    %al,(%eax)
    9371:	00 00                	add    %al,(%eax)
    9373:	00 00                	add    %al,(%eax)
    9375:	00 00                	add    %al,(%eax)
    9377:	00 00                	add    %al,(%eax)
    9379:	00 00                	add    %al,(%eax)
    937b:	00 00                	add    %al,(%eax)
    937d:	00 00                	add    %al,(%eax)
    937f:	00               	add    %al,0x0(%eax)

00009380 <mboot_info>:
    9380:	40                   	inc    %eax
    9381:	00 00                	add    %al,(%eax)
    9383:	00 00                	add    %al,(%eax)
    9385:	00 00                	add    %al,(%eax)
    9387:	00 00                	add    %al,(%eax)
    9389:	00 00                	add    %al,(%eax)
    938b:	00 00                	add    %al,(%eax)
    938d:	00 00                	add    %al,(%eax)
    938f:	00 00                	add    %al,(%eax)
    9391:	00 00                	add    %al,(%eax)
    9393:	00 00                	add    %al,(%eax)
    9395:	00 00                	add    %al,(%eax)
    9397:	00 00                	add    %al,(%eax)
    9399:	00 00                	add    %al,(%eax)
    939b:	00 00                	add    %al,(%eax)
    939d:	00 00                	add    %al,(%eax)
    939f:	00 00                	add    %al,(%eax)
    93a1:	00 00                	add    %al,(%eax)
    93a3:	00 00                	add    %al,(%eax)
    93a5:	00 00                	add    %al,(%eax)
    93a7:	00 00                	add    %al,(%eax)
    93a9:	00 00                	add    %al,(%eax)
    93ab:	00 00                	add    %al,(%eax)
    93ad:	00 00                	add    %al,(%eax)
    93af:	00 00                	add    %al,(%eax)
    93b1:	00 00                	add    %al,(%eax)
    93b3:	00 00                	add    %al,(%eax)
    93b5:	00 00                	add    %al,(%eax)
    93b7:	00 00                	add    %al,(%eax)
    93b9:	00 00                	add    %al,(%eax)
    93bb:	00 00                	add    %al,(%eax)
    93bd:	00 00                	add    %al,(%eax)
    93bf:	00 00                	add    %al,(%eax)
    93c1:	00 00                	add    %al,(%eax)
    93c3:	00 00                	add    %al,(%eax)
    93c5:	00 00                	add    %al,(%eax)
    93c7:	00 00                	add    %al,(%eax)
    93c9:	00 00                	add    %al,(%eax)
    93cb:	00 00                	add    %al,(%eax)
    93cd:	00 00                	add    %al,(%eax)
    93cf:	00 00                	add    %al,(%eax)
    93d1:	00 00                	add    %al,(%eax)
    93d3:	00 00                	add    %al,(%eax)
    93d5:	00 00                	add    %al,(%eax)
    93d7:	00 00                	add    %al,(%eax)
    93d9:	00 00                	add    %al,(%eax)
    93db:	00 00                	add    %al,(%eax)
    93dd:	00 00                	add    %al,(%eax)
    93df:	00                   	.byte 0x0

Disassembly of section .bss:

000093e0 <__bss_start>:
    93e0:	00 00                	add    %al,(%eax)
    93e2:	00 00                	add    %al,(%eax)
    93e4:	00 00                	add    %al,(%eax)
    93e6:	00 00                	add    %al,(%eax)
    93e8:	00 00                	add    %al,(%eax)
    93ea:	00 00                	add    %al,(%eax)
    93ec:	00 00                	add    %al,(%eax)
    93ee:	00 00                	add    %al,(%eax)
    93f0:	00 00                	add    %al,(%eax)
    93f2:	00 00                	add    %al,(%eax)
    93f4:	00 00                	add    %al,(%eax)
    93f6:	00 00                	add    %al,(%eax)
    93f8:	00 00                	add    %al,(%eax)
    93fa:	00 00                	add    %al,(%eax)
    93fc:	00 00                	add    %al,(%eax)
    93fe:	00 00                	add    %al,(%eax)
    9400:	00 00                	add    %al,(%eax)
    9402:	00 00                	add    %al,(%eax)
    9404:	00 00                	add    %al,(%eax)
    9406:	00 00                	add    %al,(%eax)

00009408 <row>:
    9408:	00 00                	add    %al,(%eax)
    940a:	00 00                	add    %al,(%eax)

Disassembly of section .comment:

00000000 <.comment>:
   0:	47                   	inc    %edi
   1:	43                   	inc    %ebx
   2:	43                   	inc    %ebx
   3:	3a 20                	cmp    (%eax),%ah
   5:	28 55 62             	sub    %dl,0x62(%ebp)
   8:	75 6e                	jne    78 <PROT_MODE_DSEG+0x68>
   a:	74 75                	je     81 <PR_BOOTABLE+0x1>
   c:	20 37                	and    %dh,(%edi)
   e:	2e 34 2e             	cs xor $0x2e,%al
  11:	30 2d 31 75 62 75    	xor    %ch,0x75627531
  17:	6e                   	outsb  %ds:(%esi),(%dx)
  18:	74 75                	je     8f <PR_BOOTABLE+0xf>
  1a:	31 7e 31             	xor    %edi,0x31(%esi)
  1d:	38 2e                	cmp    %ch,(%esi)
  1f:	30 34 29             	xor    %dh,(%ecx,%ebp,1)
  22:	20 37                	and    %dh,(%edi)
  24:	2e 34 2e             	cs xor $0x2e,%al
  27:	30 00                	xor    %al,(%eax)
