import Text.Show.Functions
import Data.List

data Animal = UnAnimal {
    coeficiente :: Float,
    especie :: String,
    capacidades :: [String]
}deriving (Show, Eq)
-----------
--punto1
-----------
perro = UnAnimal 45 "canino" ["correr", "morder", "hacer snarf", hacer]
elefante = UnAnimal 30 "elefante" ["pisar fuerte", "hablar"]
raton = UnAnimal 150 "raton" ["correr", "comer queso"]

-----------
--punto2
-----------

inteligenciaSuperior :: Float -> Animal -> Animal
inteligenciaSuperior n animal = modificarCoeficiente (n+) animal

modificarCoeficiente :: (Float -> Float) -> Animal -> Animal
modificarCoeficiente funcion animal = animal {coeficiente = (funcion . coeficiente) animal}

pinkificar :: Animal -> Animal
pinkificar = modificarCapacidades vaciarLista 

vaciarLista :: [a] -> [a]
vaciarLista lista = take 0 lista

modificarCapacidades :: ([String] -> [String]) -> Animal -> Animal
modificarCapacidades funcion animal = animal {capacidades = (funcion . capacidades) animal}

superPoderes :: Animal -> Animal
superPoderes animal 
    | especie animal == "elefante" = modificarCapacidades ("no tenerle miedo a ratones" :) animal
    | esRatonInteligente animal    =  modificarCapacidades ("hablar" :) animal
    | otherwise                    = animal
    where
        esRatonInteligente animal = (especie animal == "raton" && coeficiente animal < 100 )

-----------
--punto3
-----------

antropomorfico :: Animal -> Bool
antropomorfico animal = puedeHablar animal && coeficiente animal > 60

puedeHablar :: Animal -> Bool
puedeHablar = (elem "hablar". capacidades)

noTanCuerdo :: Animal -> Bool
noTanCuerdo = (2<) . length . filter pinkiesco . capacidades

pinkiesco :: String -> Bool
pinkiesco capacidad =  isInfixOf "hacer" capacidad && length capacidad == 10
