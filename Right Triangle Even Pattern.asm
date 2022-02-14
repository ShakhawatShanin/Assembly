include emu8086.inc
.model small
.stack 100h
.data  
.code

main proc
   mov al,48    ; 48 means 0
   
   mov bh,1
   outer:
       cmp bh,5 
       je outer_exit      
             
       mov bl,0
       inner: 
           cmp bl,bh 
           je inner_exit
          
           cmp al,58     ; 58 means 10
           je change 
          
           mov dl,al
           mov ah,2
           int 21h
           print " "
     
           add al,2
           inc bl           
      loop inner
           inner_exit:
           printn
         
      inc bh
   loop outer 
   
   change:      
       mov al,48 
       jmp inner
   
   outer_exit:
       print
    
main endp
end