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
buf: .space 100
buf_len = . - buf

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
sub $2, %ecx
xor %edx, %edx

petla:
mov buf(%edx), %bl
mov $65, %al
cmp %al, %bl
jl koniec

add $25, %al
cmp %al, %bl
jle mala

mov $97, %al
cmp %al, %bl
jl koniec

add $25, %al
cmp %al, %bl
jle duza

jmp koniec

mala:
add $32, %bl
jmp koniec

duza:
sub $32, %bl

koniec:
mov %bl, buf(%edx)
add $2, %edx
cmp %ecx, %edx
jle petla

mov $SYSWRITE, %eax
mov $STDOUT, %ebx
mov $msg2, %ecx
mov $msg2_len, %edx
int $0x80

mov $SYSWRITE, %eax
mov $STDOUT, %ebx
mov $buf, %ecx
mov $buf_len, %edx
int $0x80

mov $SYSWRITE, %eax
mov $STDOUT, %ebx
mov $newline, %ecx
mov $newline_len, %edx
int $0x80

mov $SYSEXIT, %eax
mov $EXIT_SUCCESS, %ebx
int $0x80
