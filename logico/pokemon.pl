pokemon(pikachu, electrico).
pokemon(charizard, fuego).
pokemon(venusaur, planta).
pokemon(blastoise, agua).
pokemon(tododile, agua).
pokemon(snorlax, normal).
pokemon(rayquaza, dragon).
pokemon(rayquaza, volador).
pokemon(arceus, _).

entrenador(ash, [pikachu, charizard]).
entrenador(brock, [snorlax]).
entrenador(misty, [blastoise, venusaur, arceus]).

%%% parte 1 %%%
tipoMultiple(Pokemon):-
    pokemon(Pokemon, Tipo1),
    pokemon(Pokemon, Tipo2),
    Tipo1 \= Tipo2.

legendario(Pokemon):-
    tipoMultiple(Pokemon),
    nadieLoTiene(Pokemon).

nadieLoTiene(Pokemon):-
    forall(entrenador(Entrenador, _), not(tienePokemon(Entrenador, Pokemon))).

tienePokemon(Entrenador, Pokemon):-
    entrenador(Entrenador, Pokedex),
    member(Pokemon, Pokedex).

misterioso(Pokemon):-
    pokemon(Pokemon, Tipo1),
    forall((pokemon(Pokemon2, Tipo2), Pokemon2 \= Pokemon), Tipo2 \= Tipo1),
    not(algunEntrenadorTiene(Pokemon)).

algunEntrenadorTiene(Pokemon):-
    entrenador(_, Pokedex),
    not(member(Pokemon, Pokedex)).

%%%% PARTE 2 %%%%

movimiento(pikachu, mordedura, fisico(95)).
movimiento(pikachu, impactrueno, especial(40, electrico)).
movimiento(charizard, garraDragon, especial(100, dragon)).
movimiento(charizard, mordedura, fisico(95)).
movimiento(blastoise, proteccion, defensivo(10)).
movimiento(blastoise, placaje, fisico(50)).
movimiento(arceus, impactrueno, especial(40, electrico)).
movimiento(arceus, garraDragon, especial(100, dragon)).
movimiento(arceus, proteccion, defensivo( 10)).
movimiento(arceus, placaje, fisico( 50)).
movimiento(arceus, alivio, defensivo(100)).


%% 1 %%
danioDeAtaque(Movimiento, Danio):-
    movimiento(_, Movimiento, fisico(Danio)).

danioDeAtaque(Movimiento, Danio):-
    movimiento(_, Movimiento, defensivo(_)),
    Danio is 0.

danioDeAtaque(Movimiento, Danio):-
    movimiento(_, Movimiento, especial(Potencial, dragon)),
    Danio is Potencial * 3.

danioDeAtaque(Movimiento, Danio):-
    movimiento(_, Movimiento, especial(Potencial, Tipo)),
    basico(Tipo),
    Danio is Potencial * (1.5).

danioDeAtaque(Movimiento, Danio):-
    movimiento(_, Movimiento, especial(_, Tipo)),
    not(basico(Tipo)),
    Tipo \= dragon,
    Danio is 1.

basico(fuego).
basico(agua).
basico(planta).
basico(normal).
%% TODO: sacar la repeticion de logica, hacer una funcion obtener datos

capacidadOfensiva(Pokemon, Capacidad):-  
    findall(Danio, danioDeAtaquePokemon(Pokemon, Danio), DaniosDeAtaque),
    sumlist(DaniosDeAtaque, Capacidad).

danioDeAtaquePokemon(Pokemon, Danio):-
    movimiento(Pokemon, Movimiento, _),
    danioDeAtaque(Movimiento, Danio).

picante(Entrenador):-
    entrenador(Entrenador, Pokedex),
    forall(member(Pokedex, Pokemon), pokemonPicante(Pokemon)).

%% y aca haces los dos casos para los cuales un pokemon es picante