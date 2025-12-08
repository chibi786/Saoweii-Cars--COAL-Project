org 0x0100

jmp start

; ============ GAME STATE ============
gameState    db 0    ; 0 = start screen, 1 = playing

; ============ PLAYER DATA ============
playerX      dw 154
playerY      dw 170

; ============ ENEMY ARRAYS (5 enemies max) ============
MAX_ENEMIES  equ 5
enemyX       dw 0,0,0,0,0
enemyY       dw 0,0,0,0,0
enemyActive  db 0,0,0,0,0

; ============ COIN ARRAYS (3 coins max) ============
MAX_COINS    equ 3
coinX        dw 0,0,0
coinY        dw 0,0,0
coinActive   db 0,0,0

; ============ FUEL ARRAYS (2 fuel max) ============
MAX_FUEL     equ 2
fuelX        dw 0,0
fuelY        dw 0,0
fuelActive   db 0,0

; ============ TIMERS ============
spawnTimer     db 0
spawnCoinTimer db 0
spawnFuelTimer db 0

; ============ SCROLLING ============
stripeOffset   db 0
frameCounter   db 0

; ============ LANE POSITIONS (on grey road, not stripes) ============
lane1X      equ 94
lane2X      equ 140
lane3X      equ 186

; ============ SPRITES ============

; Large car sprite for start screen (24x28 pixels)
LargeCarSprite:
db 255,255,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255
db 255,0,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,0,255
db 0,8,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,8,0
db 0,8,4,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,4,8,0
db 0,8,4,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,4,8,0
db 0,8,4,7,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,7,4,8,0
db 0,8,4,7,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,7,4,8,0
db 0,8,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,8,0
db 0,8,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,8,0
db 0,8,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,8,0
db 0,8,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,8,0
db 0,8,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,8,0
db 0,8,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,8,0
db 0,8,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,8,0
db 0,8,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,8,0
db 0,8,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,8,0
db 0,8,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,8,0
db 0,8,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,8,0
db 0,8,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,8,0
db 0,8,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,8,0
db 0,8,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,8,0
db 0,8,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,8,0
db 0,8,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,8,0
db 0,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,0
db 255,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255
db 255,255,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255
db 255,255,255,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255
db 255,255,255,255,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255

TreeSprite:
db 2,2,2,2,2,6,6,6,6,2,2,2
db 2,2,2,6,6,10,10,10,10,6,6,2
db 2,2,6,10,10,10,10,10,10,10,6,2
db 2,6,10,10,10,10,10,10,10,10,10,6
db 6,10,10,10,10,10,10,10,10,10,10,6
db 6,10,10,10,10,10,10,10,10,10,10,6
db 6,10,10,10,10,10,10,10,10,10,10,6
db 2,6,10,10,10,10,10,10,10,10,6,2
db 2,2,6,10,10,10,10,10,10,6,2,2
db 2,2,2,6,6,10,10,6,6,2,2,2
db 2,2,2,2,2,6,6,2,2,2,2,2
db 2,2,2,2,2,6,6,2,2,2,2,2
db 2,2,2,2,2,6,6,2,2,2,2,2
db 2,2,2,2,2,6,6,2,2,2,2,2
db 2,2,2,2,2,6,6,2,2,2,2,2
db 2,2,2,2,2,6,6,2,2,2,2,2
db 2,2,2,2,6,6,6,6,2,2,2,2
db 2,2,2,2,6,6,6,6,2,2,2,2

FlowerSpriteOrange:
db 12,12,12,12,12,12,12
db 12,12,12,12,12,12,12
db 12,12,12,12,12,12,12
db 12,12,12,12,12,12,12
db 12,12,12,12,12,12,12
db 2,12,12,12,12,12,2
db 2,2,10,10,10,2,2

RockSprite:
db 8,7,7,7,8,2
db 7,8,8,8,7,8
db 8,7,7,7,8,7
db 2,8,8,8,7,2

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
db 0,8,4,4,4,4,4,4,4,4,8,0
db 0,8,8,8,8,8,8,8,8,8,8,0
db 255,0,0,0,0,0,0,0,0,0,0,255

CarModelObstacle:
db 255,14,14,14,14,14,14,14,14,14,14,255
db 14,1,1,1,1,1,1,1,1,1,1,14
db 14,1,1,1,1,1,1,1,1,1,1,14
db 14,1,1,1,1,1,1,1,1,1,1,14
db 14,1,1,1,1,1,1,1,1,1,1,14
db 14,1,1,1,1,1,1,1,1,1,1,14
db 14,1,1,1,1,1,1,1,1,1,1,14
db 14,1,1,1,1,1,1,1,1,1,1,14
db 14,1,1,1,1,1,1,1,1,1,1,14
db 14,1,1,1,1,1,1,1,1,1,1,14
db 14,1,1,1,1,1,1,1,1,1,1,14
db 14,1,1,1,1,1,1,1,1,1,1,14
db 255,14,14,14,14,14,14,14,14,14,14,255
db 255,255,14,14,14,14,14,14,14,14,255,255

CoinModel:
    times 25 db 14

FuelModel:
    times 100 db 12

; ============ TEXT STRINGS ============
titleText       db 'SAOWEII CARS', 0
promptText      db 'Press any key to start', 0
instructText1   db 'Left key: Move Left', 0
instructText2   db 'Right key: Move Right', 0
instructText3   db 'Up and down key for up and down', 0
creditsText     db 'Ali Asjad 24L-0528 and Chaudhry Ibrahim 24L-0953', 0

; ============ START SCREEN ============

DrawStartScreen:
    push ax
    push bx
    push cx
    push dx
    push di
    
    ; Fill screen with light blue (color 9)
    xor di, di
    mov cx, 64000       ; 320 * 200 pixels
    mov al, 9           ; Light blue color
    
dssLoop:
    mov [es:di], al
    inc di
    loop dssLoop
    
    ; Draw title "SAOWEII CARS" at top (Y=20, centered)
    mov di, 320 * 20 + 104  ; Center position for 12 chars (12*6=72, 320/2-72/2=124)
    mov bx, titleText
    mov al, 15          ; White color
    call DrawText
    
    ; Draw large car sprite (centered at Y=60)
    mov di, 320 * 60 + 148  ; Center position (320/2 - 24/2 = 148)
    call DrawLargeCar
    
    ; Draw "Press any key to start" (Y=120, centered)
    mov di, 320 * 120 + 77  ; Center for 22 chars (22*6=132, 320/2-132/2=94)
    mov bx, promptText
    mov al, 0           ; Black color
    call DrawText
    
    ; Draw instruction text "Left key: Move Left" (Y=145)
    mov di, 320 * 145 + 82
    mov bx, instructText1
    mov al, 4           ; Red color
    call DrawText
    
    ; Draw instruction text "Right key: Move Right" (Y=155)
    mov di, 320 * 155 + 76
    mov bx, instructText2
    mov al, 4           ; Red color
    call DrawText
    
    ; Draw instruction text "Up and down key for up and down" (Y=170)
    mov di, 320 * 170 + 50
    mov bx, instructText3
    mov al, 4           ; Red color
    call DrawText
    
    ; Draw credits at bottom (Y=185)
    mov di, 320 * 185 + 15  ; Starting from left side for long text
    mov bx, creditsText
    mov al, 0           ; Black color
    call DrawText
    
    pop di
    pop dx
    pop cx
    pop bx
    pop ax
    ret

