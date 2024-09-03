esPersonaje(aang).
esPersonaje(katara).
esPersonaje(zoka).
esPersonaje(appa).
esPersonaje(momo).
esPersonaje(toph).
esPersonaje(tayLee).
esPersonaje(zuko).
esPersonaje(azula).
esPersonaje(iroh).
esPersonaje(bumi).
esPersonaje(suki).

esElementoBasico(fuego).
esElementoBasico(agua).
esElementoBasico(tierra).
esElementoBasico(aire).

elementoAvanzadoDe(fuego, rayo).
elementoAvanzadoDe(agua, sangre).
elementoAvanzadoDe(tierra, metal).

controla(zuko, rayo).
controla(toph, metal).
controla(katara, sangre).
controla(aang, aire).
controla(aang, agua).
controla(aang, tierra).
controla(aang, fuego).
controla(azula, rayo).
controla(iroh, rayo).
controla(bumi, tierra).

% reinoTierra(nombreDelLugar, estructura)
% nacionDelFuego(nombreDelLugar, soldadosQueLoDefienden)
% tribuAgua(puntoCardinalDondeSeUbica)
% temploAire(puntoCardinalDondeSeUbica)

visito(aang, reinoTierra(baSingSe, [muro, zonaAgraria, sectorBajo, sectorMedio])).
visito(iroh, reinoTierra(baSingSe, [muro, zonaAgraria, sectorBajo, sectorMedio])).
visito(zuko, reinoTierra(baSingSe, [muro, zonaAgraria, sectorBajo, sectorMedio])).
visito(toph, reinoTierra(fortalezaDeGralFong, [cuartel, dormitorios, enfermeria, salaDeGuerra, templo, zonaDeRecreo])).
visito(aang, nacionDelFuego(palacioReal, 1000)).
visito(katara, tribuAgua(norte)).
visito(katara, tribuAgua(sur)).
visito(aang, temploAire(norte)).
visito(aang, temploAire(oeste)).
visito(aang, temploAire(este)).
visito(aang, temploAire(sur)).
visito(bumi, reinoTierra(baSingSe, [muro, zonaAgraria, sectorBajo, sectorMedio])).
visito(suki, nacionDelFuego(prisionDeMaximaSeguridad, 200)).

lugar(Lugar):-
    visito(_, Lugar).

%% 1 %%
esElAvatar(Personaje):-
    esPersonaje(Personaje),
    forall(esElementoBasico(Elemento), controla(Personaje, Elemento)).

%% 2 %%

controlaElementoBasico(Personaje):-
    controla(Personaje, Elemento),
    esElementoBasico(Elemento).

controlaElementoAvanzado(Personaje):-
    controla(Personaje, Elemento),
    elementoAvanzadoDe(_, Elemento).

noEsMaestro(Personaje):-
    esPersonaje(Personaje),
    not(controlaElementoBasico(Personaje)),
    not(controlaElementoAvanzado(Personaje)).

esMaestroPrincipiante(Personaje):-
    esPersonaje(Personaje),
    controlaElementoBasico(Personaje),
    not(controlaElementoAvanzado(Personaje)).

esMaestroAvanzado(Personaje):-
    esPersonaje(Personaje),
    controlaElementoAvanzado(Personaje).

esMaestroAvanzado(Personaje):-
    esElAvatar(Personaje).

%% 3 %%
sigueA(Personaje1, Personaje2):-
    esPersonaje(Personaje1),
    esPersonaje(Personaje2),
    Personaje1 \= Personaje2,
    lugaresVisitados(Personaje1, Lugares),
    visitoLugares(Personaje2, Lugares).

lugaresVisitados(Personaje, Lugares):-
    findall(Lugar, visito(Personaje, Lugar), Lugares).

visitoLugares(Personaje, Lugares):-
    forall(member(Lugar, Lugares), visito(Personaje, Lugar)).

/*mas facil era esto:
sigueA(Personaje, Seguidor) :-
    esPersonaje(Personaje),         
    esPersonaje(Seguidor),
    Personaje \= Seguidor,
    forall(visito(Personaje, Lugar), visito(Seguidor, Lugar)).

sigueA(zuko, aang).*/

%% TODO: arreglar esto porque es si tienen exactamente los mismos lugares

%% 4 %%
esDignoDeConocer(Lugar):-
    lugar(Lugar),
    digno(Lugar).

digno(temploAire(_)).

digno(tribuAgua(norte)).

digno(reinoTierra(Estructuras)):-
    not(member(Estructuras, muro)).

%% 5 %%
esPopular(Lugar):-
    findall(Personaje, visito(Personaje, Lugar), Visitantes),
    length(Visitantes, 4).

%% 6 %%
% se aniadio a la base de conocimientos :)