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


.data
liczba_1:
.long 0xF0643000, 0x99900000, 0xAAA00231, 0xF0F0F0F0
liczba_2:
.long 0x01000000, 0x01100000, 0xBBB50000, 0x12312313
out: .space 32
out_bin: .space 256
out_bin_len = . - out_bin

.text

.global _start
_start:

mov $28, %edx
mov $4, %ecx

petla:
xor %eax, %eax
mov %eax, out(%edx)
sub $4, %edx
loop petla

mov $3, %ebx
mov $3, %ecx

petla_i:

petla_j:

mov liczba_1(,%ebx, 4), %eax
mov liczba_2(,%ecx, 4), %edx
mul %edx
mov %ebx, %esi
add %ecx, %esi
inc %esi
add out(,%esi, 4), %eax
dec %esi
adc out(,%esi, 4), %edx
mov %edx, out(,%esi,4)
inc %esi
mov %eax, out(,%esi,4)

dec %ecx
cmp $-1, %ecx
jg petla_j

mov $3, %ecx
dec %ebx
cmp $-1, %ebx
jg petla_i


test:

koniec:

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
cmp $33, %edx
jle petla_main

mov $SYSWRITE, %eax
mov $STDOUT, %ebx
mov $msg2, %ecx
mov $msg2_len, %edx
int $0x80


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
