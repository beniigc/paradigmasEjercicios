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
/* 
foreverAlone(Dia,Horario,Persona):-
    atiende(Persona,_,_,_),
    atiende(OtraPersona,_,_,_),
    quienAtiende(Dia,Horario,Persona),
    not(quienAtiende(Dia,Horario,OtraPersona)),
    Persona \= OtraPersona. 
Esta solucion estaba bien pero quedaba mas corta y mejor la de abajo, en donde dentro de la consulta de quienAtiene con OtraPersona ya le
aclaramos que OtraPersona es distinta a Persona, dentro del not
*/

foreverAlone(Persona, Dia, HorarioPuntual):-
  quienAtiende(Persona, Dia, HorarioPuntual),
  not((quienAtiende(OtraPersona, Dia, HorarioPuntual), Persona \= OtraPersona)).

%%%%%%%%%%
%%punto4%%
%%%%%%%%%%

posibilidadesDeAtencion(Dia, Atendedores):-
    atiende(Persona, Dia, _, _),
    findall(Persona, quienAtiende(Dia,_, Persona), Atendedores).

%% Este punto era raro

%%%%%%%%%%
%%punto5%%
%%%%%%%%%%

%% venta(nombre,dia,mes,venta).
venta(dodain, 10, agosto, golosina(1200)).
venta(dodain, 10, agosto, cigarrillos(jockey)).
venta(dodain, 10, agosto, golosina(50)).
venta(dodain, 12, agosto, bebida(alcholicas,8)).
venta(dodain, 12, agosto, bebida(noAlcholicas,1)).
venta(dodain, 12, agosto, golosina(10)).
venta(martu, 12, agosto, golosina(1000)).
venta(martu, 12, agosto, cigarrillos(chesterfield)).
venta(martu, 12, agosto, cigarrillos(colorado)).
venta(martu, 12, agosto, cigarrillos(parisiennes)).
venta(lucas, 11, agosto, golosina(600)).
venta(lucas, 18, agosto, bebida(noAlcholicas,2)).
venta(lucas, 18, agosto, cigarrillos(derby)).