; Draw large car sprite at DI offset
DrawLargeCar:
    push ax
    push bx
    push cx
    push dx
    push di
    
    mov bx, LargeCarSprite
    mov cx, 28          ; 28 rows
    
dlcRow:
    cmp cx, 0
    je dlcExit
    push di
    mov dx, 24          ; 24 columns
    
dlcCol:
    cmp dx, 0
    je dlcDone
    mov al, [bx]
    cmp al, 255         ; Skip transparent pixels
    je dlcSkip
    mov [es:di], al
    
dlcSkip:
    inc bx
    inc di
    dec dx
    jmp dlcCol
    
dlcDone:
    pop di
    add di, 320
    dec cx
    jmp dlcRow
    
dlcExit:
    pop di
    pop dx
    pop cx
    pop bx
    pop ax
    ret

; Draw text string at DI offset, BX = string pointer, AL = color
DrawText:
    push ax
    push bx
    push cx
    push dx
    push di
    push si
    
    mov si, bx          ; SI points to string
    mov bl, al          ; Save color in BL
    
dtLoop:
    mov al, [si]        ; Get character
    cmp al, 0           ; Check for null terminator
    je dtExit
    
    ; Save registers before DrawChar
    push si
    push di
    push bx
    
    ; Draw character (simple 5x7 font simulation using pixels)
    call DrawChar
    
    ; Restore registers
    pop bx
    pop di
    pop si
    
    add di, 6           ; Move to next character position (5 + 1 spacing)
    inc si              ; Next character in string
    jmp dtLoop
    
dtExit:
    pop si
    pop di
    pop dx
    pop cx
    pop bx
    pop ax
    ret

; Draw a single character at DI, AL = ASCII char, BL = color
DrawChar:
    push ax
    push cx
    push dx
    push di
    
    ; Simple block font for uppercase letters and space
    cmp al, 'A'
    jne dcNotA
    jmp dcA
dcNotA:
    cmp al, 'B'
    jne dcNotB
    jmp dcB
dcNotB:
    cmp al, 'C'
    jne dcNotC
    jmp dcC
dcNotC:
    cmp al, 'D'
    jne dcNotD
    jmp dcD
dcNotD:
    cmp al, 'E'
    jne dcNotE
    jmp dcE
dcNotE:
    cmp al, 'I'
    jne dcNotI
    jmp dcI
dcNotI:
    cmp al, 'K'
    jne dcNotK
    jmp dcK
dcNotK:
    cmp al, 'N'
    jne dcNotN
    jmp dcN
dcNotN:
    cmp al, 'O'
    jne dcNotO
    jmp dcO
dcNotO:
    cmp al, 'P'
    jne dcNotP
    jmp dcP
dcNotP:
    cmp al, 'R'
    jne dcNotR
    jmp dcR
dcNotR:
    cmp al, 'S'
    jne dcNotS
    jmp dcS
dcNotS:
    cmp al, 'T'
    jne dcNotT
    jmp dcT
dcNotT:
    cmp al, 'W'
    jne dcNotW
    jmp dcW
dcNotW:
    cmp al, 'L'
    jne dcNotL
    jmp dcL
dcNotL:
    cmp al, 'M'
    jne dcNotM
    jmp dcM
dcNotM:
    cmp al, 'U'
    jne dcNotU
    jmp dcU
dcNotU:
    cmp al, 'a'
    jne dcNotLowerA
    jmp dcLowerA
dcNotLowerA:
    cmp al, 'e'
    jne dcNotLowerE
    jmp dcLowerE
dcNotLowerE:
    cmp al, 'i'
    jne dcNotLowerI
    jmp dcLowerI
dcNotLowerI:
    cmp al, 'k'
    jne dcNotLowerK
    jmp dcLowerK
dcNotLowerK:
    cmp al, 'n'
    jne dcNotLowerN
    jmp dcLowerN
dcNotLowerN:
    cmp al, 'o'
    jne dcNotLowerO
    jmp dcLowerO
dcNotLowerO:
    cmp al, 'r'
    jne dcNotLowerR
    jmp dcLowerR
dcNotLowerR:
    cmp al, 's'
    jne dcNotLowerS
    jmp dcLowerS
dcNotLowerS:
    cmp al, 't'
    jne dcNotLowerT
    jmp dcLowerT
dcNotLowerT:
    cmp al, 'y'
    jne dcNotLowerY
    jmp dcLowerY
dcNotLowerY:
    cmp al, 'v'
    jne dcNotLowerV
    jmp dcLowerV
dcNotLowerV:
    cmp al, 'h'
    jne dcNotLowerH
    jmp dcLowerH
dcNotLowerH:
    cmp al, 'd'
    jne dcNotLowerD
    jmp dcLowerD
dcNotLowerD:
    cmp al, 'u'
    jne dcNotLowerU
    jmp dcLowerU
dcNotLowerU:
    cmp al, 'f'
    jne dcNotLowerF
    jmp dcLowerF
dcNotLowerF:
    cmp al, 'g'
    jne dcNotLowerG
    jmp dcLowerG
dcNotLowerG:
    cmp al, 'w'
    jne dcNotLowerW
    jmp dcLowerW
dcNotLowerW:
    cmp al, 'l'
    jne dcNotLowerL
    jmp dcLowerL
dcNotLowerL:
    cmp al, 'm'
    jne dcNotLowerM
    jmp dcLowerM
dcNotLowerM:
    cmp al, 'b'
    jne dcNotLowerB
    jmp dcLowerB
dcNotLowerB:
    cmp al, 'j'
    jne dcNotLowerJ
    jmp dcLowerJ
dcNotLowerJ:
    cmp al, 'c'
    jne dcNotLowerC
    jmp dcLowerC
dcNotLowerC:
    cmp al, 'p'
    jne dcNotLowerP
    jmp dcLowerP
dcNotLowerP:
    cmp al, '0'
    jne dcNot0
    jmp dc0
dcNot0:
    cmp al, '1'
    jne dcNot1
    jmp dc1
dcNot1:
    cmp al, '2'
    jne dcNot2
    jmp dc2
dcNot2:
    cmp al, '3'
    jne dcNot3
    jmp dc3
