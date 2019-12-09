section .text

global  func
func:
  push  ebp
  mov ebp,  esp

  mov edx, [ebp+8]
  
  mov eax, 0
  
  ; liczymy rozmiar tablicy
petla_liczenie:
  inc eax
  inc edx
  mov bl, [edx]
  cmp bl, 0
  jnz petla_liczenie

  dec eax 

  mov edx, [ebp+8]
  
; mamy rozmiar w eax
  mov esi, eax
; esi - licznik zewnetrznej petli

petla_sortowanie:
  mov ebx, eax
petla_wewnetrzna:
  dec ebx 
; iterujemy ebeiksem od n-1 do 0, sprawdzmy elementy ebx i ebx+1
  mov cl, [edx+ebx]
  mov ch, [edx+ebx+1]
  cmp cl, ch
  jl bez_zamiany
  xchg cl, ch
  mov [edx+ebx], cl
  mov [edx+ebx+1], ch
  bez_zamiany:

  cmp ebx, 0
  jnz petla_wewnetrzna

  dec esi
  jnz petla_sortowanie

  mov   esp,  ebp
  pop ebp
ret