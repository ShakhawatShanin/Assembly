include emu8086.inc
.model small
.stack 100h
.data  
.code

main proc
   mov al,49    ; 49 means 1
   
   mov bh,1
   outer:
       cmp bh,5 
       je outer_exit      
             
       mov bl,0
       inner: 
           cmp bl,bh 
           je inner_exit
          
           cmp al,59     ; 58 means 11
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
       mov al,49 
       jmp inner
   
   outer_exit:
       print
    
main endp
end