dcNot3:
    cmp al, '4'
    jne dcNot4
    jmp dc4
dcNot4:
    cmp al, '5'
    jne dcNot5
    jmp dc5
dcNot5:
    cmp al, '8'
    jne dcNot8
    jmp dc8
dcNot8:
    cmp al, '9'
    jne dcNot9
    jmp dc9
dcNot9:
    cmp al, '-'
    jne dcNotDash
    jmp dcDash
dcNotDash:
    cmp al, '('
    jne dcNotLParen
    jmp dcLParen
dcNotLParen:
    cmp al, ')'
    jne dcNotRParen
    jmp dcRParen
dcNotRParen:
    cmp al, ':'
    jne dcNotColon
    jmp dcColon
dcNotColon:
    cmp al, ' '
    jne dcNotSpace
    jmp dcSpace
dcNotSpace:
    jmp dcCharDone

; Character patterns (simplified 5x7 pixel fonts)
dcA:
    call DrawPattern5x7
    db 0,1,1,1,0
    db 1,0,0,0,1
    db 1,0,0,0,1
    db 1,1,1,1,1
    db 1,0,0,0,1
    db 1,0,0,0,1
    db 1,0,0,0,1
    jmp dcCharDone
    
dcB:
    call DrawPattern5x7
    db 1,1,1,1,0
    db 1,0,0,0,1
    db 1,0,0,0,1
    db 1,1,1,1,0
    db 1,0,0,0,1
    db 1,0,0,0,1
    db 1,1,1,1,0
    jmp dcCharDone
    
dcC:
    call DrawPattern5x7
    db 0,1,1,1,0
    db 1,0,0,0,1
    db 1,0,0,0,0
    db 1,0,0,0,0
    db 1,0,0,0,0
    db 1,0,0,0,1
    db 0,1,1,1,0
    jmp dcCharDone
    
dcD:
    call DrawPattern5x7
    db 1,1,1,0,0
    db 1,0,0,1,0
    db 1,0,0,0,1
    db 1,0,0,0,1
    db 1,0,0,0,1
    db 1,0,0,1,0
    db 1,1,1,0,0
    jmp dcCharDone
    
dcE:
    call DrawPattern5x7
    db 1,1,1,1,1
    db 1,0,0,0,0
    db 1,0,0,0,0
    db 1,1,1,1,0
    db 1,0,0,0,0
    db 1,0,0,0,0
    db 1,1,1,1,1
    jmp dcCharDone
    
dcI:
    call DrawPattern5x7
    db 1,1,1,1,1
    db 0,0,1,0,0
    db 0,0,1,0,0
    db 0,0,1,0,0
    db 0,0,1,0,0
    db 0,0,1,0,0
    db 1,1,1,1,1
    jmp dcCharDone
    
dcK:
    call DrawPattern5x7
    db 1,0,0,0,1
    db 1,0,0,1,0
    db 1,0,1,0,0
    db 1,1,0,0,0
    db 1,0,1,0,0
    db 1,0,0,1,0
    db 1,0,0,0,1
    jmp dcCharDone
    
dcN:
    call DrawPattern5x7
    db 1,0,0,0,1
    db 1,1,0,0,1
    db 1,0,1,0,1
    db 1,0,0,1,1
    db 1,0,0,0,1
    db 1,0,0,0,1
    db 1,0,0,0,1
    jmp dcCharDone
    
dcO:
    call DrawPattern5x7
    db 0,1,1,1,0
    db 1,0,0,0,1
    db 1,0,0,0,1
    db 1,0,0,0,1
    db 1,0,0,0,1
    db 1,0,0,0,1
    db 0,1,1,1,0
    jmp dcCharDone
    
dcP:
    call DrawPattern5x7
    db 1,1,1,1,0
    db 1,0,0,0,1
    db 1,0,0,0,1
    db 1,1,1,1,0
    db 1,0,0,0,0
    db 1,0,0,0,0
    db 1,0,0,0,0
    jmp dcCharDone
    
dcR:
    call DrawPattern5x7
    db 1,1,1,1,0
    db 1,0,0,0,1
    db 1,0,0,0,1
    db 1,1,1,1,0
    db 1,0,1,0,0
    db 1,0,0,1,0
    db 1,0,0,0,1
    jmp dcCharDone
    
dcS:
    call DrawPattern5x7
    db 0,1,1,1,1
    db 1,0,0,0,0
    db 1,0,0,0,0
    db 0,1,1,1,0
    db 0,0,0,0,1
    db 0,0,0,0,1
    db 1,1,1,1,0
    jmp dcCharDone
    
dcT:
    call DrawPattern5x7
    db 1,1,1,1,1
    db 0,0,1,0,0
    db 0,0,1,0,0
    db 0,0,1,0,0
    db 0,0,1,0,0
    db 0,0,1,0,0
    db 0,0,1,0,0
    jmp dcCharDone
    
dcW:
    call DrawPattern5x7
    db 1,0,0,0,1
    db 1,0,0,0,1
    db 1,0,0,0,1
    db 1,0,1,0,1
    db 1,0,1,0,1
    db 1,1,0,1,1
    db 0,1,0,1,0
    jmp dcCharDone

dcL:
    call DrawPattern5x7
    db 1,0,0,0,0
    db 1,0,0,0,0
    db 1,0,0,0,0
    db 1,0,0,0,0
    db 1,0,0,0,0
    db 1,0,0,0,0
    db 1,1,1,1,1
    jmp dcCharDone

dcM:
    call DrawPattern5x7
    db 1,0,0,0,1
    db 1,1,0,1,1
    db 1,0,1,0,1
    db 1,0,0,0,1
    db 1,0,0,0,1
    db 1,0,0,0,1
    db 1,0,0,0,1
    jmp dcCharDone

dcU:
    call DrawPattern5x7
    db 1,0,0,0,1
    db 1,0,0,0,1
    db 1,0,0,0,1
    db 1,0,0,0,1
    db 1,0,0,0,1
    db 1,0,0,0,1
    db 0,1,1,1,0
    jmp dcCharDone

; Lowercase letters
dcLowerA:
    call DrawPattern5x7
    db 0,0,0,0,0
    db 0,0,0,0,0
    db 0,1,1,1,0
    db 0,0,0,0,1
    db 0,1,1,1,1
    db 1,0,0,0,1
    db 0,1,1,1,1
    jmp dcCharDone
    
dcLowerE:
    call DrawPattern5x7
    db 0,0,0,0,0
    db 0,0,0,0,0
    db 0,1,1,1,0
    db 1,0,0,0,1
    db 1,1,1,1,1
    db 1,0,0,0,0
    db 0,1,1,1,0
    jmp dcCharDone
    
