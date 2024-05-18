
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
                    atracciones = ["Fortin Kakel"],
                    costoDeVida = 115  }
ciudad5 :: CiudadHaskellandia
ciudad5 = CiudadHaskellandia {
                    nombre = "Azul",
                    anioFundacion = 1832,
                    atracciones = ["Teatro Espanol", "Parque Municipal Sarmiento", "Costanera Cacique Catriel"],
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

agregarAtraccion :: String -> CiudadHaskellandia -> CiudadHaskellandia
agregarAtraccion atraccion ciudad = ciudad {
                                        atracciones = atraccion : atracciones ciudad,
                                        costoDeVida = 1.2 * costoDeVida ciudad
                                    }

{-
Al atravesar una crisis, la ciudad baja un 10% su costo de vida y se debe cerrar la última atracción de la lista.
-}
eliminarUltimaAtraccion :: CiudadHaskellandia -> [String]
eliminarUltimaAtraccion ciudad
                            | null (atracciones ciudad) = atracciones ciudad
                            | otherwise = init $ atracciones ciudad

estaEnCrisis :: CiudadHaskellandia -> CiudadHaskellandia
estaEnCrisis ciudad = ciudad {
                                        atracciones =  eliminarUltimaAtraccion ciudad,
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

-- Punto 5
data Evento = AgregarAtraccion String | Crisis | Remodelacion Float | Reevaluacion Int

data Anio = Anio {
    anio :: Int,
    eventos :: [Evento]
}

aplicarEvento :: Evento -> CiudadHaskellandia -> CiudadHaskellandia
aplicarEvento (AgregarAtraccion atraccion) = agregarAtraccion atraccion
aplicarEvento Crisis = estaEnCrisis
aplicarEvento (Remodelacion porcentaje) = remodelar porcentaje
aplicarEvento (Reevaluacion n) = reevaluacion n

aplicarEventos :: [Evento] -> CiudadHaskellandia -> CiudadHaskellandia
aplicarEventos eventos ciudad = foldr aplicarEvento ciudad eventos

anio2022 :: Anio
anio2022 = Anio{
    anio = 2022,    
    eventos = [Crisis, Remodelacion 5, Reevaluacion 7]
}
anio2015 :: Anio
anio2015 = Anio {
    anio = 2015,
    eventos = []
}
anio2023 :: Anio
anio2023 = Anio {
    anio = 2023,
    eventos = [Crisis, AgregarAtraccion "Parque", Remodelacion 10, Remodelacion 20]
}
anio2021 :: Anio 
anio2021 = Anio{
    anio = 2021,
    eventos = [Crisis, AgregarAtraccion "Playa"]
}


type Criterio = CiudadHaskellandia -> Float
aplicarCriterio :: (t1 -> t2) -> t1 -> t2
aplicarCriterio criterio ciudad = criterio ciudad

-- costoDeVida ya es un criterio, por la firma que tiene

cantidadDeAtracciones :: Criterio
cantidadDeAtracciones ciudad = (fromIntegral . length . atracciones) ciudad

-- 5.1 :  Los años pasan..

pasoDeAnio :: Anio -> CiudadHaskellandia -> CiudadHaskellandia
pasoDeAnio anio ciudad =  aplicarEventos (eventos anio) ciudad

-- 5.2 : Algo mejor


algoMejor :: CiudadHaskellandia -> Criterio -> Evento -> Bool
algoMejor ciudad criterio evento = aplicarCriterio criterio ciudad < aplicarCriterio criterio (aplicarEvento evento ciudad)

-- 5.3 : Costo de vida que suba

mayorCostoDeVida :: CiudadHaskellandia -> Evento -> Bool
mayorCostoDeVida _ Crisis = False
mayorCostoDeVida ciudad (Reevaluacion n)
                                    | esSobria n ciudad = True
                                    | otherwise = False
mayorCostoDeVida _ (AgregarAtraccion atraccion) = True
mayorCostoDeVida _ (Remodelacion porcentaje) = True

anioSoloMayorCosto :: Anio -> CiudadHaskellandia -> Anio
anioSoloMayorCosto anio ciudad = anio { eventos = filter (mayorCostoDeVida ciudad) (eventos anio)}

aplicarMayorCosto :: CiudadHaskellandia -> Anio -> CiudadHaskellandia
aplicarMayorCosto ciudad anio = pasoDeAnio (anioSoloMayorCosto anio ciudad) ciudad

-- 5.4 : Costo de vida que baje
anioSoloMenorCosto :: Anio -> CiudadHaskellandia -> Anio
anioSoloMenorCosto anio ciudad = anio { eventos = filter (not . mayorCostoDeVida ciudad) (eventos anio)}

aplicarMenorCosto :: CiudadHaskellandia -> Anio -> CiudadHaskellandia
aplicarMenorCosto ciudad anio =  pasoDeAnio (anioSoloMenorCosto anio ciudad) ciudad

-- 5.5 Valor que suba 

anioSoloMayorValor :: Anio -> CiudadHaskellandia -> Anio
anioSoloMayorValor anio ciudad
                        | anioFundacion ciudad < 1800 = anio { eventos = []}
                        | otherwise = anio { eventos = filter (mayorCostoDeVida ciudad) (eventos anio)}

aplicarMayorValor :: CiudadHaskellandia -> Anio -> CiudadHaskellandia
aplicarMayorValor ciudad anio = pasoDeAnio (anioSoloMayorValor anio ciudad) ciudad

-- Punto 6: Funciones a la orden

-- 6.1 Eventos ordenados
costoPostEvento :: Evento -> CiudadHaskellandia -> Float
costoPostEvento evento ciudad = (costoDeVida.aplicarEvento evento) ciudad

eventosOrdenados :: Anio -> CiudadHaskellandia -> Bool
eventosOrdenados (Anio anio (evento1:[])) ciudad = True
--eventosOrdenados (UnAnio anio []) ciudad = True
eventosOrdenados (Anio anio (evento1:evento2:eventos)) ciudad = (costoPostEvento evento1 ciudad < costoPostEvento evento2 ciudad) && (eventosOrdenados (Anio anio (evento2:eventos)) ciudad)

-- 6.2 Ciudades ordenadas

ciudadesOrdenadas :: Evento -> [CiudadHaskellandia] -> Bool
ciudadesOrdenadas _ (ciudad:[]) = True
ciudadesOrdenadas evento (ciudad1:ciudad2:ciudades) =  (costoPostEvento evento ciudad1 < costoPostEvento evento ciudad2) && ciudadesOrdenadas evento (ciudad2:ciudades)

-- 6.3 Años ordenados

aniosOrdenados :: [Anio] -> CiudadHaskellandia -> Bool
aniosOrdenados (anio:[]) _ = True
aniosOrdenados (anio1:anio2:anios) ciudad =  ((costoDeVida.pasoDeAnio anio1) ciudad < (costoDeVida.pasoDeAnio anio2) ciudad) && aniosOrdenados (anio2:anios) ciudad