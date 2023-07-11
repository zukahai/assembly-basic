.model tiny
.stack 100h
.data
    tb1 db 'Enter first number : $'
    tb2 db 13,10,'Enter second number : $'
    tb3 db 13,10,'Sum two numbers is : $'
    number1 db 0
    number2 db 0
.code
    main proc
        mov ax, @data
        mov ds, ax

        call display_notification_1
        call read_number_1
        call display_notification_2
        call read_number_2
        call display_notification_3
        call calculate_sum
        call display_result
        call exit_program

        main endp
    
    display_notification_1 proc
        lea dx, tb1
        mov ah, 9
        int 21h
        ret
    display_notification_1 endp
    
    read_number_1 proc
        mov ah, 1
        int 21h
        cmp al, 13
        je read_number_1_exit
        sub al, 30h
        mov cl, al
        mov al, number1
        mov bl, 10
        mul bl
        add al, cl
        mov number1, al
        jmp read_number_1
    
    read_number_1_exit:
        ret
    read_number_1 endp
    
    display_notification_2 proc
        lea dx, tb2
        mov ah, 9
        int 21h
        ret
    display_notification_2 endp
    
    read_number_2 proc
        mov ah, 1
        int 21h
        cmp al, 13
        je read_number_2_exit
        sub al, 30h
        mov cl, al
        mov al, number2
        mov bl, 10
        mul bl
        add al, cl
        mov number2, al
        jmp read_number_2
    
    read_number_2_exit:
        ret
    read_number_2 endp
    
    display_notification_3 proc
        lea dx, tb3
        mov ah, 9
        int 21h
        ret
    display_notification_3 endp
    
    calculate_sum proc
        mov al, number1
        add al, number2
        mov ah, 0
        mov cx, 0
        mov bl, 10

        sum_to_stack:
            div bl
            push ax
            inc cx
            cmp al, 0
            je calculate_sum_exit
            jmp sum_to_stack

        calculate_sum_exit:
        ret
    calculate_sum endp
    
    display_result proc
        ; pop ax
        ; mov dl, ah
        ; add dl, 30h
        ; mov ah, 2
        ; int 21h
        ; loop display_result ; cx > 0
        ; ret
        call display_notification_1
    display_result endp
    
    exit_program proc
        mov ah, 76
        int 21h
        ret
    exit_program endp
    
    end main
