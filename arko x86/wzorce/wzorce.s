section .text

global  func
func:
  push  ebp
  mov ebp,  esp

  %idefine  tab1  [ebp+8]
  %idefine  tab2  [ebp+12]
  mov edx, tab1 
  dec edx

  ; liczymy rozmiar tablicy a
  mov eax, -1
petla_liczenie1:
  inc eax
  inc edx
  mov bl, [edx]
  cmp bl, 0
  jnz petla_liczenie1
  ; eax - rozmiar; wrzucamy go na stos
  push eax
  %idefine  rozmiar1  [ebp-4]
  
  mov edx, tab2
  dec edx

  ; liczymy rozmiar tablicy b
  mov eax, -1
petla_liczenie2:
  inc eax
  inc edx
  mov bl, [edx]
  cmp bl, 0
  jnz petla_liczenie2
  ; eax - rozmiar; wrzucamy go na stos
  push eax
  %idefine  rozmiar2  [ebp-8]
  
  ; przywracamy 
  mov edx, tab2
  dec edx

  mov eax, -1
petla_szukanie_gwiazdki:
  inc eax
  inc edx
  mov bl, [edx]
  cmp bl, '*'
  jne petla_szukanie_gwiazdki
  ; eax - pozycja gwiazdki
  dec eax
  push eax
  %idefine  gwiazdka  [ebp-12]

  ; mamy na stosie co trzeba

  ; najpierw przetwarzamy poczatek
  mov esi, tab1
  mov edi, tab2
petla_poczatek:
  mov al, [esi]
  cmp byte al, [edi]
  je  petla_poczatek_continue
  cmp byte [edi], '.'
  je  petla_poczatek_continue
  jmp rozne

petla_poczatek_continue:
  inc esi
  cmp byte [esi], 0
  jz rozne
  inc edi
  cmp byte [edi], '*'
  jne petla_poczatek


  ; teraz przetwarzamy koniec
  mov esi, tab1
  add esi, rozmiar1
  mov edi, tab2
  add edi, rozmiar2
petla_koniec:
  mov al, [esi]
  cmp byte al, [edi]
  je  petla_koniec_continue
  cmp byte [edi], '.'
  je  petla_koniec_continue
  jmp rozne

petla_koniec_continue:
  dec esi
  cmp byte [esi], 0
  jz rozne
  dec edi
  cmp byte [edi], '*'
  jne petla_koniec


rowne:
  mov eax, 1
  jmp koniec

rozne:
  mov eax, 0
  mov byte [esi], 'o'
  mov byte [edi], 'q'

koniec:
  ; dealokacja
  add esp, 12

  mov   esp,  ebp
  pop ebp
ret