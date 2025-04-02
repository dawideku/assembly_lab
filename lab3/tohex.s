SYSEXIT = 1
EXIT_SUCCESS = 0
STDOUT = 1
SYSWRITE = 4
SYSREAD = 3
STDIN = 0

.text
newline: .ascii "\n"
newline_len = . - newline
msg: .ascii "\nWrite text: "
msg_len = . - msg
msg2: .ascii "New text: "
msg2_len = . - msg2

.data
buf: .space 8
buf_len = . - buf
binary_out: .space 32
binary_out_len = . - binary_out
.text

.global _start
_start:

mov $SYSWRITE, %eax
mov $STDOUT, %ebx
mov $msg, %ecx
mov $msg_len, %edx
int $0x80

mov $SYSREAD, %eax
mov $STDIN, %ebx
mov $buf, %ecx
mov $buf_len, %edx
int $0x80

debug:
xor %ebx, %ebx
mov %eax, %ecx
xor %eax, %eax
sub $1, %ecx
xor %edx, %edx
xor %edi, %edi

petla:
mov buf(%edx), %bl
mov $48, %edi
cmp %edi, %ebx
jl koniec

add $9, %edi
cmp %edi, %ebx
jle cyfra

mov $65, %edi
cmp %edi, %ebx
jl koniec

add $5, %edi
cmp %edi, %ebx
jle duza

jmp koniec

cyfra:
sub $48, %bl
jmp koniec

duza:
sub $55, %bl

koniec:
shl $4, %eax
add %ebx, %eax
mov %bl, buf(%edx)
inc %edx
cmp %ecx, %edx
jle petla

test:

xor %ecx, %ecx
xor %ebx, %ebx
xor %esi, %esi
mov $31, %edx

petla2:
xor %ebx, %ebx
clc
shl $1, %eax
adc $1, %ebx
cmp $2, %ebx
je jeden

zero:
movb $48, binary_out(%esi)
jmp koniec2

jeden:
movb $49, binary_out(%esi)

koniec2:
inc %esi
cmp %edx, %esi
jle petla2


mov $SYSWRITE, %eax
mov $STDOUT, %ebx
mov $msg2, %ecx
mov $msg2_len, %edx
int $0x80

mov $SYSWRITE, %eax
mov $STDOUT, %ebx
mov $binary_out, %ecx
mov $binary_out_len, %edx
int $0x80

mov $SYSWRITE, %eax
mov $STDOUT, %ebx
mov $newline, %ecx
mov $newline_len, %edx
int $0x80

mov $SYSEXIT, %eax
mov $EXIT_SUCCESS, %ebx
int $0x80
