import Text.Show.Functions
import Data.List

--Volver a poner el eq

data Elemento = UnElemento {
    tipo :: String,
    ataque :: (Personaje -> Personaje),
    defensa :: (Personaje -> Personaje)
} 

data Personaje = UnPersonaje {
    nombre :: String,
    salud :: Float,
    elementos :: [Elemento],
    anioPresente :: Int
} deriving (Show)

instance Show Elemento where
  show = tipo

instance Eq Elemento where
    (==) elemento1 elemento2 = tipo elemento1 == tipo elemento2

personaje1 = UnPersonaje{
    nombre = "Jassuo",
    salud = 50.0,
    elementos = [malefico, soporte],
    anioPresente = 1970
}

personaje2 = UnPersonaje{
    nombre = "Katarina",
    salud = 50.0,
    elementos = [soporte],
    anioPresente = 1970
}


malefico = UnElemento{
    tipo = "maldad",
    ataque = causarDanio 1.0,
    defensa = meditar 20
}

soporte = UnElemento{
    tipo = "curacion",
    ataque = causarDanio 24.0,
    defensa = meditar 40
}
--1
--Esta funcion devuelve "<function>" nose porque
mandarAlAnio :: Personaje -> Int -> Personaje
mandarAlAnio (UnPersonaje nombre salud elementos _) anio = UnPersonaje nombre salud elementos anio

meditar :: Float -> Personaje -> Personaje
meditar valor personaje = personaje {salud = salud personaje + (valor /2.0)}

causarDanio :: Float -> Personaje -> Personaje
causarDanio danio personaje
    | danio > salud personaje = personaje {salud = 0}
    | otherwise     = personaje {salud = salud personaje - danio}

--2
darListaTipos :: [Elemento] -> [String]
darListaTipos elementos = map tipo elementos
esMalvado :: Personaje -> Bool
esMalvado (UnPersonaje _ _ elementos _) = (any ("maldad" ==) . darListaTipos) elementos

danioQueProduce :: Personaje -> Elemento -> Float
danioQueProduce personaje elemento = (salud . ataque elemento) personaje

enemigosMortales :: Personaje -> [Personaje] -> [Personaje]
enemigosMortales personaje listaDePersonajes = filter (puedeMatarlo personaje) listaDePersonajes

puedeMatarlo :: Personaje -> Personaje -> Bool
puedeMatarlo personaje1 personaje2 = (any (ataqueMortal personaje1) . elementos) personaje2

ataqueMortal :: Personaje -> Elemento -> Bool
ataqueMortal personaje elemento = 
    danioQueProduce personaje elemento == salud personaje
