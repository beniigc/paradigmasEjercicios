linea(a,[plazaMayo,peru,lima,congreso,miserere,rioJaneiro,primeraJunta,nazca]).
linea(b,[alem,pellegrini,callao,pueyrredonB,gardel,medrano,malabia,lacroze,losIncas,urquiza]).
linea(c,[retiro,diagNorte,avMayo,independenciaC,plazaC]).
linea(d,[catedral,nueveJulio,medicina,pueyrredonD,plazaItalia,carranza,congresoTucuman]).
linea(e,[bolivar,independenciaE,pichincha,jujuy,boedo,varela,virreyes]).
linea(h,[lasHeras,santaFe,corrientes,once,venezuela,humberto1ro,inclan,caseros]).
combinacion([lima, avMayo]).
combinacion([once, miserere]).
combinacion([pellegrini, diagNorte, nueveJulio]).
combinacion([independenciaC, independenciaE]).
combinacion([jujuy, humberto1ro]).
combinacion([santaFe, pueyrredonD]).
combinacion([corrientes, pueyrredonB]).


% 1. estaEn/2: en qué línea está una estación.
estaEn(Linea, Estacion) :-
    linea(Linea,Estaciones),
    member(Estacion, Estaciones).

% 2. distancia/3: dadas dos estaciones de la misma línea, cuántas estaciones hay entre ellas: por ejemplo, entre Perú y Primera Junta hay 5 estaciones.
distancia(Estacion1,Estacion2, Distancia) :-
    mismaLinea(Estacion1,Estacion2),
    linea(_,Estaciones),
    nth0(Posicion1,Estaciones,Estacion1),
    nth0(Posicion2,Estaciones,Estacion2),
    abs((Posicion1 - Posicion2), Distancia).
    
mismaLinea(Estacion1,Estacion2) :-
    linea(_,Estaciones),
    member(Estacion1,Estaciones),
    member(Estacion2,Estaciones).  % En esta funcion podrias haber usado estaEn

% 3. mismaAltura/2: dadas dos estaciones de distintas líneas, si están a la misma altura (o sea, las dos terceras, las dos quintas, etc.), por ejemplo: Pellegrini y Santa Fe están ambas segundas.
mismaAltura(Estacion1, Estacion2) :-
    linea(_,Estaciones),
    linea(_,OtrasEstaciones),
    nth0(Posicion,Estaciones,Estacion1),
    nth0(Posicion,OtrasEstaciones,Estacion2).
    
% 4. granCombinacion/1: se cumple para una combinación de más de dos estaciones.
granCombinacion(Combinacion) :-
    combinacion(Combinacion),
    length(Combinacion,Largo),
    Largo > 2.

% 5. cuantasCombinan/2: dada una línea, relaciona esa línea con la cantidad de estaciones de esa línea que tienen alguna combinación. Por ejemplo, 
% la línea C tiene 3 estaciones que combinan (avMayo, diagNorte e independenciaC).
cuantasCombinan(Linea, Cantidad) :-
    linea(Linea,_),
    estaEn(Linea,Estacion),
    findall(Estacion, tieneCombinacion(Estacion), Combinados),
    length(Combinados, Cantidad).

tieneCombinacion(Estacion):-
    estaEn(_,Estacion),
    combinacion(Combinaciones),
    member(Estacion, Combinaciones).

% 6. lineaMasLarga/1: es verdadero para la línea con más estaciones.
lineaMasLarga(Linea) :-
    linea(Linea,_),
    forall(linea(OtraLinea,_), tieneMasEstaciones(Linea,OtraLinea)).

tieneMasEstaciones(Linea,OtraLinea) :- % Esta podria haber sido una funcion que compare un numero con la cantidad de estaciones de una linea
    linea(Linea,Estaciones),
    linea(OtraLinea,OtrasEstaciones),
    length(Estaciones, Cantidad1),
    length(OtrasEstaciones, Cantidad2),
    Cantidad1 > Cantidad2.

% 7. viajeFacil/2: dadas dos estaciones, si puedo llegar fácil de una a la otra; esto es, si están en la misma línea, o bien puedo llegar con una sola combinación.
viajeFacil(Estacion1, Estacion2) :-
    estaEn(Linea, Estacion1),
    estaEn(Linea, Estacion2).

viajeFacil(Estacion1, Estacion2) :-
    combinacion(Combinacion),
    member(Estacion1,Combinacion),
    member(Estacion2,Combinacion).