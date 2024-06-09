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
perro = UnAnimal 45 "canino" ["correr", "morder", "hacer snaf", "hacer snif", "hacer"]
elefante = UnAnimal 30 "elefante" ["pisar fuerte", "hablar"]
raton = UnAnimal 17 "raton" ["destruenglonir el mundo", "hacer planes desalmados"]

-----------
--punto2
-----------
type Transformacion = (Animal -> Animal)

inteligenciaSuperior :: Float -> Transformacion
inteligenciaSuperior n animal = modificarCoeficiente (n+) animal

modificarCoeficiente :: (Float -> Float) -> Animal -> Animal
modificarCoeficiente funcion animal = animal {coeficiente = (funcion . coeficiente) animal}

pinkificar :: Transformacion
pinkificar = modificarCapacidades vaciarLista 

vaciarLista :: [a] -> [a]
vaciarLista lista = take 0 lista

modificarCapacidades :: ([String] -> [String]) -> Animal -> Animal
modificarCapacidades funcion animal = animal {capacidades = (funcion . capacidades) animal}

superPoderes :: Transformacion
superPoderes animal 
    | especie animal == "elefante" = modificarCapacidades ("no tenerle miedo a ratones" :) animal
    | esRatonInteligente animal    =  modificarCapacidades ("hablar" :) animal
    | otherwise                    = animal
    where
        esRatonInteligente animal = (especie animal == "raton" && coeficiente animal < 100 )

-----------
--punto3
-----------

type Criterio = (Animal -> Bool)
antropomorfico :: Criterio
antropomorfico animal = puedeHablar animal && coeficiente animal > 60

puedeHablar :: Criterio
puedeHablar = (elem "hablar". capacidades)

noTanCuerdo :: Criterio
noTanCuerdo = (>2) . length . filter pinkiesco . capacidades

pinkiesco :: String -> Bool 
pinkiesco capacidad =  (take 6 capacidad == "hacer") && palabraPinkieska (drop 6 capacidad)

palabraPinkieska :: String -> Bool
palabraPinkieska palabra = any esVocal palabra && (length palabra <= 4)

esVocal :: Char -> Bool
esVocal letra = elem letra "AEIOUaeiou"

-----------
--punto4
-----------

data Experimento = UnExperimento{
    transformaciones :: [Transformacion],
    criterioDeExito :: Criterio
}deriving (Show)

experimentoRaton = UnExperimento [pinkificar, inteligenciaSuperior 10, superPoderes] antropomorfico

experimentoExitoso :: Experimento -> Animal -> Bool
experimentoExitoso experimento = (criterioDeExito experimento) . (experimentar experimento) 

experimentar :: Experimento -> Transformacion
experimentar experimento animal = foldr aplicarTransformacion animal (transformaciones experimento)

aplicarTransformacion :: Transformacion -> Animal -> Animal
aplicarTransformacion transformacion = transformacion

-----------
--punto5
-----------

informe1 :: [Animal] -> [String] -> Experimento -> Int
informe1 animales listaCapacidades experimento = length . filter (tieneElementosEnComun listaCapacidades). map capacidades . map (experimentar experimento) $ animales

tieneElementosEnComun :: [String] -> [String] -> Bool
tieneElementosEnComun lista1 lista2 = any (`elem` lista2) lista1

-----------
--punto6
-----------
{- No deberia haber limitaciones en cuanto a las transformaciones debido a que la transformacion superpoder agrega un elemento al
prinicpio de la lista infinita y no al final. En cuanto al criterio si tiene "noTanCuero" entonces tendria un problema con el filter
debido a que deberia buscar elementos en una lista infinita y esa busqueda nunca terminaria -}

-----------
--punto7
-----------

palabrasPinky :: [String]
palabrasPinky = filter (tieneVocal) (generateWordsUpTo 4)
