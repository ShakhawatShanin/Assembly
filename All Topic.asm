include emu8086.inc
.model small
.stack 100h
.data  
   a db 10 dup(?) 
   choice db 0  
   sum db 0
   rem db 0   
   time dw 0
.code 
summation proc  
   printn " " 
   print "Sum is: "
   mov al,sum      ; al = 28
   mov ah,0
   mov bl,10       ; bl = 10 
   div bl          ; al = al / bl [Quotient=al, Remainder=ah]
   mov rem,ah      ; 28/10 = 2 (al), 8 (ah)    
      
   mov dl,al      
   add dl,48
   mov ah,2
   int 21h 
      
   mov dl,rem  
   add dl,48
   mov ah,2
   int 21h
    
   ret
summation endp   

main proc
   mov ax,@data
   mov ds,ax  
   
   ;---------------TAKE ARRAY SIZE-----------------
   print "Enter arry size (0-9): "  
   mov ah,1  
   int 21h     
   sub al,48    ; ascii to decimal
   mov ah,0 
   mov time,ax  ; ax = ah + al = 0 + 8
   printn
   
   ;---------------TAKE INPUT-----------------
   print "Enter number: " 
   mov cx,time      ; cx = 7    
   mov bx,0         
   val_store:
      mov ah,1
      int 21h
      sub al,48
      
      mov a[bx],al  ; a[0] = 1
      push ax       ; for reverse
      add sum,al    ; sum = sum + al 
      
      inc bx        ; i++
      print " "
   loop val_store
   
   ;---------------REVERSE PRINT----------------- 
   printn
   print "After reverse: "
   mov cx,time
   rev:    
      pop dx 
      add dl,48     ; decimal to ascii
      mov ah,2
      int 21h 
      print " "
   loop rev 
   ;---------------SUM PRINT-----------------
   call summation

   ;---------------EVEN/ODD PRINT-----------------
    printn " "   
    printn "----------------------------"
    printn "1. ODD PRINT"
    printn "2. EVEN PRINT"  
    printn "----------------------------"  
    
    print "Chose Operation: "
    mov ah,1    
    int 21h      
    sub al,48   
    mov choice,al
   
    printn " "    
    
    mov cx,0   ; cx = counting register   
    lea si,a   ; si (source index register) = index register 
    cmp choice,1
    je odd

    even: 
       cmp cx,time
       je exit
       
       mov ax,0
       mov al,[si]     ; al = [0] = 7
       mov bl,2
       div bl
       
       cmp ah,0
       je even_print  
        
       inc cx
       inc si
       jmp even
       even_print:
          mov dl,[si] 
          add dl,48
          mov ah,2
          int 21h 
          
          print " "
          inc cx 
          inc si
          jmp even
       
    jmp exit
       
    odd: 
       cmp cx,time
       je exit
       
       mov ax,0
       mov al,[si]     ; al = [0] = 7
       mov bl,2
       div bl
       
       cmp ah,0
       jne odd_print  
           
       inc cx
       inc si
       jmp odd
       odd_print:
          mov dl,[si] 
          add dl,48
          mov ah,2
          int 21h 
          
          print " "
          inc cx 
          inc si
          jmp odd

    exit:
       printn        
      
main endp
end main