dcLowerI:
    call DrawPattern5x7
    db 0,0,1,0,0
    db 0,0,0,0,0
    db 0,1,1,0,0
    db 0,0,1,0,0
    db 0,0,1,0,0
    db 0,0,1,0,0
    db 0,1,1,1,0
    jmp dcCharDone
    
dcLowerK:
    call DrawPattern5x7
    db 1,0,0,0,0
    db 1,0,0,0,0
    db 1,0,0,1,0
    db 1,0,1,0,0
    db 1,1,0,0,0
    db 1,0,1,0,0
    db 1,0,0,1,0
    jmp dcCharDone
    
dcLowerN:
    call DrawPattern5x7
    db 0,0,0,0,0
    db 0,0,0,0,0
    db 1,0,1,1,0
    db 1,1,0,0,1
    db 1,0,0,0,1
    db 1,0,0,0,1
    db 1,0,0,0,1
    jmp dcCharDone
    
dcLowerO:
    call DrawPattern5x7
    db 0,0,0,0,0
    db 0,0,0,0,0
    db 0,1,1,1,0
    db 1,0,0,0,1
    db 1,0,0,0,1
    db 1,0,0,0,1
    db 0,1,1,1,0
    jmp dcCharDone
    
dcLowerR:
    call DrawPattern5x7
    db 0,0,0,0,0
    db 0,0,0,0,0
    db 1,0,1,1,0
    db 1,1,0,0,1
    db 1,0,0,0,0
    db 1,0,0,0,0
    db 1,0,0,0,0
    jmp dcCharDone
    
dcLowerS:
    call DrawPattern5x7
    db 0,0,0,0,0
    db 0,0,0,0,0
    db 0,1,1,1,0
    db 1,0,0,0,0
    db 0,1,1,1,0
    db 0,0,0,0,1
    db 1,1,1,1,0
    jmp dcCharDone
    
dcLowerT:
    call DrawPattern5x7
    db 0,1,0,0,0
    db 0,1,0,0,0
    db 1,1,1,1,0
    db 0,1,0,0,0
    db 0,1,0,0,0
    db 0,1,0,0,1
    db 0,0,1,1,0
    jmp dcCharDone
    
dcLowerY:
    call DrawPattern5x7
    db 0,0,0,0,0
    db 0,0,0,0,0
    db 1,0,0,0,1
    db 1,0,0,0,1
    db 0,1,1,1,1
    db 0,0,0,0,1
    db 0,1,1,1,0
    jmp dcCharDone

dcLowerV:
    call DrawPattern5x7
    db 0,0,0,0,0
    db 0,0,0,0,0
    db 1,0,0,0,1
    db 1,0,0,0,1
    db 1,0,0,0,1
    db 0,1,0,1,0
    db 0,0,1,0,0
    jmp dcCharDone

dcLowerH:
    call DrawPattern5x7
    db 1,0,0,0,0
    db 1,0,0,0,0
    db 1,0,1,1,0
    db 1,1,0,0,1
    db 1,0,0,0,1
    db 1,0,0,0,1
    db 1,0,0,0,1
    jmp dcCharDone

dcLowerD:
    call DrawPattern5x7
    db 0,0,0,0,1
    db 0,0,0,0,1
    db 0,1,1,0,1
    db 1,0,0,1,1
    db 1,0,0,0,1
    db 1,0,0,0,1
    db 0,1,1,1,1
    jmp dcCharDone

dcLowerU:
    call DrawPattern5x7
    db 0,0,0,0,0
    db 0,0,0,0,0
    db 1,0,0,0,1
    db 1,0,0,0,1
    db 1,0,0,0,1
    db 1,0,0,1,1
    db 0,1,1,0,1
    jmp dcCharDone

dcLowerF:
    call DrawPattern5x7
    db 0,0,1,1,0
    db 0,1,0,0,1
    db 0,1,0,0,0
    db 1,1,1,1,0
    db 0,1,0,0,0
    db 0,1,0,0,0
    db 0,1,0,0,0
    jmp dcCharDone

dcLowerG:
    call DrawPattern5x7
    db 0,0,0,0,0
    db 0,0,0,0,0
    db 0,1,1,1,1
    db 1,0,0,0,1
    db 0,1,1,1,1
    db 0,0,0,0,1
    db 0,1,1,1,0
    jmp dcCharDone

dcLowerW:
    call DrawPattern5x7
    db 0,0,0,0,0
    db 0,0,0,0,0
    db 1,0,0,0,1
    db 1,0,1,0,1
    db 1,0,1,0,1
    db 1,1,0,1,1
    db 0,1,0,1,0
    jmp dcCharDone

dcLowerL:
    call DrawPattern5x7
    db 0,1,1,0,0
    db 0,0,1,0,0
    db 0,0,1,0,0
    db 0,0,1,0,0
    db 0,0,1,0,0
    db 0,0,1,0,1
    db 0,0,0,1,0
    jmp dcCharDone

dcLowerM:
    call DrawPattern5x7
    db 0,0,0,0,0
    db 0,0,0,0,0
    db 1,1,0,1,0
    db 1,0,1,0,1
    db 1,0,1,0,1
    db 1,0,0,0,1
    db 1,0,0,0,1
    jmp dcCharDone

dcLowerB:
    call DrawPattern5x7
    db 1,0,0,0,0
    db 1,0,0,0,0
    db 1,0,1,1,0
    db 1,1,0,0,1
    db 1,0,0,0,1
    db 1,1,0,0,1
    db 1,0,1,1,0
    jmp dcCharDone

dcLowerJ:
    call DrawPattern5x7
    db 0,0,0,1,0
    db 0,0,0,0,0
    db 0,0,1,1,0
    db 0,0,0,1,0
    db 0,0,0,1,0
    db 1,0,0,1,0
    db 0,1,1,0,0
    jmp dcCharDone

dcLowerC:
    call DrawPattern5x7
    db 0,0,0,0,0
    db 0,0,0,0,0
    db 0,1,1,1,0
    db 1,0,0,0,1
    db 1,0,0,0,0
    db 1,0,0,0,1
    db 0,1,1,1,0
    jmp dcCharDone

dcLowerP:
    call DrawPattern5x7
    db 0,0,0,0,0
    db 0,0,0,0,0
    db 1,0,1,1,0
    db 1,1,0,0,1
    db 1,0,0,0,1
    db 1,1,1,1,0
    db 1,0,0,0,0
    jmp dcCharDone

; Digits
dc0:
    call DrawPattern5x7
    db 0,1,1,1,0
    db 1,0,0,0,1
    db 1,0,0,1,1
    db 1,0,1,0,1
    db 1,1,0,0,1
    db 1,0,0,0,1
    db 0,1,1,1,0
    jmp dcCharDone

dc1:
    call DrawPattern5x7
    db 0,0,1,0,0
    db 0,1,1,0,0
    db 0,0,1,0,0
    db 0,0,1,0,0
    db 0,0,1,0,0
    db 0,0,1,0,0
    db 0,1,1,1,0
    jmp dcCharDone

