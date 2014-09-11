.text
.globl _start
_start:
    # read from stdin
    # ssize_t read(int fd, void *buf, size_t count);
    movl $msg2_len, %edx # arg 3: max message size
    movl $msg2, %ecx # arg 2: pointer to message
    movl $0, %ebx # arg 1: file handle (stdin)
    movl $3, %eax # syscall: read
    int $0x80

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
    movl $0, %ebx # arg 1: status
    movl $1, %eax # syscall: exit
    int $0x80

.data
msg1:
    .ascii "Hello, world!\n"
    msg1_len = . - msg1

.bss
msg2:
    .space 128
    # .ascii "justafew\n"
    msg2_len = . - msg2
