import Text.Show.Functions
import Data.List

--isInfix

data Alfajor = UnAlfajor{
    nombre :: String,
    capasDeRelleno :: [String],
    peso :: Float,
    dulzorInnato :: Float
}deriving (Show)

jorgito = UnAlfajor "Jorgito" ["Dulce de leche"] 80.0 8.0
havanna = UnAlfajor "Havanna" ["mousse","mousse"] 60.0 12.0
capitanDelEspacio = UnAlfajor "capitanDelEspacio" ["Dulce de leche"] 40.0 12.0

--a
coeficiente :: Alfajor -> Float
coeficiente alfajor = (dulzorInnato alfajor) / (peso alfajor)
--b
precioAlfajor :: Alfajor -> Float
precioAlfajor alfajor = ((peso alfajor +) . sum . listaPreciosRelleno . capasDeRelleno) alfajor

listaPreciosRelleno :: [String] -> [Float]
listaPreciosRelleno capas = map precioCapa capas

precioCapa :: String -> Float
precioCapa capa  
    | capa == "Dulce de leche" = 12.0
    | capa == "mousse"         = 15.0
    | capa == "fruta"          = 10.0
    | otherwise                = 0.0
--c
esPotable :: Alfajor -> Bool
esPotable alfajor = not (null (capasDeRelleno alfajor)) && (todosIguales (capasDeRelleno alfajor)) && ((dulzorInnato alfajor) >= 0.1)

todosIguales :: Eq a => [a] -> Bool
todosIguales [] = True
todosIguales (x:xs) = all (x ==) xs && todosIguales (xs)

abaratar :: Alfajor -> Alfajor
abaratar alfajor = alfajor{
                            peso = reducirAspecto peso alfajor 10,
                            dulzorInnato = reducirAspecto dulzorInnato alfajor 7
}

reducirAspecto :: (Alfajor -> Float) -> Alfajor -> Float -> Float
reducirAspecto aspecto alfajor numero = (aspecto alfajor) - numero

renombrar :: String -> Alfajor -> Alfajor
renombrar nombreNuevo alfajor = alfajor {nombre = nombreNuevo}

hacerPremium :: Alfajor -> Alfajor
hacerPremium alfajor
    | esPotable alfajor = alfajor {
                                    capasDeRelleno = head (capasDeRelleno alfajor) : capasDeRelleno alfajor,
                                    nombre = nombre alfajor ++ " premium"
    }
    | otherwise         = alfajor

hacerPremiumGrado :: Int -> Alfajor -> Alfajor
hacerPremiumGrado 1 alfajor = hacerPremium alfajor
hacerPremiumGrado grado alfajor = hacerPremiumGrado (grado - 1) . hacerPremium $ alfajor 

jorgitito :: Alfajor 
jorgitito = abaratar jorgito

jorgelin :: Alfajor
jorgelin = (renombrar "jorgelin") . hacerPremium $ jorgito

capitanDelEspacioCostaACosta :: Alfajor
capitanDelEspacioCostaACosta = (renombrar "capitanDelEspacioCostaACosta") . (hacerPremiumGrado 4) . abaratar $ capitanDelEspacio

type Criterio = (Alfajor -> Bool)
data Cliente = UnCliente{
    nombreCliente :: String,
    plata :: Float,
    criterios :: [Criterio],
    listaAlfajores :: [Alfajor]
}deriving (Show)

emi = UnCliente "Emi" 120.0 [(buscaMarca "capitanDelEspacio")] []
tomi = UnCliente "Tomi" 100.0 [pretencioso , dulcero] []
dante = UnCliente "Dante" 200.0 [anti "Dulce de leche", extranio] []
juan = UnCliente "Juan" 500.0 [(buscaMarca "jorgito"), pretencioso, anti "mouse"] []

buscaMarca :: String -> Alfajor -> Bool
buscaMarca marca alfajor = marca == nombre alfajor

pretencioso :: Alfajor -> Bool
pretencioso alfajor = isInfixOf "premium" (nombre alfajor)

dulcero :: Alfajor -> Bool
dulcero alfajor = dulzorInnato alfajor > 0.15

anti :: String -> Alfajor -> Bool
anti capa alfajor = not . elem capa . capasDeRelleno $ alfajor

extranio :: Alfajor -> Bool
extranio alfajor = not (esPotable alfajor) 


leGusta :: Cliente -> [Alfajor] -> [Alfajor]
leGusta cliente alfajores = filter (cumpleCriteriosCLiente (criterios cliente)) alfajores

cumpleCriteriosCLiente :: [Criterio] -> Alfajor -> Bool
cumpleCriteriosCLiente criterios alfajor = all (cumpleCriterio alfajor) criterios

cumpleCriterio :: Alfajor -> Criterio -> Bool
cumpleCriterio alfajor criterio = aplicarCriterio criterio alfajor == True

aplicarCriterio :: Criterio -> Alfajor -> Bool
aplicarCriterio criterio alfajor= criterio alfajor

comprarAlfajor :: Cliente -> Alfajor -> Cliente
comprarAlfajor cliente alfajor 
    | precioAlfajor alfajor < plata cliente =  agregarAlfajor alfajor . (modificarPlataCliente ((precioAlfajor alfajor) +)) $ cliente
    | otherwise = cliente

agregarAlfajor :: Alfajor -> Cliente -> Cliente
agregarAlfajor alfajor cliente = cliente {listaAlfajores = alfajor : listaAlfajores cliente}

modificarPlataCliente :: (Float -> Float) -> Cliente -> Cliente
modificarPlataCliente funcion cliente = cliente {plata = funcion (plata cliente)}