dc2:
    call DrawPattern5x7
    db 0,1,1,1,0
    db 1,0,0,0,1
    db 0,0,0,0,1
    db 0,0,0,1,0
    db 0,0,1,0,0
    db 0,1,0,0,0
    db 1,1,1,1,1
    jmp dcCharDone

dc3:
    call DrawPattern5x7
    db 0,1,1,1,0
    db 1,0,0,0,1
    db 0,0,0,0,1
    db 0,0,1,1,0
    db 0,0,0,0,1
    db 1,0,0,0,1
    db 0,1,1,1,0
    jmp dcCharDone

dc4:
    call DrawPattern5x7
    db 0,0,0,1,0
    db 0,0,1,1,0
    db 0,1,0,1,0
    db 1,0,0,1,0
    db 1,1,1,1,1
    db 0,0,0,1,0
    db 0,0,0,1,0
    jmp dcCharDone

dc5:
    call DrawPattern5x7
    db 1,1,1,1,1
    db 1,0,0,0,0
    db 1,1,1,1,0
    db 0,0,0,0,1
    db 0,0,0,0,1
    db 1,0,0,0,1
    db 0,1,1,1,0
    jmp dcCharDone

dc8:
    call DrawPattern5x7
    db 0,1,1,1,0
    db 1,0,0,0,1
    db 1,0,0,0,1
    db 0,1,1,1,0
    db 1,0,0,0,1
    db 1,0,0,0,1
    db 0,1,1,1,0
    jmp dcCharDone

dc9:
    call DrawPattern5x7
    db 0,1,1,1,0
    db 1,0,0,0,1
    db 1,0,0,0,1
    db 0,1,1,1,1
    db 0,0,0,0,1
    db 1,0,0,0,1
    db 0,1,1,1,0
    jmp dcCharDone

; Punctuation
dcDash:
    call DrawPattern5x7
    db 0,0,0,0,0
    db 0,0,0,0,0
    db 0,0,0,0,0
    db 1,1,1,1,1
    db 0,0,0,0,0
    db 0,0,0,0,0
    db 0,0,0,0,0
    jmp dcCharDone

dcLParen:
    call DrawPattern5x7
    db 0,0,0,1,0
    db 0,0,1,0,0
    db 0,1,0,0,0
    db 0,1,0,0,0
    db 0,1,0,0,0
    db 0,0,1,0,0
    db 0,0,0,1,0
    jmp dcCharDone

dcRParen:
    call DrawPattern5x7
    db 0,1,0,0,0
    db 0,0,1,0,0
    db 0,0,0,1,0
    db 0,0,0,1,0
    db 0,0,0,1,0
    db 0,0,1,0,0
    db 0,1,0,0,0
    jmp dcCharDone

dcColon:
    call DrawPattern5x7
    db 0,0,0,0,0
    db 0,0,1,0,0
    db 0,0,1,0,0
    db 0,0,0,0,0
    db 0,0,1,0,0
    db 0,0,1,0,0
    db 0,0,0,0,0
    jmp dcCharDone

dcSpace:
    ; Just skip pixels for space
    jmp dcCharDone

dcCharDone:
    pop di
    pop dx
    pop cx
    pop ax
    ret

; Helper to draw 5x7 character pattern
; Pattern data follows the call in caller's code
DrawPattern5x7:
    pop si              ; Get return address (points to pattern data)
    push ax
    push cx
    push dx
    push di
    
    mov cx, 7           ; 7 rows
dp5Row:
    push di
    mov dx, 5           ; 5 columns
dp5Col:
    mov al, [cs:si]     ; Read pattern byte
    inc si
    cmp al, 1
    jne dp5Skip
    mov al, bl          ; Use saved color
    mov [es:di], al
dp5Skip:
    inc di
    dec dx
    jnz dp5Col
    
    pop di
    add di, 320         ; Next row
    dec cx
    jnz dp5Row
    
    pop di
    pop dx
    pop cx
    pop ax
    push si             ; Push new return address
    ret

; ============ GAME SETUP ============

InitialSetup:
    ; Set VGA mode 13h (320x200, 256 colors)
    mov ax, 0x13
    int 0x10
    
    ; Set ES to video memory segment
    mov ax, 0xA000
    mov es, ax
    
    ; Draw game background
    call DrawBackground
    call DrawGrassSprites
    call LoadCar
    ret

DrawBackground:
    push ax
    push bx
    push cx
    push dx
    push di
    
    xor di, di
    mov cx, 200         ; 200 rows
    
bgLoop1:
    cmp cx, 0
    jne bgContinue
    jmp bgExit
bgContinue:
    push cx
    mov dx, 320         ; 320 columns
    
bgLoop2:
    cmp dx, 0
    je bgDone
    mov ax, 320
    sub ax, dx
    
    ; Check if we're in the border (left < 80 or right >= 240)
    cmp ax, 80
    jb bgDrawBorder
    cmp ax, 240
    jae bgDrawBorder
    jmp bgDrawRoad
    
bgDrawBorder:
    ; Alternating green stripes for grass border
    mov ax, 200
    pop bx
    push bx
    sub ax, bx
    mov bl, 5
    div bl
    test al, 1
    jz bgBorderLight
    mov byte [es:di], 2     ; Dark green
    jmp bgAfter
bgBorderLight:
    mov byte [es:di], 10    ; Light green
    jmp bgAfter
    
bgDrawRoad:
    mov byte [es:di], 8     ; Grey road
    
bgAfter:
    inc di
    dec dx
    jmp bgLoop2
    
bgDone:
    pop cx
    dec cx
    jmp bgLoop1
    
bgExit:
    pop di
    pop dx
    pop cx
    pop bx
    pop ax
    ret

DrawGrassSprites:
    push ax
    push bx
    push cx
    push dx
    push di
    
    ; Trees on left side
    mov di,320*20+10
    call DrawTree
    mov di,320*60+25
    call DrawTree
    mov di,320*100+15
    call DrawTree
    mov di,320*140+30
    call DrawTree
    mov di,320*180+8
    call DrawTree
    
    ; Trees on right side
    mov di,320*30+265
    call DrawTree
    mov di,320*70+280
    call DrawTree
    mov di,320*110+270
    call DrawTree
    mov di,320*150+285
    call DrawTree
    
    ; Flowers on left side
    mov di,320*35+50
    call DrawFlower
    mov di,320*80+45
    call DrawFlower
    mov di,320*125+55
    call DrawFlower
    mov di,320*165+48
    call DrawFlower
    
    ; Flowers on right side
    mov di,320*45+250
    call DrawFlower
    mov di,320*90+258
    call DrawFlower
    mov di,320*135+252
    call DrawFlower
    
    ; Rocks on left side
    mov di,320*50+35
    call DrawRock
    mov di,320*120+40
    call DrawRock
    
    ; Rocks on right side
    mov di,320*65+300
    call DrawRock
    mov di,320*130+305
    call DrawRock
    
    pop di
    pop dx
    pop cx
    pop bx
    pop ax
    ret

