atiende(dodain, lunes, 9, 15).
atiende(dodain, miercoles, 9, 15).
atiende(dodain, viernes, 9, 15).
atiende(lucas, martes, 10, 20).
atiende(juanC, sabados, 18, 22).
atiende(juanC, domingos, 18, 22).
atiende(juanFdS, jueves, 10, 20).
atiende(juanFdS, viernes, 12, 20).
atiende(leoC, miercoles, 14, 18).
atiende(leoC, lunes, 14, 18).
atiende(martu, miercoles, 23, 24).
atiende(vale, sabados, 18, 22).
atiende(vale, domingos, 18, 22).
atiende(vale, lunes, 9, 15).
atiende(vale, miercoles, 9, 15).
atiende(vale, viernes, 9, 15).

%% atiende(vale, Dia, HorarioInicio, HorarioFinal):-
%%   atiende(dodain, Dia, HorarioInicio, HorarioFinal).
%% atiende(vale, Dia, HorarioInicio, HorarioFinal):-
%%   atiende(juanC, Dia, HorarioInicio, HorarioFinal).

%%no se pone el horario que nadie hace por el concepto de universo cerrado, en el que todo aquello que no se contempla en el codigo es falso.
%%%%%%%%%%
%%punto2%%
%%%%%%%%%%

quienAtiende(Dia, Hora, Nombre):-
    atiende(Nombre, Dia, PrimeraHora, UltimaHora),
    between(PrimeraHora, UltimaHora, Hora).

%%%%%%%%%%
%%punto3%%
%%%%%%%%%%

foreverAlone(Persona,Dia,Horario):-
    atiende(Persona,Dia,_,_),
    atiende(OtraPersona,Dia,_,_),
    Persona \= OtraPersona,
    quienAtiende(Dia,Horario,Persona),
    not(quienAtiende(Dia,Horario,OtraPersona)).



