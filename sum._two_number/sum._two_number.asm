title   Tính tổng 2 số (add.asm)
; Chương trình tính tổng của hai số

dosseg
.model small
.stack 100h

.data
num1 db 60 ; Số thứ nhất
num2 db 5 ; Số thứ hai

.code
main  proc
      mov    ax, @data ; Di chuyển địa chỉ của khối dữ liệu đến thanh ghi ax
      mov    ds, ax ; Gán giá trị trong thanh ghi ax (địa chỉ khối dữ liệu) cho thanh ghi ds

      mov    al, num1 ; Gán giá trị của số thứ nhất vào thanh ghi al
      add    al, num2 ; Thực hiện phép cộng giữa số thứ nhất và số thứ hai, kết quả được lưu trong thanh ghi al

      ; Hiển thị kết quả
      mov    ah, 2 ; Gán giá trị 2 vào thanh ghi ah để hiển thị ký tự
      mov    dl, al ; Gán giá trị trong thanh ghi al vào thanh ghi dl
      int    21h ; Gọi hàm hệ thống DOS để hiển thị ký tự trong thanh ghi dl

      mov    ah, 4Ch ; Gán giá trị 4Ch vào thanh ghi ah để kết thúc chương trình
      int    21h ; Gọi hàm hệ thống DOS để kết thúc chương trình
main  endp
end   main
