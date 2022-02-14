include emu8086.inc
.model small
.data 
    num1 db 0
    num2 db 0  
    choice db 0
    rem db ?  
.code 
main proc
    mov ax,@data
    mov ds,ax
    
    print "Enter first number (0-9): "
    mov ah,1      ; input as ascii
    int 21h     
    sub al,48     ; ascii to decimal
    mov num1,al  
    
    printn " "
    
    print "Enter second number (0-9): "
    mov ah,1    
    int 21h      
    sub al,48   
    mov num2,al       
        
    printn " "   
    printn "----------------------------"
    printn "1. ADDITION"
    printn "2. SUBTRACTION"
    printn "3. MULTIPLICATION" 
    printn "4. DIVISION"   
    printn "----------------------------"  
    
    print "Chose Operation: "
    mov ah,1    
    int 21h      
    sub al,48   
    mov choice,al
   
    printn " "    
    
    cmp choice,2
    jl addition
    jg multiplication
    
    subtraction: 
      mov al,num1
      sub al,num2  
      add al,48
      
      print "Subtraction is: "  
  
      mov dl,al      
      mov ah,2
      int 21h
      
      jmp exit
       
    addition: 
      mov al,num1
      add al,num2   ; al=7+5=12
      
      print "Addition is: "  
  
      mov ah,0
      mov bl,10   ; 12/10 , al=1, ah=2
      div bl
      mov rem,ah
      
      mov dl,al  
      add dl,48
      mov ah,2
      int 21h 
      
      mov dl,rem  
      add dl,48
      mov ah,2
      int 21h
      
      jmp exit
    
    multiplication: 
      cmp choice,4 
      je division    
      
      mov al,num1
      mul num2       
      
      print "Multiplication is: "  
  
      mov ah,0
      mov bl,10
      div bl         ; al = al / bl [Quotient=al, Remainder=ah] 
      mov rem,ah     ; 35/10 = 3 (al), 5 (ah)
      
      mov dl,al      
      add dl,48
      mov ah,2
      int 21h 
      
      mov dl,rem  
      add dl,48
      mov ah,2
      int 21h
      
      jmp exit
      
    division:
      mov ah,0   
      mov al,num1
      div num2       
      add al,48
      
      print "Division is: "  
      
      mov dl,al      
      mov ah,2
      int 21h 
      
    
exit:
endp
end main