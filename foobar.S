.text
.globl _start
_start:
    # what's the first thing on the stack? argc?
    pop %ebx
counting_argc:
    call print_dot
    testl $0, %ebx
    subl $1, %ebx
    jne counting_argc

    call print_newline

    # read from stdin
    # ssize_t read(int fd, void *buf, size_t count);
    movl $msg2_len, %edx # arg 3: max message size
    movl $msg2, %ecx # arg 2: pointer to message
    movl $0, %ebx # arg 1: file handle (stdin)
    movl $3, %eax # syscall: read
    int $0x80
    movl %eax, %esi

    # write string to stdout
    # syscall:%eax (%ebx, %ecx, %edx, %esx, %edi)
    # ssize_t write(int fd, const void *buf, size_t count);
    movl $msg1_len, %edx # arg 3: message length
    movl $msg1, %ecx # arg 2: pointer to message
    movl $1, %ebx # arg 1: file handle (stdout)
    movl $4, %eax # syscall: write
    int $0x80

    # write string to stdout
    # syscall:%eax (%ebx, %ecx, %edx, %esx, %edi)
    # ssize_t write(int fd, const void *buf, size_t count);
    movl $msg2_len, %edx # arg 3: message length
    movl $msg2, %ecx # arg 2: pointer to message
    movl $1, %ebx # arg 1: file handle (stdout)
    movl $4, %eax # syscall: write
    int $0x80

    # exit
    # movl $0, %ebx # arg 1: status
    subl $1, %esi
    movl %esi, %ebx
    movl $1, %eax # syscall: exit
    int $0x80

print_dot:
    # takes no arguments, modifies %eax
    push %ebx
    push %ecx
    push %edx
    # write string to stdout
    # syscall:%eax (%ebx, %ecx, %edx, %esx, %edi)
    # ssize_t write(int fd, const void *buf, size_t count);
    movl $msg_dot_len, %edx # arg 3: message length
    movl $msg_dot, %ecx # arg 2: pointer to message
    movl $1, %ebx # arg 1: file handle (stdout)
    movl $4, %eax # syscall: write
    int $0x80
    pop %edx
    pop %ecx
    pop %ebx
    ret

print_newline:
    # takes no arguments, modifies %eax
    push %ebx
    push %ecx
    push %edx
    # write string to stdout
    # syscall:%eax (%ebx, %ecx, %edx, %esx, %edi)
    # ssize_t write(int fd, const void *buf, size_t count);
    movl $msg_newline_len, %edx # arg 3: message length
    movl $msg_newline, %ecx # arg 2: pointer to message
    movl $1, %ebx # arg 1: file handle (stdout)
    movl $4, %eax # syscall: write
    int $0x80
    pop %edx
    pop %ecx
    pop %ebx
    ret


.data
msg1:
    .ascii "Hello, world!\n"
    msg1_len = . - msg1

msg_dot:
    .ascii "."
    msg_dot_len = . - msg_dot

msg_newline:
    .ascii "\n"
    msg_newline_len = . - msg_newline

.bss
msg2:
    .space 128
    # .ascii "justafew\n"
    msg2_len = . - msg2
