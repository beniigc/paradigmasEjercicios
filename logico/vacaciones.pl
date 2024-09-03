viajo(dodain, pehuenia).
viajo(dodain, sanMartinDeLosAndes).
viajo(dodain, esquel).
viajo(dodain, sarmiento).
viajo(dodain, camarones).
viajo(dodain, playasDoradas).
viajo(alf, bariloche).
viajo(alf, sanMartinDeLosAndes).
viajo(alf, elBolson).
viajo(nico, marDelPlata).
viajo(vale, calfate).
viajo(vale, elBolson).

viajo(martu, Destino):-
    viajo(alf, Destino).
    
viajo(martu, Destino):-
    viajo(nico, Destino).

%% juan y carlos no son incorporados en la base de conocimiento debido a que no se sabe
%% una verdad sobre ellos y por ende, no viajan (principio de universo cerrado)

%%% 2 %%%

%% atraccion(lugar, atraccion).
atraccion(esquel, parqueNacional(losAlercers)).
atraccion(esquel, excursion(trochita)).
atraccion(esquel, excursion(trevelin)).

atraccion(pehuenia, cerro(bateaMahuida, 2000)).
atraccion(pehuenia, cuerpoAgua(moquehue, pescaHabilitada, 14)).
atraccion(pehuenia, cuerpoAgua(alumine, pescaHabilitada, 19)).

%% 3 %%

vacacionCopada(Persona):-
    forall(viajo(Persona, Destino), tieneAtraccionCopada(Destino)).

tieneAtraccionCopada(Destino):-
    atraccion(Destino, Atraccion),  
    atraccionCopada(Atraccion).

atraccionCopada(cerro(_, Altura)):-
    Altura > 2000.

atraccionCopada(cuerpoAgua(_, puedePescar, _)).

atraccionCopada(cuerpoAgua(_,_, Temperatura)):-
    Temperatura > 20.

atraccionCopada(playa(DiferenciaDeMareas)):-
    DiferenciaDeMareas < 5.

atraccionCopada(excursion(Lugar)):-
    atom_length(Lugar, CantLetras),
    CantLetras > 7.

atraccionCopada(parqueNacional(_)).

noSeCruzaron(Persona1, Persona2):-
    viajo(Persona1, _),
    viajo(Persona2, _),
    Persona1 \= Persona2,
    not(seCruzaron(Persona1, Persona2)).

seCruzaron(Persona1, Persona2):-
    viajo(Persona1, Destino),
    viajo(Persona2, Destino).

%% 4 %%

costoDeVida(sarmiento,           100).
costoDeVida(esquel,              150).
costoDeVida(pehuenia,            180).
costoDeVida(sanMartinDeLosAndes, 150).
costoDeVida(camarones,           135).
costoDeVida(playasDoradas,       170).
costoDeVida(bariloche,           140).
costoDeVida(calafate,            240).
costoDeVida(elBolson,            145).
costoDeVida(marDelPlata,         140).

vacacionGasolera(Persona):-
    viajo(Persona, _),
    forall(viajo(Persona, Destino), gasolero(Destino)).

gasolero(Destino):-
    costoDeVida(Destino, Costo),
    Costo < 160.


