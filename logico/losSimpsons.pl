padreDe(abe, abbie).
padreDe(abe, homero).
padreDe(abe, herbert).
padreDe(clancy, marge).
padreDe(clancy, patty).
padreDe(clancy, selma).
padreDe(homero, bart).
padreDe(homero, hugo).
padreDe(homero, lisa).
padreDe(homero, maggie).

madreDe(edwina, abbie).
madreDe(mona, homero).
madreDe(gaby, herbert).
madreDe(jacqueline, marge).
madreDe(jacqueline, patty).
madreDe(jacqueline, selma).
madreDe(marge, bart).
madreDe(marge, hugo).
madreDe(marge, lisa).
madreDe(marge, maggie).
madreDe(selma, ling).

tieneHijo(Padre):-
    padreDe(Padre, _).

medioHermanos(Hijo1, Hijo2):-
    madreDe(Madre , Hijo1),
    madreDe(Madre, Hijo2),
    Madre = Madre.

medioHermanos(Hijo1, Hijo2):-
    padreDe(Padre , Hijo1),
    padreDe(Padre, Hijo2),
    Padre = Padre.

hermanos(Hijo1, Hijo2):-
    padreDe(Padre , Hijo1),
    padreDe(Padre, Hijo2),
    Padre = Padre,
    madreDe(Madre , Hijo1),
    madreDe(Madre, Hijo2),
    Madre = Madre.

tioDe(Tio, Sobrino):-
    madreDe(Madre, Sobrino),
    hermanos(Madre, Tio).

tioDe(Tio, Sobrino):-
    padreDe(Padre, Sobrino),
    hermanos(Padre, Tio).