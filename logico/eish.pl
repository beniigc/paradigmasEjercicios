jugador(ana).
jugador(beto).
jugador(carola).
jugador(dimitri).

civilizacion(ana, romanos).
civilizacion(beto, incas).
civilizacion(carola, romanos).
civilizacion(dimitri, romanos).

tecnologia(herreria).
tecnologia(forja).
tecnologia(emplumado).
tecnologia(laminas).
tecnologia(fundicion).

tecnologias(ana, [herreria, forja, emplumado, laminas]).
tecnologias(beto, [herreria, forja, fundicion]).
tecnologias(carola, [herreria]).
tecnologias(dimitri, [herreria, fundicion]).

% Saber si un jugador es experto en metales, que sucede cuando desarrolló las tecnologías de herrería, forja y o bien desarrolló fundición o bien juega con los romanos.

herreroForjador(Jugador) :-
    jugador(Jugador),
    tecnologias(Jugador, Tecnologias),
    member(herreria, Tecnologias),
    member(forja, Tecnologias).

expertoEnMetales(Jugador) :-
    herreroForjador(Jugador),
    tecnologias(Jugador, Tecnologias),
    member(fundicion, Tecnologias).

expertoEnMetales(Jugador) :-
    herreroForjador(Jugador),
    civilizacion(Jugador, romanos).

% Saber si una civilización es popular, que se cumple cuando la eligen varios jugadores (más de uno).

mismaCivilizacion(Jugador1, Jugador2, Civilizacion) :-
    civilizacion(Jugador1, Civilizacion),
    civilizacion(Jugador2, Civilizacion).

civiPopular(Civilizacion) :-
    jugador(Jugador1),
    jugador(Jugador2),
    Jugador1 \= Jugador2,
    mismaCivilizacion(Jugador1, Jugador2, Civilizacion).

% Saber si una tecnología tiene alcance global, que sucede cuando a nadie le falta desarrollarla.

laTiene(Tecnologia, Jugador) :-
    tecnologias(Jugador, Tecnologias),
    member(Tecnologia, Tecnologias).

alcanceGlobal(Tecnologia) :-
    tecnologia(Tecnologia),
    forall(jugador(Jugador), laTiene(Tecnologia, Jugador)).
    
% Saber cuándo una civilización es líder. Se cumple cuando esa civilización alcanzó todas las tecnologías que alcanzaron las demás. 
% Una civilización alcanzó una tecnología cuando algún jugador de esa civilización la desarrolló.

algunoLaTiene(Tecnologia, Civilizacion) :-
    civilizacion(Jugador, Civilizacion),
    laTiene(Tecnologia,Jugador).

esLider(Civilizacion) :-
    civilizacion(_ ,Civilizacion),
    forall(tecnologia(Tecnologia), algunoLaTiene(Tecnologia, Civilizacion)).

% parte 2
campeon().
jinete(caballo).
jinete(camello).
piqueros()


unidades(ana, [])
conocerVida(Jugador) :-
unidades(Jugador, UnidadesDeJugador),
forall()