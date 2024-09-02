jockey(valdivieso, 155, 52).
jockey(leguisamo, 161, 49).
jockey(lezcano, 149, 50).
jockey(baratucci, 153, 55).
jockey(falero, 157, 52).

caballo(botafogo).
caballo(oldMan).
caballo(energica).
caballo(matBoy).
caballo(yatasto).

gano(botafogo, granPremioNacional).
gano(botafogo, granPremioRepublica).
gano(oldMan, granPremioRepublica).
gano(oldMan, palermoDeOro).
gano(botafogo, granPremioCriadores).

leGusta(botafogo, baratucci).

leGusta(botafogo, Jockey):-
    jockey(Jockey, _, Peso),
    Peso < 52.

leGusta(oldMan, Jockey):-
    jockey(Jockey, _, _),
    atom_length(Jockey, Letras),
    Letras > 7.

leGusta(matBoy, Jockey):-
    jockey(Jockey, Altura, _),
    Altura > 170.

leGusta(energica, Jockey):-
    jockey(Jockey,_,_),
    not(leGusta(botafogo, Jockey)).

%% no poner aca a yatasto representa el concepto de universo cerrado

stud(valdivieso, elTute).
stud(falero, elTute).
stud(lezcano, lasHormigas).
stud(leguisamo, elCharabon).
stud(baratucci, elCharabon).

%% TODO: modelar premios

%%% punto 2 %%%

prefiereMasDeUno(Caballo):-
    caballo(Caballo),
    leGusta(Caballo, Jockey),
    leGusta(Caballo, OtroJockey),
    Jockey \= OtroJockey.

%%% punto 3 %%%
aborrece(Caballo, Stud):-
    caballo(Caballo),
    stud(Stud, _),   
    forall(stud(Jockey, Stud), noPrefiere(Caballo, Jockey)).

noPrefiere(Caballo, Jockey):-
    jockey(Jockey, _, _),
    not(leGusta(Caballo, Jockey)).

%%% punto 4 %%%
piolin(Jockey):-
    caballo(Caballo),
    forall(caballoImportante(Caballo), leGusta(Caballo, Jockey)).

caballoImportante(Caballo):-
    gano(Caballo, Premio),
    premioImportante(Premio).

premioImportante(granPremioNacional).
premioImportante(granPremioRepublica).

%%% punto 5 %%%
    