DrawTree:
    push bx
    push cx
    push dx
    push di
    mov bx,TreeSprite
    mov cx,18           ; 18 rows
dtRow:
    cmp cx,0
    je dtDone
    push di
    mov dx,12           ; 12 columns
dtCol:
    cmp dx,0
    je dtNext
    mov al,[bx]
    mov [es:di],al
    inc bx
    inc di
    dec dx
    jmp dtCol
dtNext:
    pop di
    add di,320
    dec cx
    jmp dtRow
dtDone:
    pop di
    pop dx
    pop cx
    pop bx
    ret

DrawFlower:
    push bx
    push cx
    push dx
    push di
    mov bx,FlowerSpriteOrange
    mov cx,7            ; 7 rows
dfRow:
    cmp cx,0
    je dfDone
    push di
    mov dx,7            ; 7 columns
dfCol:
    cmp dx,0
    je dfNext
    mov al,[bx]
    mov [es:di],al
    inc bx
    inc di
    dec dx
    jmp dfCol
dfNext:
    pop di
    add di,320
    dec cx
    jmp dfRow
dfDone:
    pop di
    pop dx
    pop cx
    pop bx
    ret

DrawRock:
    push bx
    push cx
    push dx
    push di
    mov bx,RockSprite
    mov cx,4            ; 4 rows
drRow:
    cmp cx,0
    je drDone
    push di
    mov dx,6            ; 6 columns
drCol:
    cmp dx,0
    je drNext
    mov al,[bx]
    mov [es:di],al
    inc bx
    inc di
    dec dx
    jmp drCol
drNext:
    pop di
    add di,320
    dec cx
    jmp drRow
drDone:
    pop di
    pop dx
    pop cx
    pop bx
    ret

; ============ ROAD STRIPES (ANIMATED) ============

DrawStripes:
    push ax
    push bx
    push cx
    push dx
    push di
    
    ; Update stripe animation offset
    mov al, [stripeOffset]
    inc al
    cmp al, 28
    jb noResetStripe
    xor al, al
noResetStripe:
    mov [stripeOffset], al
    
    mov cx, 200
    xor di, di
    add di, 80          ; Start at left edge of road
    
stripeLoop1:
    cmp cx, 0
    jne stripeContinue
    jmp stripeExit
stripeContinue:
    push cx
    
    ; Calculate if this row should have stripes
    mov ax, 200
    sub ax, cx
    add al, [stripeOffset]
    mov bl, 14
    div bl
    test al, 1
    jz noStripeRow
    
    ; Draw white stripes (4 pixels wide each)
    mov ax, 38
    add ax, di
    push di
    mov di, ax
    mov byte [es:di], 15
    mov byte [es:di+1], 15
    mov byte [es:di+2], 15
    mov byte [es:di+3], 15
    pop di
    
    mov ax, 78
    add ax, di
    push di
    mov di, ax
    mov byte [es:di], 15
    mov byte [es:di+1], 15
    mov byte [es:di+2], 15
    mov byte [es:di+3], 15
    pop di
    
    mov ax, 118
    add ax, di
    push di
    mov di, ax
    mov byte [es:di], 15
    mov byte [es:di+1], 15
    mov byte [es:di+2], 15
    mov byte [es:di+3], 15
    pop di
    jmp doneStripeRow
    
noStripeRow:
    ; Draw road color (grey)
    mov ax, 38
    add ax, di
    push di
    mov di, ax
    mov byte [es:di], 8
    mov byte [es:di+1], 8
    mov byte [es:di+2], 8
    mov byte [es:di+3], 8
    pop di
    
    mov ax, 78
    add ax, di
    push di
    mov di, ax
    mov byte [es:di], 8
    mov byte [es:di+1], 8
    mov byte [es:di+2], 8
    mov byte [es:di+3], 8
    pop di
    
    mov ax, 118
    add ax, di
    push di
    mov di, ax
    mov byte [es:di], 8
    mov byte [es:di+1], 8
    mov byte [es:di+2], 8
    mov byte [es:di+3], 8
    pop di
    
doneStripeRow:
    add di, 320
    pop cx
    dec cx
    jmp stripeLoop1
    
stripeExit:
    pop di
    pop dx
    pop cx
    pop bx
    pop ax
    ret

; ============ PLAYER CAR FUNCTIONS ============

LoadCar:
    push ax
    push bx
    push cx
    push dx
    push di
    
    ; Calculate screen position (Y * 320 + X)
    mov ax, [playerY]
    mov bx, 320
    mul bx
    add ax, [playerX]
    mov di, ax
    
    mov bx, CarModel
    mov cx, 14          ; 14 rows
lcRow:
    cmp cx, 0
    je lcExit
    push di
    mov dx, 12          ; 12 columns
lcCol:
    cmp dx, 0
    je lcDone
    mov al, [bx]
    cmp al, 255         ; Skip transparent pixels
    je lcSkip
    mov [es:di], al
lcSkip:
    inc bx
    inc di
    dec dx
    jmp lcCol
lcDone:
    pop di
    add di, 320
    dec cx
    jmp lcRow
lcExit:
    pop di
    pop dx
    pop cx
    pop bx
    pop ax
    ret

EraseCar:
    push ax
    push cx
    push dx
    push di
    
    ; Calculate screen position
    mov ax, [playerY]
    mov bx, 320
    mul bx
    add ax, [playerX]
    mov di, ax
    
    mov cx, 14          ; 14 rows
ecRow:
    cmp cx, 0
    je ecExit
    push di
    mov dx, 12          ; 12 columns
ecCol:
    cmp dx, 0
    je ecDone
    mov byte [es:di], 8 ; Draw road color
    inc di
    dec dx
    jmp ecCol
ecDone:
    pop di
    add di, 320
    dec cx
    jmp ecRow
ecExit:
    pop di
    pop dx
    pop cx
    pop ax
    ret

; ============ INPUT HANDLING ============

HandleInput:
    push ax
    
    ; Check if key is pressed
    mov ah, 1
    int 16h
    jnz hiKeyPressed
    jmp hiNoKey
    
hiKeyPressed:
    ; Get key
    mov ah, 0
    int 16h
    
    ; Check game state
    mov al, [gameState]
    cmp al, 0
    jne hiInGame
    jmp hiStartScreen
    
hiInGame:
    ; In-game controls
    cmp ah, 4Bh         ; Left arrow
    jne hiNotLeft
    jmp hiMoveLeft
hiNotLeft:
    cmp ah, 4Dh         ; Right arrow
    jne hiNotRight
    jmp hiMoveRight
