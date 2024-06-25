import Text.Show.Functions
import Data.List

data Plomero = UnPlomero {
    nombreP :: String,
    herramientas :: [Herramienta],
    reparaciones :: [Reparacion],
    dinero :: Float
}deriving (Show)

data Herramienta = UnaHerramienta {
    nombreH :: String,
    precio :: Float,
    material :: Material
}deriving (Show)

data Material = Hierro | Madera | Goma | Plastico deriving (Show, Eq)

---------
--punto1
---------

mario = UnPlomero "Mario" [llaveInglesa, martillo] [] 1200.0
wario = UnPlomero "Wario" (infinitasLlavesFrancesas 1.0) [] 0.50

llaveInglesa = UnaHerramienta "Llave inglesa" 200.0 Hierro
martillo = UnaHerramienta "martillo" 20.0 Madera

infinitasLlavesFrancesas :: Float -> [Herramienta]
infinitasLlavesFrancesas n = UnaHerramienta "Llave francesa" n Hierro : infinitasLlavesFrancesas (n+1)

-------
--punto2
-------

tiene :: Herramienta -> Plomero -> Bool
tiene herramienta = any (nombreH herramienta ==) . listaNombreHerramientas 

listaNombreHerramientas :: Plomero -> [String]
listaNombreHerramientas = map nombreH . herramientas

esMalvado :: Plomero -> Bool
esMalvado = empiezaConWa . nombreP

empiezaConWa :: String -> Bool
empiezaConWa nombre = (("Wa" ==) . take 2) nombre

puedeComprar :: Herramienta -> Plomero -> Bool
puedeComprar herramienta plomero = dinero plomero >= precio herramienta

--------
--punto3
--------

esBuena :: Herramienta -> Bool
esBuena herramienta = (material herramienta == Hierro && precio herramienta > 10000.0) || (nombreH herramienta == "martillo" && (material herramienta == Goma || material herramienta == Madera))

--------
--punto4
--------

comprar :: Herramienta -> Plomero -> Plomero
comprar herramienta plomero
    | puedeComprar herramienta plomero = modificarDinero ((precio herramienta) -) . modificarListaH  (herramienta :) $ plomero
    | otherwise                        = plomero

modificarDinero :: (Float -> Float) -> Plomero -> Plomero
modificarDinero funcion plomero = plomero {dinero = funcion . dinero $ plomero}

modificarListaH :: ([Herramienta] -> [Herramienta]) -> Plomero -> Plomero
modificarListaH funcion plomero = plomero {herramientas = funcion . herramientas $ plomero}

--------
--punto5
--------
--a
data Reparacion = UnaReparacion{
    descripcion :: String,
    requerimiento :: (Plomero -> Bool)
}deriving (Show)

filtracionDeAgua = UnaReparacion "SE FILTRO AGUA" (tiene llaveInglesa)

--b
esDificil :: Reparacion -> Bool
esDificil reparacion = esComplicada (descripcion reparacion) && esUnGrito (descripcion reparacion)

esComplicada :: String -> Bool
esComplicada descripcion = length descripcion > 100

esUnGrito :: String -> Bool
esUnGrito descripcion = all esMayuscula descripcion

esMayuscula :: Char -> Bool
esMayuscula caracter = elem caracter "ABCDEFGHIJKLMNOPQRSTUVWXYZ., "

--c
presupuesto :: Reparacion -> Float
presupuesto = (3 *) . floatLength . descripcion

floatLength :: String -> Float
floatLength string = fromIntegral (length string)

--punto 6
destornillador = UnaHerramienta "destornillador" 0 Plastico

hacerReparacion :: Reparacion -> Plomero -> Plomero
hacerReparacion reparacion plomero
    | not (esCapaz reparacion plomero) = modificarDinero (10 +) plomero
    | esMalvado plomero                = agregarReparacion reparacion . modificarListaH (destornillador :) $ plomero
    | esDificil reparacion             = agregarReparacion reparacion . modificarListaH (filter not esBuena) $ plomero
    | otherwise                        = agregarReparacion reparacion . modificarListaH (tail) $ plomero

esCapaz :: Reparacion -> Plomero -> Bool
esCapaz reparacion = requerimiento reparacion

agregarReparacion :: Reparacion -> Plomero -> Plomero
agregarReparacion reparacion plomero = plomero {reparaciones = ((reparacion :) . reparaciones) plomero}

--punto 7

jornada :: [Reparacion] -> Plomero -> Plomero
jornada reparaciones plomero = foldr hacerReparacion plomero reparaciones




