.model tiny
.stack 100h
.data
    tb1 db 'Enter a number : $'
    tb2 db 13, 10, 'Number is prime $'
    tb3 db 13, 10, 'Numbers not is prime : $'
    number db 0
.code
    ;===================== Main =====================;
    main proc
        call load_data
        call check_prime
        call exit_program
    main endp
    
    ;===================== Load data =====================;
    load_data proc
        mov ax, @data
        mov ds, ax
        ret
    load_data endp

    ;===================== Solve=====================;
    check_prime proc
        call display_notification_1
        mov number, 0
        call read_number

        ; Kiểm tra xem số nhập vào có phải là số nguyên tố hay không
        mov bl, 2     ; Bắt đầu kiểm tra từ số 2
        mov dx, 0     ; Khởi tạo dx = 0 để kiểm tra phần dư

        ; Nếu number < 2 thì number không phải là số nguyên tố
        cmp number, 2
            jl not_prime

        check_divisible:
            mov al, bl
            mul bl
            cmp al, number   ; So sánh giá trị của bl*bl với số cần kiểm tra
            jg is_prime   ; Nếu bl*bl > số cần kiểm tra, số là số nguyên tố

            mov al, number   ; Di chuyển số cần kiểm tra vào thanh ghi ax
            mov ah, 0
            div bl       ; Chia ax cho bl, phần nguyên trong al, phần dư trong ah
            cmp ah, 0    ; Kiểm tra phần dư
            je not_prime  ; Nếu phần dư bằng 0, số không phải là số nguyên tố
            inc bl       ; Tăng giá trị của bl để kiểm tra số tiếp theo
            jmp check_divisible

            not_prime:
                call display_notification_3
                jmp exit_check_prime

            is_prime:
                call display_notification_2
                jmp exit_check_prime

            exit_check_prime:
                ret
    check_prime endp

    ;========= Display notification 1 =========;
    display_notification_1 proc
        lea dx, tb1
        mov ah, 9
        int 21h
        ret
    display_notification_1 endp

    ;======== Display notification 2 ==========;
    display_notification_2 proc
        lea dx, tb2
        mov ah, 9
        int 21h
        ret
    display_notification_2 endp

    ;======= Display notification 3 ===========;
    display_notification_3 proc
        lea dx, tb3
        mov ah, 9
        int 21h
        ret
    display_notification_3 endp
    
    ;========== Read number ==========;
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

    ;=====================exit=====================;
    exit_program proc
        mov ah, 76
        int 21h
        ret
    exit_program endp

    end main