hiNotRight:
    cmp ah, 48h         ; Up arrow
    jne hiNotUp
    jmp hiMoveUp
hiNotUp:
    cmp ah, 50h         ; Down arrow
    jne hiNotDown
    jmp hiMoveDown
hiNotDown:
    cmp al, 27          ; ESC
    jne hiNoKey
    jmp hiExit
    
hiStartScreen:
    ; Any key starts the game
    mov byte [gameState], 1
    call InitialSetup   ; Initialize game screen
    jmp hiNoKey
    
hiMoveLeft:
    call EraseCar
    mov ax, [playerX]
    cmp ax, 85          ; Left boundary
    jbe hiNoKey
    sub word [playerX], 8
    call LoadCar
    jmp hiNoKey
    
hiMoveRight:
    call EraseCar
    mov ax, [playerX]
    cmp ax, 216         ; Right boundary
    jae hiNoKey
    add word [playerX], 8
    call LoadCar
    jmp hiNoKey
    
hiMoveUp:
    call EraseCar
    mov ax, [playerY]
    cmp ax, 10          ; Top boundary (allow some margin from top)
    jbe hiNoKey
    sub word [playerY], 8
    call LoadCar
    jmp hiNoKey
    
hiMoveDown:
    call EraseCar
    mov ax, [playerY]
    cmp ax, 172         ; Bottom boundary (200 - 14 car height - margin = ~172)
    jae hiNoKey
    add word [playerY], 8
    call LoadCar
    jmp hiNoKey
    
hiExit:
    ; Exit to DOS
    mov ax, 0x03
    int 0x10
    mov ax, 0x4C00
    int 0x21
    
hiNoKey:
    pop ax
    ret

; ============ GENERIC SPRITE ERASER ============
; BX = width, CX = height, DI = offset

EraseSprite:
    push ax
    push cx
    push dx
    push di
    
esRow:
    cmp cx, 0
    je esExit
    push di
    mov dx, bx
esCol:
    cmp dx, 0
    je esDone
    mov byte [es:di], 8 ; Draw road color
    inc di
    dec dx
    jmp esCol
esDone:
    pop di
    add di, 320
    dec cx
    jmp esRow
esExit:
    pop di
    pop dx
    pop cx
    pop ax
    ret

; ============ CALCULATE SCREEN OFFSET ============
; AX = Y, SI = X, returns DI = screen offset

CalcOffset:
    push bx
    push dx
    mov bx, 320
    mul bx
    add ax, si
    mov di, ax
    pop dx
    pop bx
    ret

; ============ ENEMY FUNCTIONS ============

DrawEnemy:
    push ax
    push bx
    push cx
    push dx
    push di
    
    mov bx, CarModelObstacle
    mov cx, 14          ; 14 rows
deRow:
    cmp cx, 0
    je deExit
    push di
    mov dx, 12          ; 12 columns
deCol:
    cmp dx, 0
    je deDone
    mov al, [bx]
    cmp al, 255         ; Skip transparent pixels
    je deSkip
    mov [es:di], al
deSkip:
    inc bx
    inc di
    dec dx
    jmp deCol
deDone:
    pop di
    add di, 320
    dec cx
    jmp deRow
deExit:
    pop di
    pop dx
    pop cx
    pop bx
    pop ax
    ret

UpdateEnemies:
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    
    xor bx, bx
    
ueLoop:
    cmp bx, MAX_ENEMIES
    jb ueContinue
    jmp ueExit
ueContinue:
    mov al, [enemyActive + bx]
    cmp al, 0
    je ueNext
    
    ; Get current position
    push bx
    shl bx, 1
    mov si, [enemyX + bx]
    mov ax, [enemyY + bx]
    pop bx
    
    ; Erase at old position
    push bx
    push ax
    push si
    call CalcOffset
    mov bx, 12
    mov cx, 14
    call EraseSprite
    pop si
    pop ax
    pop bx
    
    ; Move down
    add ax, 4
    cmp ax, 186         ; Check if off screen
    jb ueOnScreen
    mov byte [enemyActive + bx], 0
    jmp ueNext
    
ueOnScreen:
    ; Save new Y position
    push bx
    shl bx, 1
    mov [enemyY + bx], ax
    pop bx
    
    ; Draw at new position
    push bx
    shl bx, 1
    mov ax, [enemyY + bx]
    pop bx
    call CalcOffset
    call DrawEnemy
    
ueNext:
    inc bx
    jmp ueLoop
    
ueExit:
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret

; ============ COIN FUNCTIONS ============

DrawCoin:
    push ax
    push bx
    push cx
    push dx
    push di
    
    mov bx, CoinModel
    mov cx, 5           ; 5 rows
dcRow:
    cmp cx, 0
    je dcExit
    push di
    mov dx, 5           ; 5 columns
dcCol:
    cmp dx, 0
    je dcDone
    mov al, [bx]
    mov [es:di], al
    inc bx
    inc di
    dec dx
    jmp dcCol
dcDone:
    pop di
    add di, 320
    dec cx
    jmp dcRow
dcExit:
    pop di
    pop dx
    pop cx
    pop bx
    pop ax
    ret

UpdateCoins:
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    
    xor bx, bx
    
ucLoop:
    cmp bx, MAX_COINS
    jb ucContinue
    jmp ucExit
ucContinue:
    mov al, [coinActive + bx]
    cmp al, 0
    je ucNext
    
    ; Get current position
    push bx
    shl bx, 1
    mov si, [coinX + bx]
    mov ax, [coinY + bx]
    pop bx
    
    ; Erase at old position
    push bx
    push ax
    push si
    call CalcOffset
    mov bx, 5
    mov cx, 5
    call EraseSprite
    pop si
    pop ax
    pop bx
    
    ; Move down
    add ax, 4
    cmp ax, 195         ; Check if off screen
    jb ucOnScreen
    mov byte [coinActive + bx], 0
    jmp ucNext
    
ucOnScreen:
    ; Save new Y position
    push bx
    shl bx, 1
    mov [coinY + bx], ax
    pop bx
    
    ; Draw at new position
    push bx
    shl bx, 1
    mov ax, [coinY + bx]
    pop bx
    call CalcOffset
    call DrawCoin
    
ucNext:
    inc bx
    jmp ucLoop
    
ucExit:
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret

; ============ FUEL FUNCTIONS ============

DrawFuel:
    push ax
    push bx
    push cx
    push dx
    push di
    
    mov bx, FuelModel
    mov cx, 10          ; 10 rows
dflRow:
    cmp cx, 0
    je dflExit
    push di
    mov dx, 10          ; 10 columns
dflCol:
    cmp dx, 0
    je dflDone
    mov al, [bx]
    mov [es:di], al
    inc bx
    inc di
    dec dx
    jmp dflCol
