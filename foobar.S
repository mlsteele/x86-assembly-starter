.text
.globl _start
_start:
    # write string to stdout
    # syscall:%eax (%ebx, %ecx, %edx, %esx, %edi)
    # ssize_t write(int fd, const void *buf, size_t count);
    movl $len, %edx # arg 3: message length
    movl $msg, %ecx # arg 2: pointer to message
    movl $1, %ebx # arg 1: file handle (stdout)
    movl $4, %eax # syscall: write
    int $0x80

    # exit
    movl $0, %ebx # arg 1: status
    movl $1, %eax # syscall: exit
    int $0x80

.data
msg:
    .ascii "Hello, world!\n"
    len = . - msg
