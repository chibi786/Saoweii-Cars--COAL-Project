org 0x0100
; members ali asjad  , Ibrahim
; 24l-0528 ,  24l-0953

jmp start

ScrollRoadStripes:
    push ax
    push bx
    push cx
    push di
    push es
    mov ax,0A000h
    mov es,ax
    mov di,0
    mov cx,64000

ScrollLoop:
    cmp cx,0
    je ScrollDone
    mov al,[es:di]
    cmp al,15
    jne NotWhite
    cmp di,640
    jb WrapToBottomFast
    mov byte [es:di-640],15
    mov byte [es:di],8
    jmp ContinueLoop

WrapToBottomFast:
    mov bx,di
    add bx,320*198
    mov byte [es:bx],15
    mov byte [es:di],8
    jmp ContinueLoop

NotWhite:
ContinueLoop:
    inc di
    dec cx
    jmp ScrollLoop

ScrollDone:
    pop es
    pop di
    pop cx
    pop bx
    pop ax
    ret

InitialSetup:
    mov ax, 0x13
    int 0x10
    mov ax, 0xA000
    mov es, ax
    call LeftSideBorder
    call RightSideBorder
    call Road
    call LoadCar
    ret

Road:
    mov cx,200
    mov di,80
loop1D:
    cmp cx,0
    je exit3
    push di
    mov ax,200
    sub ax,cx
    mov bl,14
    div bl
    test al,1
    jz noDash
    mov bh,1
    jmp dashSet
noDash:
    mov bh,0
dashSet:
    mov dx,160
loop2D:
    cmp dx,0
    je done3
    mov ax,160
    sub ax,dx
    test bh,1
    jz roadColor
    cmp ax,38
    jb roadColor
    cmp ax,42
    jbe whiteStripe
    cmp ax,78
    jb roadColor
    cmp ax,82
    jbe whiteStripe
    cmp ax,118
    jb roadColor
    cmp ax,122
    jbe whiteStripe
    jmp roadColor
whiteStripe:
    mov byte [es:di],15
    jmp afterD
roadColor:
    mov byte [es:di],8
afterD:
    inc di
    dec dx
    jmp loop2D
done3:
    dec cx
    pop di
    add di,320
    jmp loop1D
exit3:
    ret

LeftSideBorder:
    mov cx , 200
    mov di , 0
loop1:
    cmp cx, 0
    je exit1
    push di
    mov dx , 80
loop2:
    cmp dx, 0
    je done1
    mov ax,200
    sub ax,cx
    mov bl,5
    div bl
    test al,1
    jz lightL
    mov byte [es:di],2
    jmp afterL
lightL:
    mov byte [es:di],10
afterL:
    inc di
    dec dx
    jmp loop2
done1:
    dec cx
    pop di
    add di , 320
    jmp loop1
exit1:
    ret

RightSideBorder:
    mov cx , 200
    mov di , 240
loop1R:
    cmp cx, 0
    je exit2
    push di
    mov dx , 80
loop2R:
    cmp dx, 0
    je done2
    mov ax,200
    sub ax,cx
    mov bl,5
    div bl
    test al,1
    jz lightR
    mov byte [es:di],2
    jmp afterR
lightR:
    mov byte [es:di],10
afterR:
    inc di
    dec dx
    jmp loop2R
done2:
    dec cx
    pop di
    add di , 320
    jmp loop1R
exit2:
    ret

CarModel:
db 255,0,0,0,0,0,0,0,0,0,0,255
db 0,8,8,8,8,8,8,8,8,8,8,0
db 0,8,4,4,4,4,4,4,4,4,8,0
db 0,8,4,7,7,7,7,7,7,4,8,0
db 0,8,4,7,4,4,4,4,7,4,8,0
db 0,8,4,4,4,4,4,4,4,4,8,0
db 0,8,4,4,4,4,4,4,4,4,8,0
db 0,8,4,4,4,4,4,4,4,4,8,0
db 0,8,4,4,4,4,4,4,4,4,8,0
db 0,8,4,4,4,4,4,4,4,4,8,0
db 0,8,4,4,4,4,4,4,4,4,8,0
db 0,8,8,8,8,8,8,8,8,8,8,0
db 255,0,0,0,0,0,0,0,0,0,0,255
db 255,255,0,0,0,255,255,0,0,0,255,255

CarModelObstacle:
db 255,14,14,14,14,14,14,14,14,14,14,255
times 15*12-24 db 1

CoinModel:
times 64 db 14

FuelModel:
times 64 db 12

LoadCar:
    mov bx,CarModel
    mov cx,15
    mov di,100
    mov ax,320
    mov dx,182
    mul dx
    add di,ax
carRow:
    cmp cx,0
    je carDone
    push di
    mov dx,12
carCol:
    cmp dx,0
    je nextCarRow
    mov al,[bx]
    cmp al,255
    je skip
    mov [es:di],al
skip:
    inc bx
    inc di
    dec dx
    jmp carCol
nextCarRow:
    pop di
    add di,320
    dec cx
    jmp carRow
carDone:
    ret

DrawEnemy:
    push ax
    push bx
    push cx
    push dx
    push di
    mov bx,CarModelObstacle
    mov cx,15
drawE_row:
    cmp cx,0
    je drawE_done
    push di
    mov dx,12
drawE_col:
    cmp dx,0
    je drawE_next
    mov al,[bx]
    cmp al,255
    je drawE_skip
    mov [es:di],al
drawE_skip:
    inc bx
    inc di
    dec dx
    jmp drawE_col
drawE_next:
    pop di
    add di,320
    dec cx
    jmp drawE_row
