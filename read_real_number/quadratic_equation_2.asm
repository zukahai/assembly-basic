.model tiny
.stack 100h
.data
    tb1 db 'Nhập vào số thực a: $'
    tb2 db 'Số là: $'
    a dd 0.0
    
.code
    main proc
        mov ah, 9       ; Hiển thị thông báo nhập
        mov dx, offset tb1
        int 21h
        
        mov ah, 0Ah     ; Đọc đầu vào dưới dạng chuỗi
        mov dx, offset a
        int 21h
        
        mov ah, 9       ; Hiển thị thông báo kết quả
        mov dx, offset tb2
        int 21h
        
        mov ah, 0Ah     ; Hiển thị số thực đã nhập
        mov dx, offset a + 2   ; Bỏ qua byte độ dài của bộ đệm đầu vào
        int 21h
        
        mov ah, 4Ch     ; Kết thúc chương trình
        mov al, 0
        int 21h
    main endp
    
end main
