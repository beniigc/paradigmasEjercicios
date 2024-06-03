import Text.Show.Functions
import Data.List

data Jugador = UnJugador {
    nombre :: String,
    edad :: Int,
    promedioGol :: Float,
    habilidad :: Int,
    cansancio :: Float
}deriving (Show, Eq)

data Equipo = UnEquipo {
    nombreEquipo :: String,
    grupo :: Char,
    listaJugadores :: [Jugador]
} deriving (Show)

martin :: Jugador
martin = UnJugador "Martin" 26 0.0 50 35.0
juan :: Jugador
juan = UnJugador "Juancho" 30 0.2 50 40.0
maxi :: Jugador
maxi = UnJugador "Maxi Lopez" 27 0.4 68 30.0

jonathan = UnJugador "Chueco" 20 1.5 80 99.0
lean = UnJugador "Hacha" 23 0.01 50 35.0
brian = UnJugador "Panadero" 21 5 80 15.0

garcia = UnJugador "Sargento" 30 1 80 13.0
messi = UnJugador "Pulga" 26 10 99 43.0
aguero = UnJugador "Aguero" 24 5 90 5.0
icardi = UnJugador "icardi" 25 6 75 9.0
caniggia = UnJugador "cannigia" 30 9 90 14.0
demichelis = UnJugador "demichelis" 34 9 90 10.0


equipo1 = UnEquipo "Lo Que Vale Es El Intento" 'F' [martin, juan, maxi]
losDeSiempre = UnEquipo "Los De Siempre" 'F' [jonathan, lean, brian]
restoDelMundo = UnEquipo "Resto del Mundo" 'A' [garcia, messi, aguero]

figuras :: Equipo -> [Jugador]
figuras equipo = filter esFigura (listaJugadores equipo)

esFigura :: Jugador -> Bool
esFigura jugador = (habilidad jugador > 75) && (promedioGol jugador > 0)

--punto 2

tieneFarandulero :: Equipo -> Bool
tieneFarandulero equipo = any (esFarandulero) (listaJugadores equipo)

esFarandulero :: Jugador -> Bool
esFarandulero jugador = elem jugador jugadoresFaranduleros

jugadoresFaranduleros :: [Jugador]
jugadoresFaranduleros = [maxi, icardi, aguero, caniggia, demichelis]
--hacer a icardi cannigia demichelis 

--punto 3
figuritasDificiles :: Equipo -> [Jugador]
figuritasDificiles equipo = filter esDificil (listaJugadores equipo)

esDificil :: Jugador -> Bool
esDificil jugador = (esFigura jugador) && (esJoven jugador) && (not (esFarandulero jugador))

esJoven :: Jugador -> Bool
esJoven jugador = (edad jugador) < 27


--pUnto 4
jugarPartido :: Jugador -> Jugador
jugarPartido jugador
    | esDificil jugador = jugador {cansancio = 50}
    | esJoven jugador = jugador {cansancio = cansancio jugador * 1.10}
    | esFigura jugador = jugador {cansancio = cansancio jugador + 20}
    | otherwise        = jugador {cansancio = cansancio jugador * 2}

equipoJuegaPartido :: Equipo -> Equipo
equipoJuegaPartido equipo = equipo {listaJugadores = map (jugarPartido) (listaJugadores equipo)}

equipoGanador :: Equipo -> Equipo -> Equipo
equipoGanador equipo1 equipo2
    | gana equipo1 equipo2 = equipo1
    | gana equipo2 equipo1 = equipo2

gana :: Equipo -> Equipo -> Bool
gana equipo1 equipo2 = promedioDe11MenosCansados equipo1 < promedioDe11MenosCansados equipo2

promedioDe11MenosCansados :: Equipo -> Float
promedioDe11MenosCansados equipo = (sum . listaPromedios . listaMenosCansados . listaJugadores . equipoJuegaPartido) $ equipo

listaPromedios :: [Jugador] -> [Float]
listaPromedios jugadores = map (promedioGol) (jugadores)

listaMenosCansados :: [Jugador] -> [Jugador]
listaMenosCansados jugadores = drop 11 (quickSort (estaMenosCansado) jugadores)

estaMenosCansado :: Jugador -> Jugador -> Bool
estaMenosCansado jugador1 jugador2 = cansancio jugador1 < cansancio jugador2

quickSort :: (a -> a -> Bool) -> [a] -> [a]
quickSort _ [] = [] 
quickSort criterio (x:xs) = (quickSort criterio . filter (not . criterio x)) xs ++ [x] ++ (quickSort criterio . filter (criterio x)) xs

    
{-
--completar esta funcion

--punto 6
campeonTorneo :: [Equipo] -> Equipo
campeonTorneo ([] : equipo) = equipo
campeonTorneo (equipo1 : equipo2 : equipos) = campeonTorneo ((ganador equipo1 equipo2) : equipos)

--punto 7
-}
