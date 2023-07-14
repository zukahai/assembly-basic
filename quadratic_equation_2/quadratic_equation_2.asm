.model tiny
.stack 100h
.data
    tb1 db 'Enter number a: $'
    tb2 db 'Enter number b: $'
    tb3 db 'Enter number c: $'
    tb4 db 'No real solutions.$'
    tb5 db 'One real solution: $'
    tb6 db 'Two real solutions: $'
    result db 'Result: $'
    a dd 0.0
    b dd 0.0
    c dd 0.0
    delta dd 0.0
    sqrtDelta dd 0.0
    x1 dd 0.0
    x2 dd 0.0
    x dd 0.0
    statusWord dw 0 ; Khai báo statusWord

.code
    ; Hàm nhập số thực từ bàn phím
    ; Tham số:
    ;   - msg: Con trỏ đến chuỗi thông báo
    ; Trả về:
    ;   - Giá trị số thực được nhập
    inputFloat proc
        push ax bx
        mov ah, 09h
        mov dx,  offset tb1
        int 21h

        ; Nhập chuỗi ký tự
        mov ah, 0Ah
        lea dx, [a]
        int 21h

        ; Chuyển chuỗi ký tự thành số thực
        lea si, [a+2]  ; Bỏ qua ký tự độ dài của chuỗi
        mov al, [si]
        mov ah, 0
        sub al, 30h    ; Chuyển ký tự đầu tiên thành giá trị số
        xor bx, bx
        mov bl, [si+1] ; Lấy phần thập phân
        sub bl, 30h    ; Chuyển ký tự phần thập phân thành giá trị số
        mov byte ptr [a], al
        mov byte ptr [a+1], bl

        pop bx ax
        ret
    inputFloat endp

    ; Hàm tính căn bậc hai của một số thực
    ; Tham số:
    ;   - x: Số thực cần tính căn bậc hai
    ; Trả về:
    ;   - Kết quả căn bậc hai
    sqrtFloat proc
        push ax bx
        fld dword ptr [x]
        fsqrt
        fstp dword ptr [sqrtDelta]
        pop bx ax
        ret
    sqrtFloat endp

    ; Hàm hiển thị số thực
    ; Tham số:
    ;   - msg: Con trỏ đến chuỗi thông báo
    ;   - x: Giá trị số thực cần hiển thị
    displayFloat proc
        push ax bx
        mov ah, 09h
        mov dx, offset result
        int 21h

        ; Chuyển giá trị số thực thành chuỗi ký tự
        lea di, [result+8]
        lea si, [x]
        mov al, byte ptr [si]
        mov ah, 0
        add al, 30h    ; Chuyển giá trị số thành ký tự
        stosb
        mov al, byte ptr [si+1]
        mov ah, 0
        add al, 30h
        stosb

        pop bx ax
        ret
    displayFloat endp

    ; Hàm chính
    main proc
        ; ...

        ; Tính delta
        fld dword ptr [b]
        fmul dword ptr [b]
        fld dword ptr [a]
        fmul dword ptr [c]
        fmul dword ptr [c]
        fsubp st(1), st
        fstp dword ptr [delta]

        ; Kiểm tra delta
        fldz
        fcomp dword ptr [delta]
        fstsw ax ; Lưu trữ trạng thái FPU stack vào AX
        mov bx, ax ; Sao chép giá trị từ AX vào BX

        mov word ptr [statusWord], bx ; Sao chép giá trị từ BX vào statusWord
        sahf
        jle negativeDelta

    ; Negative delta (no real solutions)
    negativeDelta:
        mov ah, 09h
        mov dx, offset tb4
        int 21h
        jmp endProgram

    ; Positive delta (two real solutions)
    positiveDelta:
        ; Tính căn bậc hai của delta
        fld dword ptr [delta]
        call sqrtFloat
        fstp dword ptr [sqrtDelta]

        ; Tính nghiệm x1
        fld dword ptr [b]
        fchs
        fadd dword ptr [sqrtDelta]
        fld dword ptr [a]
        fmul dword ptr [a]
        fmul dword ptr [c]
        fmul dword ptr [c]
        fdiv dword ptr [a]
        faddp st(1), st
        fdiv dword ptr [a]
        fstp dword ptr [x1]

        ; Tính nghiệm x2
        fld dword ptr [b]
        fchs
        fsub dword ptr [sqrtDelta]
        fld dword ptr [a]
        fmul dword ptr [a]
        fmul dword ptr [c]
        fmul dword ptr [c]
        fdiv dword ptr [a]
        faddp st(1), st
        fdiv dword ptr [a]
        fstp dword ptr [x2]

        ; Hiển thị kết quả
        mov ah, 09h
        mov dx, offset tb6
        int 21h
        call displayFloat
        fld dword ptr [x1]
        call displayFloat
        call displayFloat
        fld dword ptr [x2]
        call displayFloat

        jmp endProgram

    ; Zero delta (one real solution)
    zeroDelta:
        ; Tính nghiệm x
        fld dword ptr [b]
        fchs
        fld dword ptr [a]
        fmul dword ptr [c]
        fmul dword ptr [c]
        fdiv dword ptr [a]
        faddp st(1), st
        fdiv dword ptr [a]
        fstp dword ptr [x1]

        ; Hiển thị kết quả
        mov ah, 09h
        mov dx, offset tb5
        int 21h
        call displayFloat
        fld dword ptr [x1]
        call displayFloat

        jmp endProgram

    endProgram:
        mov ah, 4Ch
        int 21h
    main endp

end main
