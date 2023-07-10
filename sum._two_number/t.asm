.model tiny
.stack 100h
.data
    tb1 db 'Nhap so thu nhat : $'
    tb2 db 13,10,'Nhap so thu hai : $'
    tb3 db 13,10,'Tong hai so la : $'
    so1 db 0
    so2 db 0
.code
    main proc
        mov ax,@data
        mov ds,ax
       
        lea dx,tb1
        mov ah,9
        int 21h
        nhapso1:
            mov ah,1
            int 21h
            cmp al,13
            je hientb2
            sub al,30h
            mov cl,al
            mov al,so1
            mov bl,10
            mul bl
            add al,cl
            mov so1,al
            jmp nhapso1
           
        hientb2:
            lea dx,tb2
            mov ah,9
            int 21h
        nhapso2:
            mov ah,1
            int 21h
            cmp al,13
            je hientb3
            sub al,30h
            mov cl,al
            mov al,so2
            mov bl,10
            mul bl
            add al,cl
            mov so2,al
            jmp nhapso2
        hientb3:
            lea dx,tb3
            mov ah,9
            int 21h
        ;==TONG 2 SO BYTE==
        mov al,so1
        add al,so2
        mov ah,0
        mov cx,0
        mov bl,10
        ;chia de tach so
        chia:
            div bl
            push ax
            inc cx
            cmp al,0
            je hien
            mov ah,0
            jmp chia
        hien:
            pop ax
            mov dl,ah
            add dl,30h
            mov ah,2
            int 21h
            loop hien
        ;thoat chuong trinh           
        thoat:       
        mov ah,76
        int 21h
        main endp
    end main