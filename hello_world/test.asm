title   Hello World Program (hello.asm)
; This program displays "Hello, Hai!"

dosseg
.model small
.stack 100h

.data
hello_message db 'Hello, Hai!',0dh,0ah,'$' ; Khai báo biến hello_message chứa chuỗi "Hello, Hai!" và kết thúc bằng dấu null

.code
main  proc
      mov    ax,@data ; Di chuyển địa chỉ của khối dữ liệu đến thanh ghi ax
      mov    ds,ax ; Gán giá trị trong thanh ghi ax (địa chỉ khối dữ liệu) cho thanh ghi ds

      mov    ah,9 ; Gán giá trị 9 vào thanh ghi ah để hiển thị chuỗi
      mov    dx,offset hello_message ; Gán địa chỉ của chuỗi hello_message cho thanh ghi dx
      int    21h ; Gọi hàm hệ thống DOS để hiển thị chuỗi

      mov    ax,4C00h ; Gán giá trị 4C00h vào thanh ghi ax để kết thúc chương trình
      int    21h ; Gọi hàm hệ thống DOS để kết thúc chương trình
main  endp
end   main