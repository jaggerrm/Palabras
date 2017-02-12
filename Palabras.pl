%Israel Ramírez
%Seminario de sistemas basados en conocimiento D01

bstinsert(vacio,X, nodo(X,vacio,vacio)). %nodo(Valor,Izq,Der).
bstinsert(Tree,X,Tree):- Tree = nodo(X,_,_).
bstinsert(nodo(K,L,R),X,nodo(K,Lnew,R)):-
  X@<K, bstinsert(L,X,Lnew).
bstinsert(nodo(K,L,R),X,nodo(K,L,Rnew)):-
  X@>K, bstinsert(R,X,Rnew).


insertaArbol(_,[]). %Pasar elementos de la lista de palabras al arbol
insertaArbol(Arbol,[Cabeza|Cola]):-
  insertaArbol(NewArbol,Cola),
  bstinsert(NewArbol,Cabeza,Arbol).


buscar:-  %Correr todo
  abecedario(Letras),
  generarPalabras(Letras,Palabras,10),
  write('Palabras generadas: \n'),
  writePalabras(Palabras),
  write('\nIngrese una palabra: '),
  read(Palabra),
  get_time(T),
  member(Palabra,Palabras), %palabra en lista?
  get_time(T1),
  T2 is T1-T,
  insertaArbol(Arbol,Palabras),
  write('\n\nArbol generado: \n'),
  write(Arbol),
  get_time(T3),
  bstinsert(Arbol,Palabra,_), %palabra en arbol?
  get_time(T4),
  T5 is T4-T3,
  write('\n\nTiempo de busqueda en lista: '), write(T2),
  write('\nTiempo de busqueda en Arbol: '),write(T5).


abecedario([a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z]).

palabra(0, _, []). %Creación de una palabra
palabra(Contador, Letras, [X|Seleccion]) :-
  random_member(X, Letras),
  C1 is Contador - 1,
  palabra(C1, Letras,Seleccion).

genera:- %para probar, inservible desde la beta :v
    abecedario(Letras),
    random(5,15,Z),
    palabra(Z,Letras,B),
    write(Z),nl,write(B).


generarPalabras(_,[],0). %Creación de la lista de palabras
generarPalabras(Letras,ListaPalabras,Contador):-
  Contador>0,
  random(5,15,Z), %Min , Max de la palabra
  palabra(Z,Letras,Generada),
  C1 is Contador -1,
  generarPalabras(Letras,Lista,C1),
  compara(Generada,Lista,ListaPalabras,C1,Letras).


not_member(_,[]).  %Verificar si no existe la palabra en la lista.
not_member(X,[Cabeza|Cola]):-
  X\=Cabeza,
  not_member(X,Cola).


compara(Palabra,Lista,NewPalabra,_,_):- %Si no se encuentra la palabra
  not_member(Palabra,Lista),
  NewPalabra=[Palabra|Lista].
compara(_,_,NewPalabra,Contador,Letras):- %Si existe la palabra
  C1 is Contador+1,
  generarPalabras(Letras,Lista,C1),
  NewPalabra=Lista.

writePalabras([]).
writePalabras([X|Y]):- %Imprime las palabras de la lista
  write(X),
  nl,
  writePalabras(Y).






