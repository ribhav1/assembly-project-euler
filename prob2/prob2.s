.text
.global main

main:
    # save non-volatile register values
    pushq %r12
    pushq %r13
    pushq %r14
    # 3 pushes do leave the stack correctly aligned

    movl $0, %r12d  # sum = 0
    movl $1, %r13d  # fib1 = 1
    movl $2, %r14d  # fib2 = 2

    # add second fibonacci number to sum (first is not even)
    addl %r14d, %r12d
.loop:
    movl %r14d, %esi    # move last fibonacci number into temporary register
    addl %r13d, %r14d   # add last two fibonacci numbers and store new number into fib2 reigster
    movl %esi, %r13d    # move old highest number into fib1 spot

    cmpl $4000000, %r14d # compare newest fibonacci number to 4 million
    jg .done            # if newest number exceeds 4 million, loop is over

    movl %r14d, %edi    # move newest fibonacci number into input register for following function
    call is_even
    
    cmpl $0, %eax       # check if even (return/remainder value 0)
    jne .loop           # if not 0 (not even) then continue loop from top

    addl %r14d, %r12d   # add newest fibonacci number to sum 
    jmp .loop           # continue loop
.done:
    movl %r12d, %eax    # move sum into return register
    
    popq %r14
    popq %r13
    popq %r12
    ret

is_even:
    movl %edi, %eax # move input into intermediate register
    cltd
    movl $2, %edi   # mode divisor into intermediate register
    idivl %edi      # divide input by 2
    movl %edx, %eax # move remainder into return register
    ret