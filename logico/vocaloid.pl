%% BASE DE CONOCIMIENTO
vocaloid(megurineLuka, cancion(nightFever, 4)).
vocaloid(megurineLuka, cancion(foreverYoung, 5)).
vocaloid(hatsuneMiku, cancion(tellYourWorld, 4)).
vocaloid(gumi, cancion(tellYourWorld, 5)).
vocaloid(gumi, cancion(foreverYoung, 4)).
vocaloid(seeU, cancion(novemberRain, 6)).
vocaloid(seeU, cancion(nightFever, 5)).

cantante(megurineLuka).
cantante(hatsuneMiku).
cantante(gumi).
cantante(seeu).

%%%%% PUNTO 1 %%%%%%
%% 1.
novedoso(Cantante):-
    cantante(Cantante),
    sabeMinimoXCanciones(Cantante, 2),
    tiempoTotalCanciones(Cantante, Tiempo),
    Tiempo < 15.

tiempoTotalCanciones(Cantante, Tiempo):-
    findall(Duracion, vocaloid(Cantante, cancion(_, Duracion)), Duraciones),
    sumlist(Duraciones, Tiempo).
    
sabeMinimoXCanciones(Cantante, NumeroDeCanciones):-
    findall(Cancion, vocaloid(Cantante, cancion(Cancion,_)), Canciones),
    length(Canciones, CantidadCaciones),
    CantidadCaciones > NumeroDeCanciones.

%% 2.
acelerado(Cantante):-
    cantante(Cantante),
    not(tieneCancionDeDuracionMayor(Cantante, 4)).

tieneCancionDeDuracionMayor(Cantante, DuracionMinima):-
    vocaloid(Cantante, cancion(_, Duracion)),
    Duracion > DuracionMinima.

%% CONCIERTOS

%%concierto(nombre, lugar, fama)
concierto(mikuExpo, eeuu, 200).
concierto(magicalMirai, japon, 3000).
concierto(vocaletVision, eeuu, 1000).
concierto(mikuFest, argentina, 100).

%% gigante(cantidadCanciones, tiempo)
tipoConcierto(mikuExpo, gigante(2, 6)).
tipoConcierto(magicalMirai, gigante(3, 10)).
tipoConcierto(vocaletVision, pequenio(9)).
tipoConcierto(mikuFest, gigante(1,4)).

puedeParticipar(Cantante, Concierto):-
    cantante(Cantante),
    concierto(Concierto,_,_),
    tipoConcierto(Concierto, gigante(Canciones, DuracionMinima)),
    tiempoTotalCanciones(Cantante, Tiempo),
    Tiempo > DuracionMinima,
    sabeMinimoXCanciones(Cantante, Canciones).

puedeParticipar(Cantante, Concierto):-
    cantante(Cantante),
    concierto(Concierto,_,_),
    tipoConcierto(Concierto, pequenio(DuracionMinima)),
    tieneCancionDeDuracionMayor(Cantante, DuracionMinima).


