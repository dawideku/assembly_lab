SYSEXIT = 1
EXIT_SUCCESS = 0
STDOUT = 1
SYSWRITE = 4
SYSREAD = 3
STDIN = 0

.text
newline: .ascii "\n"
newline_len = . - newline
msg2: .ascii "Sum as binary:\n"
msg2_len = . - msg2
of: .ascii "1"
of_len = 1

.data
liczba_1:
.long 0xF0643000, 0x99900000, 0xAAA00231, 0xF0F0F0F0
liczba_2:
.long 0x01000000, 0x01100000, 0xBBB50000, 0x12312313
out: .space 32
out_bin: .space 128
out_bin_len = . - out_bin

.text

.global _start
_start:

mov $12, %edx
mov $4, %ecx
clc
pushf

petla:
popf
mov liczba_1(%edx), %eax
adcl liczba_2(%edx), %eax
pushf
mov %eax, out(%edx)
sub $4, %edx
loop petla


koniec:

test:

xor %edx, %edx

petla_main:

movl out(%edx), %eax
xor %esi, %esi

petla2:
xor %ebx, %ebx
clc
shl $1, %eax
adc $1, %ebx
cmp $2, %ebx
je jeden

zero:
movb $48, out_bin(%esi,%edx,8)
jmp koniec2

jeden:
movb $49, out_bin(%esi,%edx,8)

koniec2:
inc %esi
cmp $31, %esi
jle petla2

iter_1:

add $4, %edx
cmp $17, %edx
jle petla_main

mov $SYSWRITE, %eax
mov $STDOUT, %ebx
mov $msg2, %ecx
mov $msg2_len, %edx
int $0x80

xor %eax, %eax
popf
adc %eax, %eax
cmp $1, %eax
jne no_of

mov $SYSWRITE, %eax
mov $STDOUT, %ebx
mov $of, %ecx
mov $of_len, %edx
int $0x80

no_of:

mov $SYSWRITE, %eax
mov $STDOUT, %ebx
mov $out_bin, %ecx
mov $out_bin_len, %edx
int $0x80

mov $SYSWRITE, %eax
mov $STDOUT, %ebx
mov $newline, %ecx
mov $newline_len, %edx
int $0x80

mov $SYSEXIT, %eax
mov $EXIT_SUCCESS, %ebx
int $0x80
