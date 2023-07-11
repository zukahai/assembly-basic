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
        mov ax,@data
        mov ds,ax
       
        display_notification_1:
            lea dx,tb1
            mov ah,9
            int 21h
            
        read_number_1:
            mov ah,1
            int 21h
            cmp al,13
            je display_notification_2
            sub al,30h
            mov cl,al
            mov al,number1
            mov bl,10
            mul bl
            add al,cl
            mov number1,al
            jmp read_number_1
           
        display_notification_2:
            lea dx,tb2
            mov ah,9
            int 21h

        read_number_2:
            mov ah,1
            int 21h
            cmp al,13
            je display_notification_3
            sub al,30h
            mov cl,al
            mov al,number2
            mov bl,10
            mul bl
            add al,cl
            mov number2,al
            jmp read_number_2

        display_notification_3:
            lea dx,tb3
            mov ah,9
            int 21h

        mov al,number1
        add al,number2
        mov ah,0
        mov cx,0
        mov bl,10

        sum_to_stack:
            div bl
            push ax
            inc cx
            cmp al,0
            je display_result
            jmp sum_to_stack

        display_result:
            pop ax
            mov dl,ah
            add dl,30h
            mov ah,2
            int 21h
            loop display_result ;cx >0 

        exit_programing:       
        mov ah,76
        int 21h
        main endp
    end main