dflDone:
    pop di
    add di, 320
    dec cx
    jmp dflRow
dflExit:
    pop di
    pop dx
    pop cx
    pop bx
    pop ax
    ret

UpdateFuel:
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    
    xor bx, bx
    
ufLoop:
    cmp bx, MAX_FUEL
    jb ufContinue
    jmp ufExit
ufContinue:
    mov al, [fuelActive + bx]
    cmp al, 0
    je ufNext
    
    ; Get current position
    push bx
    shl bx, 1
    mov si, [fuelX + bx]
    mov ax, [fuelY + bx]
    pop bx
    
    ; Erase at old position
    push bx
    push ax
    push si
    call CalcOffset
    mov bx, 10
    mov cx, 10
    call EraseSprite
    pop si
    pop ax
    pop bx
    
    ; Move down
    add ax, 4
    cmp ax, 190         ; Check if off screen
    jb ufOnScreen
    mov byte [fuelActive + bx], 0
    jmp ufNext
    
ufOnScreen:
    ; Save new Y position
    push bx
    shl bx, 1
    mov [fuelY + bx], ax
    pop bx
    
    ; Draw at new position
    push bx
    shl bx, 1
    mov ax, [fuelY + bx]
    pop bx
    call CalcOffset
    call DrawFuel
    
ufNext:
    inc bx
    jmp ufLoop
    
ufExit:
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret

; ============ SPAWNER FUNCTIONS (3 LANES) ============

SpawnEnemyTicker:
    push ax
    push bx
    push cx
    push dx
    
    ; Check spawn timer
    mov al, [spawnTimer]
    cmp al, 0
    jne seWait
    
    ; Find free enemy slot
    xor bx, bx
seFindFree:
    cmp bx, MAX_ENEMIES
    jae seDone
    mov al, [enemyActive + bx]
    cmp al, 0
    je seFoundFree
    inc bx
    jmp seFindFree
    
seFoundFree:
    ; Get random lane (0-2)
    mov ah, 0
    int 0x1A            ; Get system timer
    mov ax, dx
    xor dx, dx
    mov cx, 3
    div cx              ; DX = remainder (0, 1, or 2)
    
    cmp dx, 0
    je seLane1
    cmp dx, 1
    je seLane2
    jmp seLane3
    
seLane1:
    mov cx, lane1X
    jmp seSetPos
seLane2:
    mov cx, lane2X
    jmp seSetPos
seLane3:
    mov cx, lane3X
    
seSetPos:
    ; Set enemy position
    push bx
    shl bx, 1
    mov [enemyX + bx], cx
    mov word [enemyY + bx], 0
    pop bx
    mov byte [enemyActive + bx], 1
    mov byte [spawnTimer], 40   ; Reset timer
    jmp seDone
    
seWait:
    dec byte [spawnTimer]
    
seDone:
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
    
    ; Check spawn timer
    mov al, [spawnCoinTimer]
    cmp al, 0
    jne scWait
    
    ; Find free coin slot
    xor bx, bx
scFindFree:
    cmp bx, MAX_COINS
    jae scDone
    mov al, [coinActive + bx]
    cmp al, 0
    je scFoundFree
    inc bx
    jmp scFindFree
    
scFoundFree:
    ; Get random lane (0-2)
    mov ah, 0
    int 0x1A            ; Get system timer
    mov ax, dx
    xor dx, dx
    mov cx, 3
    div cx
    
    cmp dx, 0
    je scLane1
    cmp dx, 1
    je scLane2
    jmp scLane3
    
scLane1:
    mov cx, lane1X
    jmp scSetPos
scLane2:
    mov cx, lane2X
    jmp scSetPos
scLane3:
    mov cx, lane3X
    
scSetPos:
    ; Set coin position
    push bx
    shl bx, 1
    mov [coinX + bx], cx
    mov word [coinY + bx], 0
    pop bx
    mov byte [coinActive + bx], 1
    mov byte [spawnCoinTimer], 90   ; Reset timer
    jmp scDone
    
scWait:
    dec byte [spawnCoinTimer]
    
scDone:
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
    
    ; Check spawn timer
    mov al, [spawnFuelTimer]
    cmp al, 0
    jne sfWait
    
    ; Find free fuel slot
    xor bx, bx
sfFindFree:
    cmp bx, MAX_FUEL
    jae sfDone
    mov al, [fuelActive + bx]
    cmp al, 0
    je sfFoundFree
    inc bx
    jmp sfFindFree
    
sfFoundFree:
    ; Get random lane (0-2)
    mov ah, 0
    int 0x1A            ; Get system timer
    mov ax, dx
    xor dx, dx
    mov cx, 3
    div cx
    
    cmp dx, 0
    je sfLane1
    cmp dx, 1
    je sfLane2
    jmp sfLane3
    
sfLane1:
    mov cx, lane1X
    jmp sfSetPos
sfLane2:
    mov cx, lane2X
    jmp sfSetPos
sfLane3:
    mov cx, lane3X
    
sfSetPos:
    ; Set fuel position
    push bx
    shl bx, 1
    mov [fuelX + bx], cx
    mov word [fuelY + bx], 0
    pop bx
    mov byte [fuelActive + bx], 1
    mov byte [spawnFuelTimer], 150  ; Reset timer
    jmp sfDone
    
sfWait:
    dec byte [spawnFuelTimer]
    
sfDone:
    pop dx
    pop cx
    pop bx
    pop ax
    ret

; ============ VSYNC WAIT ============

WaitVSync:
    push ax
    push dx
    mov dx, 0x03DA      ; VGA status register
wvWait1:
    in al, dx
    test al, 8          ; Test vertical retrace bit
    jz wvWait1
wvWait2:
    in al, dx
    test al, 8
    jnz wvWait2
    pop dx
    pop ax
    ret

; ============ MAIN PROGRAM ============

start:
    ; Set VGA mode 13h
    mov ax, 0x13
    int 0x10
    mov ax, 0xA000
    mov es, ax
    
    ; Draw start screen
    call DrawStartScreen
    
    ; Wait for keypress to start
StartScreenLoop:
    call WaitVSync
    call HandleInput
    mov al, [gameState]
    cmp al, 0
    je StartScreenLoop

; Main game loop
MainLoop:
    call WaitVSync
    call HandleInput
    
    ; Update game every 2 frames
    inc byte [frameCounter]
    mov al, [frameCounter]
    cmp al, 2
    jb mlSkipUpdate
    mov byte [frameCounter], 0
    
    ; Update all game elements
    call DrawStripes
    call SpawnEnemyTicker
    call SpawnCoinTicker
    call SpawnFuelTicker
    call UpdateEnemies
    call UpdateCoins
    call UpdateFuel
    call LoadCar
    
mlSkipUpdate:
    jmp MainLoop