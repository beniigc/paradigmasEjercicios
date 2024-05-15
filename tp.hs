
import Text.Show.Functions
import Data.List


{- 
“Yo extraño mi ciudad, las luces de mi ciudad...” decía la canción. Es el momento de modelar las ciudades del pintoresco país de Haskellandia, 
de las que nos interesa conocer su nombre, el año de fundación, las atracciones principales (como “Obelisco”, “Pan de Azúcar”, “El Gorosito”, etc.) 
y su costo de vida.
-}
-- Estructura de ciudades

data CiudadHaskellandia = CiudadHaskellandia {
                    nombre :: String,
                    anioFundacion :: Float,
                    atracciones :: [String],
                    costoDeVida :: Float } deriving (Show, Eq)
-- Ejemplo de ciudades 
ciudad1 :: CiudadHaskellandia
ciudad1 = CiudadHaskellandia {
                    nombre = "Baradero",
                    anioFundacion = 1615,
                    atracciones = ["Parque del Este", "Museo Alejandro Barbich"],
                    costoDeVida = 150 } 
ciudad2 :: CiudadHaskellandia
ciudad2 = CiudadHaskellandia {
                    nombre = "Nullish",
                    anioFundacion = 1800,
                    atracciones = [],
                    costoDeVida = 140 } 
ciudad3 :: CiudadHaskellandia   
ciudad3 = CiudadHaskellandia {
                    nombre = "Caleta Olivia",
                    anioFundacion = 1901,
                    atracciones = ["El Gorosito", "Faro Costanera"],
                    costoDeVida = 120 } 
ciudad4 :: CiudadHaskellandia
ciudad4 = CiudadHaskellandia {
                    nombre = "Maipú",
                    anioFundacion = 1878,
                    atracciones = ["Fortín Kakel"],
                    costoDeVida = 115  } 
ciudad5 :: CiudadHaskellandia
ciudad5 = CiudadHaskellandia {
                    nombre = "Azul",
                    anioFundacion = 1832,
                    atracciones = ["Teatro Español", "Parque Municipal Sarmiento", "Costanera Cacique Catriel"],
                    costoDeVida = 190   } 

{-
Punto 1:
Definir el valor de una ciudad, un número que se obtiene de la siguiente manera:
    - Si fue fundada antes de 1800, su valor es 5 veces la diferencia entre 1800 y el año de fundación.
    - Si no tiene atracciones, su valor es el doble del costo de vida.
    - De lo contrario, será 3 veces el costo de vida de la ciudad.
-}

obtenerValorCiudad :: CiudadHaskellandia -> Float
obtenerValorCiudad ciudad
                | anioFundacion ciudad < 1800 = 5 * (1800 - anioFundacion ciudad)
                | null (atracciones ciudad) = 2 * costoDeVida ciudad
                | otherwise = 3 * costoDeVida ciudad

-- Punto 2: Características de las ciudades

-- Funciones del Punto 2
esVocal :: Char -> Bool
esVocal letra = elem letra "aeiouAEIOU"

-- Resolucion Punto 2
{-
Queremos saber si una ciudad tiene alguna atracción copada, esto es que la atracción comience con una vocal. 
Por ejemplo: "Acrópolis" es una atracción copada y "Golden Gate" no es copada.
-}

esCopada :: CiudadHaskellandia -> Bool
esCopada ciudad =  any esVocal (map head (atracciones ciudad))

{-
Queremos saber si una ciudad es sobria, esto se da si todas las atracciones tienen más
de cierta cantidad de letras.
-}

esSobria :: Int -> CiudadHaskellandia -> Bool
esSobria n ciudad = all (n<) (map length (atracciones ciudad))

{-
Queremos saber si una ciudad tiene un nombre raro, esto implica que tiene menos de 5 letras en su nombre.
-}

esRaro :: CiudadHaskellandia -> Bool
esRaro ciudad = 5 > (length.nombre) ciudad

-- Punto 3

{-
Queremos poder agregar una nueva atracción a la ciudad. 
Esto implica un esfuerzo de toda la comunidad en tiempo y dinero, 
lo que se traduce en un incremento del costo de vida de un 20%.
-}
agregarAtraccion :: CiudadHaskellandia -> String -> CiudadHaskellandia
agregarAtraccion ciudad atraccion = ciudad {
                                        atracciones = atraccion : atracciones ciudad,
                                        costoDeVida = 1.2 * costoDeVida ciudad
                                    }
{-
Al atravesar una crisis, la ciudad baja un 10% su costo de vida y se debe cerrar la última atracción de la lista.
-}

estaEnCrisis :: CiudadHaskellandia -> CiudadHaskellandia
estaEnCrisis ciudad = ciudad {
                                        atracciones =  init $ atracciones ciudad,
                                        costoDeVida = 0.9 * costoDeVida ciudad
                                    }

{-
Al remodelar una ciudad, incrementa su costo de vida un porcentaje que 
se indica al hacer la remodelación y le agrega el prefijo "New " al nombre.
-}

remodelar :: Float -> CiudadHaskellandia -> CiudadHaskellandia
remodelar aumento ciudad = ciudad {
                                        nombre =  "New " ++ nombre ciudad,
                                        costoDeVida = (1 + aumento/100) * costoDeVida ciudad
                                    }

{-
Si la ciudad es sobria con atracciones de más de n letras (valor que se quiere configurar), 
aumenta el costo de vida un 10%, si no baja 3 puntos.
-}

reevaluacion :: Int -> CiudadHaskellandia -> CiudadHaskellandia
reevaluacion n ciudad 
                    | esSobria n ciudad = ciudad { costoDeVida = 1.1 * costoDeVida ciudad}
                    | otherwise = ciudad { costoDeVida = costoDeVida ciudad - 3.0}