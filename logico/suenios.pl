%%%% base de conocimientos
suenio(gabriel, ganarLoteria([5,9])).
suenio(gabriel, futbolista(arsenal)).
suenio(juan, cantante(100000)).
cantante(10000).

dificultad(cantante(DiscosVendidos), 6):-
    DiscosVendidos > 500000.
dificultad(ganarLoteria(ListaDeNumeros), Dificultad):-
    length(ListaDeNumeros, CantNumerosApostados),
    Dificultad is 10 * CantNumerosApostados.
dificultad(futbolista(arsenal), 3).
dificultad(futbolista(aldosivi), 3).
dificultad(futbolista(_), 16).
