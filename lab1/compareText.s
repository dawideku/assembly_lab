SYSEXIT = 1
EXIT_SUCCESS = 0
STDOUT = 1
SYSWRITE = 4
SYSREAD = 3
STDIN = 0

.text
newline: .ascii "\n"
newline_len = . - newline
msg3: .ascii "Text to compare: "
msg3_len = . - msg3
msg: .ascii "\nWrite text: "
msg_len = . - msg
msg2: .ascii "Written text: "
msg2_len = . - msg2
zmienna: .ascii "jakistekst"
zmienna_len = . - zmienna
takie_same: .ascii "same text\n"
takie_same_len = . - takie_same
nie: .ascii "Not "
nie_len = . - nie


.data
buf: .ascii "          "
buf_len = . - buf

.text

.global _start
_start:

mov $SYSWRITE, %eax
mov $STDOUT, %ebx
mov $msg3, %ecx
mov $msg3_len, %edx
int $0x80

mov $SYSWRITE, %eax
mov $STDOUT, %ebx
mov $zmienna, %ecx
mov $zmienna_len, %edx
int $0x80

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
mov $9, %edx
xor %ecx, %ecx
petla:
mov zmienna(%ecx), %al
mov buf(%ecx), %bl
cmp %al, %bl
jne not_equal
inc %ecx
cmp %edx, %ecx
jle petla
jmp equal

not_equal:
mov $SYSWRITE, %eax
mov $STDOUT, %ebx
mov $nie, %ecx
mov $nie_len, %edx
int $0x80

equal:
mov $SYSWRITE, %eax
mov $STDOUT, %ebx
mov $takie_same, %ecx
mov $takie_same_len, %edx
int $0x80

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
