.model tiny
.stack 100h
.data
    tb1 db 'Enter number of array : $'
    tb2 db 13, 10, 'Enter number : $'
    tb3 db 13, 10, 'Sum numbers of array is : $'
    number db 0
    number_of_array db 0
    sum db 0
.code
    ;===================== Main =====================;
    main proc
        call load_data
        call solve
        call display_result
        call exit_program
    main endp

    ;================= Load data ====================;
    load_data proc
        mov ax, @data
        mov ds, ax
        ret
    load_data endp

    ;===================== Solve=====================;
    solve proc
        call display_notification_1
        mov number, 0
        call read_number
        mov al, number
        mov number_of_array, al

        read_element:
            cmp number_of_array, 0
                je setup_display_sum
            sub number_of_array, 1

            ;=== read element and add to sum ===
            call display_notification_2
            mov number, 0
            call read_number
            mov al, sum
            add al, number
            mov sum, al

            jmp read_element

        setup_display_sum:
            call display_notification_3
            mov al, sum
            ret
    solve endp

    ;============== Display notification 1 ================;
    display_notification_1 proc
        lea dx, tb1
        mov ah, 9
        int 21h
        ret
    display_notification_1 endp

    ;============== Display notification 2 ================;
    display_notification_2 proc
        lea dx, tb2
        mov ah, 9
        int 21h
        ret
    display_notification_2 endp

    ;============== Display notification 3 ================;
    display_notification_3 proc
        lea dx, tb3
        mov ah, 9
        int 21h
        ret
    display_notification_3 endp

    
    
    read_number proc
        mov ah, 1
        int 21h
        cmp al, 13
        je read_number_exit
        sub al, 30h
        mov cl, al
        mov al, number
        mov bl, 10
        mul bl
        add al, cl
        mov number, al
        jmp read_number
    
    read_number_exit:
        ret
    read_number endp

    ;=====================Display Result=====================;
    display_result proc
        mov cx, 0
        mov bl, 10
        sum_to_stack:
            mov ah, 0
            div bl
            push ax
            inc cx
            cmp al, 0
            je display
            jmp sum_to_stack
        display:
            pop ax
            mov dl, ah
            add dl, 30h
            mov ah, 2
            int 21h
            loop display ;cx >0 
    display_result endp

    ;=====================exit=====================;
    exit_program proc
        mov ah, 76
        int 21h
        ret
    exit_program endp

    end main