drawE_done:
    pop di
    pop dx
    pop cx
    pop bx
    pop ax
    ret

DrawCoin:
    push ax
    push bx
    push cx
    push dx
    push di
    mov bx,CoinModel
    mov cx,8
drawCoin_row:
    cmp cx,0
    je drawCoin_done
    push di
    mov dx,8
drawCoin_col:
    cmp dx,0
    je drawCoin_next
    mov al,[bx]
    cmp al,255
    je drawCoin_skip
    mov [es:di],al
drawCoin_skip:
    inc bx
    inc di
    dec dx
    jmp drawCoin_col
drawCoin_next:
    pop di
    add di,320
    dec cx
    jmp drawCoin_row
drawCoin_done:
    pop di
    pop dx
    pop cx
    pop bx
    pop ax
    ret

DrawFuel:
    push ax
    push bx
    push cx
    push dx
    push di
    mov bx,FuelModel
    mov cx,8
drawFuel_row:
    cmp cx,0
    je drawFuel_done
    push di
    mov dx,8
drawFuel_col:
    cmp dx,0
    je drawFuel_next
    mov al,[bx]
    cmp al,255
    je drawFuel_skip
    mov [es:di],al
drawFuel_skip:
    inc bx
    inc di
    dec dx
    jmp drawFuel_col
drawFuel_next:
    pop di
    add di,320
    dec cx
    jmp drawFuel_row
drawFuel_done:
    pop di
    pop dx
    pop cx
    pop bx
    pop ax
    ret

spawnTimer db 0
spawnCoinTimer db 50
spawnFuelTimer db 100

SpawnEnemyTicker:
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    push es
    mov ax,0A000h
    mov es,ax
    mov al,[spawnTimer]
    cmp al,0
    jne spawn_wait
    mov ah,00h
    int 1Ah
    mov ax,dx
    and ax,0003h
    cmp ax,0
    je lane1
    cmp ax,1
    je lane2
    cmp ax,2
    je lane3
    cmp ax,3
    je lane4
lane1:
    mov si,100
    jmp do_spawn
lane2:
    mov si,140
    jmp do_spawn
lane3:
    mov si,180
    jmp do_spawn
lane4:
    mov si,220
do_spawn:
    mov ax,si
    mov di,ax
    mov al,18
    mov ah,0
    mov bx,320
    mul bx
    add di,ax
    call DrawEnemy
    mov byte [spawnTimer],70
    jmp spawn_done
spawn_wait:
    dec byte [spawnTimer]
spawn_done:
    pop es
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret

SpawnCoinTicker:
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    push es
    mov ax,0A000h
    mov es,ax
    mov al,[spawnCoinTimer]
    cmp al,0
    jne coin_wait
    mov ah,00h
    int 1Ah
    mov ax,dx
    and ax,0003h
    cmp ax,0
    je coin_lane1
    cmp ax,1
    je coin_lane2
    cmp ax,2
    je coin_lane3
    cmp ax,3
    je coin_lane4
coin_lane1:
    mov si,100
    jmp coin_do_spawn
coin_lane2:
    mov si,140
    jmp coin_do_spawn
coin_lane3:
    mov si,180
    jmp coin_do_spawn
coin_lane4:
    mov si,220
coin_do_spawn:
    mov ax,si
    mov di,ax
    mov al,8
    mov ah,0
    mov bx,320
    mul bx
    add di,ax
    call DrawCoin
    mov byte [spawnCoinTimer],200
    jmp coin_done
coin_wait:
    dec byte [spawnCoinTimer]
coin_done:
    pop es
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret

SpawnFuelTicker:
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    push es
    mov ax,0A000h
    mov es,ax
    mov al,[spawnFuelTimer]
    cmp al,0
    jne fuel_wait
    mov ah,00h
    int 1Ah
    mov ax,dx
    and ax,0003h
    cmp ax,0
    je fuel_lane1
    cmp ax,1
    je fuel_lane2
    cmp ax,2
    je fuel_lane3
    cmp ax,3
    je fuel_lane4
fuel_lane1:
    mov si,100
    jmp fuel_do_spawn
fuel_lane2:
    mov si,140
    jmp fuel_do_spawn
fuel_lane3:
    mov si,180
    jmp fuel_do_spawn
fuel_lane4:
    mov si,220
fuel_do_spawn:
    mov ax,si
    mov di,ax
    mov al,8
    mov ah,0
    mov bx,320
    mul bx
    add di,ax
    call DrawFuel
    mov word [spawnFuelTimer],300
    jmp fuel_done
fuel_wait:
    dec byte [spawnFuelTimer]
fuel_done:
    pop es
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret

ScrollEnemiesDown:
    push ax
    push bx
    push cx
    push dx
    push di
    push es

    mov ax,0A000h
    mov es,ax

    ; Scroll bottom-up to prevent overwriting
    mov di,320*199+0
    mov cx,320*199

SED_loop:
    cmp cx,0
    je SED_done
    mov al,[es:di]
    cmp al,1
    je SED_move
    cmp al,14
    je SED_move
    cmp al,12
    jne SED_next
SED_move:
    mov [es:di+320],al
    mov byte [es:di],8   
SED_next:
    dec di
    dec cx
    jmp SED_loop

SED_done:
    pop es
    pop di
    pop dx
    pop cx
    pop bx
    pop ax
    ret

start:
    call InitialSetup
MainLoop:
    call ScrollRoadStripes
    call SpawnEnemyTicker
    call SpawnCoinTicker
    call SpawnFuelTicker
    call ScrollEnemiesDown

    mov cx,20000
delay_loop:
    dec cx
    jnz delay_loop
    jmp MainLoop

    