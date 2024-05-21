import Text.Show.Functions
import Data.List

data Jugador = UnJugador {
  nombre :: String,
  padre :: String,
  habilidad :: Habilidad
} deriving (Eq, Show)

data Habilidad = Habilidad {
  fuerzaJugador :: Int,
  precisionJugador :: Int
} deriving (Eq, Show)

--Ejemplo de jugadores:
bart = UnJugador "Bart" "Homero" (Habilidad 25 60)
todd = UnJugador "Todd" "Ned" (Habilidad 15 80)
rafa = UnJugador "Rafa" "Gorgory" (Habilidad 10 1)

data Tiro = UnTiro {
  velocidad :: Int,
  precision :: Int,
  altura :: Int
} deriving (Eq, Show)

-- 1.a
data Palo = Putter | Madera | Hierros
tiroConPalo :: Jugador -> Palo -> Tiro -> Tiro
tiroConPalo jugador Putter tiro = tiro {
                                    velocidad = 10,
                                    precision = 2 * (precisionJugador . habilidad) jugador,
                                    altura = 0
}