import Text.Show.Functions
import Data.List

--punto1
data Guantelete = UnGuantelete {
    material :: String,
    gemas :: [Gema]
}deriving (Show)

data Personaje = UnPersonaje{
    nombre :: String,
    edad :: Int,
    energia :: Int,
    habilidades :: [String],
    planeta :: String
}deriving (Show)

type Gema = (Personaje -> Personaje)
type Universo = [Personaje]

chasquear :: Guantelete -> Universo -> Universo
chasquear guantelete universo 
    | tieneX 6 (gemas guantelete) && material guantelete == "uru" = drop mitad universo
    | otherwise                                             = universo
    where
        mitad = div (length universo) 2

tieneX :: Int -> [a] -> Bool
tieneX x lista = (length $ lista) == x

--------
--punto2
--------
pendex :: Universo -> Bool
pendex universo = any (esMenorA 45) universo

esMenorA :: Int -> Personaje -> Bool
esMenorA n personaje = edad personaje < n

energiaTotal :: Universo -> Int
energiaTotal = sum . map energia . filter habilidoso

habilidoso :: Personaje -> Bool
habilidoso personaje = (length $ habilidades personaje) > 1

---------------
--segunda parte
---------------
--------
--punto3
--------

mente :: Int -> Gema 
mente valor personaje = modificarEnergia (subtract valor) personaje

modificarEnergia :: (Int -> Int) -> Personaje -> Personaje
modificarEnergia funcion personaje = personaje {energia = funcion $ energia personaje}

modificarHabilidades :: ([String] -> [String]) -> Personaje -> Personaje
modificarHabilidades funcion personaje = personaje {habilidades = funcion $ habilidades personaje}

alma :: String -> Gema
alma habilidad personaje
    | poseeHabilidad habilidad personaje = modificarEnergia (subtract 10) . eliminarHabilidad habilidad $ personaje
    | otherwise                          = modificarEnergia (subtract 10) personaje

poseeHabilidad :: String -> Personaje -> Bool
poseeHabilidad habilidad personaje = elem habilidad (habilidades personaje)

eliminarHabilidad :: String -> Personaje -> Personaje
eliminarHabilidad habilidad personaje = modificarHabilidades (filter (habilidad /=)) personaje

espacio :: String -> Gema
espacio unPlaneta = transportar unPlaneta . modificarEnergia (subtract 20) 

transportar :: String -> Personaje -> Personaje
transportar unPlaneta personaje = personaje {planeta = unPlaneta}

poder :: Gema
poder personaje
    | tieneX 2 (habilidades personaje) = (exausto . modificarHabilidades (drop 2)) personaje
    | tieneX 1 (habilidades personaje) = (exausto . modificarHabilidades tail ) personaje
    | otherwise                        = exausto personaje

exausto :: Personaje -> Personaje
exausto personaje = modificarEnergia (subtract (energia personaje)) personaje

tiempo :: Gema
tiempo = mitadDeEdad

mitadDeEdad :: Personaje -> Personaje
mitadDeEdad personaje
    | esMenorA 36 personaje = personaje {edad = 18}
    | otherwise             = personaje {edad = (`div` 2) . edad $ personaje}

gemaLoca :: Gema -> Gema
gemaLoca gema personaje = (flip (!!) 2) . iterate (aplicarGema gema) $ personaje

aplicarGema :: Gema -> Personaje -> Personaje
aplicarGema gema = gema

----------
--punto4
----------

guantelete1 = UnGuantelete "goma" [tiempo, alma "usar Mjolnir", gemaLoca (alma "programacion en haskell")]

--------
--punto5
--------

utilizar :: [Gema] -> Personaje -> Personaje
utilizar gemas enemigo = foldr aplicarGema enemigo gemas

---------
--punto6
---------

masPoderosa :: Guantelete -> Personaje -> Gema
masPoderosa guantelete personaje = gemaMasPoderosa (gemas guantelete) personaje

gemaMasPoderosa :: [Gema] -> Personaje -> Gema
gemaMasPoderosa gemas personaje
    | length gemas == 1 = head gemas
    | otherwise = gemaMasPoderosa (listaModificada gemas personaje) personaje 

listaModificada :: [Gema] -> Personaje -> [Gema]
listaModificada (g1 : g2 : gemas) personaje
    | menosEnergetica g1 g2 personaje= listaModificada (g1 : gemas) personaje
    | otherwise                         = listaModificada (g2 : gemas) personaje

menosEnergetica :: Gema -> Gema -> Personaje -> Bool
menosEnergetica g1 g2 personaje = (energia . aplicarGema g1 $ personaje) < (energia . aplicarGema g2 $ personaje)

infinitasGemas :: Gema -> [Gema]
infinitasGemas gema = gema:(infinitasGemas gema)

guanteleteDeLocos :: Guantelete
guanteleteDeLocos = UnGuantelete "vesconite" (infinitasGemas tiempo)

usoLasTresPrimerasGemas :: Guantelete -> Personaje -> Personaje
usoLasTresPrimerasGemas guantelete = (utilizar . take 3. gemas) guantelete

punisher = UnPersonaje "punisher" 45 30 ["correr", "llorar"] "tierra"

----punto 7
{- no s epodria ejecutar debido a que estara comparando y buscando la gema mas poderosa dentro de una lista
infinita 
la otra si se puedo porque solo va a tomar tres de la lisa infinita, no evalua el resto-}