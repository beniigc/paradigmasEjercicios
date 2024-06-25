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

-- 1.b

palos :: [Palo]
palos = [Putter, Madera, Hierros]

-- 2
{-CORRECCION: aca los palos directamente los hizo una funcion que recibe una habilidad y genera un tiro
entronces la funcion golpe solo era golpe jugador palo = palo (habilidad jugador) y para mostrarlos, hizo:
palos :: [palo] palos = [putter, madera] ++ map hierro [1..10]-}

golpe :: Jugador -> Palo -> Tiro  
golpe jugador Putter = UnTiro {
                              velocidad = 10,
                              precision = doblePrecision jugador,
                              altura = 0 }
golpe jugador Madera = UnTiro {
                              velocidad = 100,
                              precision =  mitadPrecision jugador,
                              altura = 5 }
golpe jugador Hierros = UnTiro {
                              velocidad = 100,
                              precision =  mitadPrecision jugador,
                              altura = 5 }        

-- 3
{--CORRECCION: aca hizo funciones de tipo tiro -> tiro para cada obtstaculo y cada una tenia una funcion de superar
y de aplicar el efecto del obstaculo al tiro-}

podraSuperarObstaculo :: Obstaculo -> Tiro -> Bool
podraSuperarObstaculo Tunel tiro = (altura tiro == 0) && (precision tiro > 90)
podraSuperarObstaculo Laguna tiro = (velocidad tiro > 80) && alturaTiroEntre1Y5 tiro
podraSuperarObstaculo Hoyo tiro = (altura tiro == 0) && velocidadTiroEntre5y20 tiro && (precision tiro >95)

--esta es la funcion bewtween

velocidadTiroEntre5y20 tiro = velocidad tiro > 5 && velocidad tiro < 20
alturaTiroEntre1Y5 tiro = altura tiro > 1 && altura tiro < 5


tiroLuegoDeObstaculo :: Obstaculo -> Tiro -> Tiro
tiroLuegoDeObstaculo UnObstaculo UnTiro 
  | podraSuperarObstaculo UnObstaculo UnTiro = aplicarObstaculo UnObstaculo UnTiro
  | otherwise UnTiro = 0 0 0

aplicarObstaculo :: Obstaculo -> Tiro
aplicarObstaculo Tunel tiro = { velocidad = 2 * velocidad tiro, precision = 3 * precision tiro, altura = 0}
aplicarObstaculo Laguna tiro = { velocidad = 2 * velocidad tiro, precision = 3 * precision tiro, altura = 0}