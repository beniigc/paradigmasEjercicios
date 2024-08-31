integrante(sophieTrio, sophie, violin).
integrante(sophieTrio, santi, guitarra).
integrante(vientosDelEste, lisa, saxo).
integrante(vientosDelEste, santi, voz).
integrante(vientosDelEste, santi, guitarra).
integrante(jazzmin, santi, bateria).

nivelQueTiene(sophie, violin, 5).
nivelQueTiene(santi, guitarra, 2).
nivelQueTiene(santi, voz, 3).
nivelQueTiene(santi, bateria, 4).
nivelQueTiene(lisa, saxo, 4).
nivelQueTiene(lore, violin, 4).
nivelQueTiene(luis, trompeta, 1).
nivelQueTiene(luis, contrabajo, 4).

instrumento(violin, melodico(cuerdas)).
instrumento(guitarra, armonico).
instrumento(bateria, ritmico).
instrumento(saxo, melodico(viento)).
instrumento(trompeta, melodico(viento)).
instrumento(contrabajo, armonico).
instrumento(bajo, armonico).
instrumento(piano, armonico).
instrumento(pandereta, ritmico).
instrumento(voz, melodico(vocal)).

grupo(sophieTrio).
grupo(vientosDelEste).
grupo(jazzmin).
%%%esto no hacia falta
%%% 1 %%%
tieneBuenaBase(Grupo):-
    integrante(Grupo, _, Instrumento1),
    integrante(Grupo, _, Instrumento2),
    instrumento(Instrumento1, armonico),
    instrumento(Instrumento2, ritmico).

%%% 2 %%%
destaca(Integrante, Grupo):-
    integrante(Grupo, Integrante, Instrumento),
    forall((integrante(Grupo, OtroIntegrante, OtroInstrumento), Integrante \= OtroIntegrante), tieneMayorNivel(Integrante, OtroIntegrante, Instrumento, OtroInstrumento)).

tieneMayorNivel(Integrante1, Integrante2, Instrumento1, Instrumento2):-
    nivelQueTiene(Integrante1, Instrumento1, Nivel1),
    nivelQueTiene(Integrante2, Instrumento2, Nivel2),
    Nivel1 > Nivel2.

%%% 3 %%%
grupo(vientosDelEste, bigBand).
grupo(sophieTrio, [contrabajo, guitarra, violin]).
grupo(jazzmin, [bateria, bajo, trompeta, piano, guitarra]).

%%% 4 %%%
hayCupo(Instrumento, Grupo):-
    grupo(Grupo, bigband),
    instrumento(Instrumento, melodico(viento)).
    
hayCupo(Instrumento, Grupo):-
    sirveInstrumento(Grupo, Instrumento),
    not(alguienYaToca(Instrumento, Grupo)).

%%% esto seria que no hay dos con el mismo, en cambio, como se quiere incorporar el instrumento, tenes que fijarte que no haya ninguno que previamente lo tenga
alguienYaToca(Instrumento, Grupo):-
    integrante(Grupo, _, Instrumento).
    
sirveInstrumento(Instrumento, bigBand):-
    instrumento(Instrumento, bateria).
    
sirveInstrumento(Instrumento, bigBand):-
    instrumento(Instrumento, bajo).
        
sirveInstrumento(Instrumento, bigBand):-
    instrumento(Instrumento, piano).
        
sirveInstrumento(Instrumento, Grupo):-
    grupo(Grupo, Formacion),
    member(Instrumento, Formacion).

%%%% 5 %%%%
puedeIncorporarse(Integrante, Grupo, Instrumento):-
    not(integrante(Grupo, Integrante, _)),
    hayCupo(Instrumento, Grupo),
    nivelQueTiene(Integrante, Instrumento, Nivel),
    nivelEsperado(Grupo, Nivel).

nivelEsperado(bigBand, Nivel):-
    Nivel >= 1.

nivelEsperado(Grupo, Nivel):-
    grupo(Grupo, Formacion),
    length(Formacion, CantidadDeInstrumentos),
    Nivel >= (7 - CantidadDeInstrumentos).

%%% 6 %%%
quedoEnBanda(Musico):-
    grupo(Grupo,_),
    not(integrante(Grupo, Musico, _)),
    forall(Integrante(_, Musico, Instrumento), not(puedeIncorporarse(Musico, _, Instrumento))). 

