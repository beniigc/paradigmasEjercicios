%% punto1 %%
caracteristicas(harry, [corajudo, amistoso, orgulloso, inteligente]).
caracteristicas(draco, [inteligente, orgulloso]).
caracteristicas(hermione, [inteligente, orgullosa, responsable]).

sangre(harry, mestiza).
sangre(draco, pura).
sangre(hermione, impura).

odiaria(harry, slithering).
odiaria(draco, hufflepuff).

mago(harry).
mago(hermione).
mago(draco).
mago(luna).
mago(ron). 

caracteristicasCasa(hufflepuff, amistoso).
caracteristicasCasa(griffindor, corajudo).
caracteristicasCasa(slithering, orgulloso).
caracteristicasCasa(slithering, inteligente).
caracteristicasCasa(ravenclaw, inteligente).
caracteristicasCasa(ravenclaw, responsable).

esDe(hermione, gryffindor).
esDe(ron, gryffindor).
esDe(harry, gryffindor).
esDe(draco, slytherin).
esDe(luna, ravenclaw).

movimientos(harry, fueraDeLaCama).
movimientos(hermione, tercerPiso).
movimientos(hermione, seccionRestringidaBiblioteca).
movimientos(harry, tercerPiso).
movimientos(harry, bosque).
movimientos(draco, mazmorras).

accion(ron, ganarAjedrezMagico, 50).
accion(hermione, salvarAmigos, 50).
accion(harry, ganarAVoldemort, 60).


permiteEntrar(slithering, Mago):-
    sangre(Mago, Tipo),
    Tipo \= impura.

permiteEntrar(Casa, Mago):-
    caracteristicasCasa(Casa,_),
    mago(Mago),
    Casa \= slithering.

caracterApropiado(Casa, Mago) :-
    mago(Mago),
    forall(caracteristicasCasa(Casa, Caracteristica), tieneCaracteristica(Caracteristica, Mago)).

tieneCaracteristica(Caracteristica, Mago):-
    caracteristicas(Mago, Caracteristicas),
    member(Caracteristica,Caracteristicas).

puedeSerSeleccionado(griffindor, hermione).

puedeSerSeleccionado(Casa, Mago):-
    caracterApropiado(Casa, Mago),
    permiteEntrar(Casa, Mago).

cadenaDeAmistad(ListaDeMagos):-
    forall(member(Mago, ListaDeMagos), tieneCaracteristica(amistoso, Mago)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% parte 2: LA COPA DE LAS CASAS %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

buenAlumno(Mago):-
    accion(Mago,_,_),
    not(realizoMalaAccion(Mago)).

realizoMalaAccion(Mago):-
    movimientos(Mago, Movimiento),
    puntajeMovimiento(Movimiento, Puntaje),
    Puntaje < 0.

puntajeMovimiento(seccionRestringidaBiblioteca, -10).

puntajeMovimiento(bosque, -50).

puntajeMovimiento(tercerPiso, -75).

accionRecurrente(Accion):-
    accion(Mago, Accion,_),
    accion(OtroMago, Accion,_),
    Mago \= OtroMago.

accionRecurrente(Accion):-
    movimientos(Mago, Accion),
    movimientos(OtroMago, Accion),
    Mago \= OtroMago.

puntajeTotalDeCasa(Casa, PuntajeTotalDeCasa):-
    forall(esDe(Mago,Casa), puntajeMago(Mago, Puntaje))

%%aca ya no se me ocurrio como hacerlo bien logico, y ademas no tenia resolucion.
