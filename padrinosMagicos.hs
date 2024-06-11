import Text.Show.Functions
import Data.List

-------
--A
--------

data Chico = Chico {
    nombre :: String,
    edad :: Int,
    habilidades :: [Habilidad],
    deseos :: [Deseo]
}deriving (Show)

type Habilidad = String

type Deseo = (Chico -> Chico) 

timmy = Chico "Timmy" 10 ["mirar television","jugar en la pc"] [serMayor]

modificarHabilidades :: ([String] -> [String]) -> Chico -> Chico
modificarHabilidades funcion chico = chico {habilidades = funcion $ habilidades chico}

modificarEdad :: (Int -> Int) -> Chico -> Chico
modificarEdad funcion chico = chico {edad = funcion $ edad chico}

agregarHabilidades :: [Habilidad] -> Chico -> Chico
agregarHabilidades habilidades = modificarHabilidades (habilidades ++)

--a
aprenderHabilidades :: [Habilidad] -> Deseo
aprenderHabilidades habilidades = agregarHabilidades habilidades

--b

serGrosoEnNeedForSpeed :: Deseo
serGrosoEnNeedForSpeed = agregarHabilidades todosLosNFP 

todosLosNFP :: Int -> [Habilidad]
todosLosNFP = "jugar need for" : [todosLosNFP n+1]


--c

serMayor :: Deseo
serMayor = modificarEdad (const 18)

--2
--a
type Padrino = (Chico -> Chico)

wanda :: Padrino
wanda = madurar . cumplirPrimerDeseo

cumplirPrimerDeseo :: Chico -> Chico
cumplirPrimerDeseo chico = cumplirDeseo (head $ deseos chico) chico

cumplirDeseo :: Deseo -> Chico -> Chico
cumplirDeseo deseo = deseo 

madurar :: Chico -> Chico
madurar = modificarEdad (+ 1)

--b
cosmo :: Padrino
cosmo = desmadurar

desmadurar :: Chico -> Chico
desmadurar chico = modificarEdad (const (mitad $ edad chico)) chico

mitad :: Int -> Int
mitad a = (div a 2)

--c
muffinMagico :: Padrino
muffinMagico chico = foldr cumplirDeseo chico (deseos chico)

-----
--B
-----
--1
type Condicion = (Chico -> Bool)

tieneHabilidad :: Habilidad -> Condicion
tieneHabilidad unaHabilidad = elem unaHabilidad . habilidades

esSuperMaduro :: Condicion
esSuperMaduro chico = esMayor && tieneHabilidad "manejar" chico where esMayor = edad chico > 18

--2

data Chica = Chica{
    nombreChica :: String,
    condicion :: Condicion
}deriving (Show)


trixie = Chica "Trixie Tang" noEsTimmy
vicky = Chica "Vicky" (tieneHabilidad "ser un supermodelo noruego")

noEsTimmy :: Condicion
noEsTimmy = ("timmy" == ) . nombre

--a

quienConquistaA :: Chica -> [Chico] -> Chico
quienConquistaA chica = buscarPretendiente chica 

buscarPretendiente :: Chica -> [Chico] -> Chico
buscarPretendiente chica pretendientes
    | algunoCumpleCondicion = encontrarPretendiente chica pretendientes
    | otherwise             = last pretendientes
    where
        algunoCumpleCondicion = any (condicion chica) pretendientes
    
encontrarPretendiente :: Chica -> [Chico] -> Chico
encontrarPretendiente chica (chico1 : chicos)
    | condicion chica $ chico1 = chico1
    | otherwise                = encontrarPretendiente chica (chicos)

--b

sara = Chica "sara" (tieneHabilidad "sabe cocinar")


-----
--C
-----

infractoresDeDaRules :: [Chico] -> [String]
infractoresDeDaRules = map nombre . filter tieneDeseosProhibidos 

tieneDeseosProhibidos :: Chico -> Bool
tieneDeseosProhibidos chico = any (esDeseoProhibido chico) (deseos chico)

esDeseoProhibido :: Chico ->  Deseo -> Bool
esDeseoProhibido chico deseo = (any esHabilidadProhibida . take 5 . habilidades . deseo) chico 

esHabilidadProhibida :: Habilidad -> Bool
esHabilidadProhibida habilidad = elem habilidad habilidadesProhibidas

habilidadesProhibidas :: [Habilidad]
habilidadesProhibidas = ["enamorar", "matar", "dominar el mundo"]

