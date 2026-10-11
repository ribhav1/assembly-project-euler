.text
.global main
.global is_multiple

main:
    # preserve non-volatile register values
    pushq %r12
    pushq %r13

    movl $0, %r12d   # int sum = 0
    movl $1, %r13d   # int i = 1
.loop:
    cmpl $999, %r13d # compare i with upper bound
    jg .loop_end    # if i > 999, loop is over

    movl %r13d, %ecx # move i into intermediate register
    call is_multiple # check if i is multiple of 3 or 5
    cmpl $0, %eax   # compare return register against 0 (0 indicates divisible 1 indicates not)
    je .continue    # if not a multiple then continue loop from top with next i
    
    addl %r13d, %r12d # if divisible then add i to sum
.continue:
    addl $1, %r13d   # add one to i
    jmp .loop       # continue loop from top
.loop_end:
    movl %r12d, %eax # move sum into return register
    popq %r13
    popq %r12
    ret             # end function

is_multiple:
    movl %ecx, %eax # move argument into %eax
    cltd            # prepare %eax for division (sign extends into 64 bit par EDX:EAX)
    movl $3, %edi   # move divisor into intermediate register
    idivl %edi      # divide input by 3
    cmpl $0, %edx   # compare remainder with 0 
    je .divisble    # if remainder is 0 then exit 1 (input is divisible by 3 or 5)

    movl %ecx, %eax # again move input into %eax to check for divisibility by 5
    cltd            # prepare %eax for division
    movl $5, %edi   # move 5 into intermediate register
    idivl %edi      # divide input by 5
    cmpl $0, %edx   # compare remainder to 0
    je .divisble    # if remainder equals 0 then, again, exit 1 (as divisible)

    movl $0, %eax   # otherwise, exit 0
    ret

.divisble:
    movl $1, %eax
    ret
