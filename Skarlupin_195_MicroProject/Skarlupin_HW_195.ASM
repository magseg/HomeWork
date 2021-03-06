;������� 26. ����������� ���������, ����������� � ������� ���������� ���� � ��������� �� ���� 0,05% �������� ������� cos(x) ��� ��������� ��������� x (������������ FPU)
;�������� ��������� ������ ��������
format PE console ; ���������� ���������� ��� Windows
entry start ; ������������� ����� ����� - start

include 'win32ax.inc'
;--------------------------------Variable initialization------------------------------------------
section '.data' data readable writeable
    strX db 'x = ', 0 ; ������ ��� ������ � �������
    formatF     db    '%lf', 0
    x dq 0.0 ; ���������� ��� ������ �������� x
    output db 256  dup(?) ; ������ ��� ������ �� �������
;--------------------------------Variable initialization------------------------------------------
;--------------------------------Main program----------------------------------------------------
section '.code' code executable

start:
    MainProcedure: ; �������� ��������� - ������� �������� cos(x)
        call ReadX ; ���������� x
        call cosX ; ���������� cos(x). �������� ��������� � x
    jmp Show ; ��������� �� ����� ����������

cosX:
    FINIT ; ������������� ������������
    fld [x] ; ������� �������� x � ������� ST(0)
    FCOS ; ��������� cos(ST(0))
    FST [x] ; ������� �������� �������� � x
    ret

ReadX: ; ������� ���������� x
    push strX ; ������� ������ "x = " � ����
    call [printf] ; ������� �� ����� "x = "
    add esp, 4

    push x
    push formatF
    call [scanf] ; ��������� x
    add esp, 8
    ret

Show: ; ������� ��� ������ ����������
    invoke sprintf, output, 'cos(x) = %.4f', dword[x], dword[x+4] ; ��������� ������ ������
    call [printf] ; ����� ������ cos(x)
    call [getch] ; ����� getch ��� ����, ����� ������� �� ��������� �����
    push 0
    call [ExitProcess] ; ���������� ���������
;--------------------------------Main program----------------------------------------------------

;--------------------------------Libraries-------------------------------------------------------
section '.idata' data readable import
    library kernel32, 'kernel32.dll', \
       msvcrt, 'msvcrt.dll', \
       user32, 'USER32.dll'
    import kernel32,\
        ExitProcess, 'ExitProcess'
    import msvcrt,\
        printf, 'printf',\
        scanf, 'scanf',\
        sprintf, 'sprintf',\
        getch, '_getch'
;--------------------------------Libraries-------------------------------------------------------