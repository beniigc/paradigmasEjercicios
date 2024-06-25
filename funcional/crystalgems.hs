import Text.Show.Functions
import Data.List

data Aspecto = UnAspecto {
  tipoDeAspecto :: String,
  grado :: Float
} deriving (Show, Eq)

type Situacion = [Aspecto]

mejorAspecto :: Aspecto -> Aspecto -> Bool
mejorAspecto mejor peor = grado mejor < grado peor

mismoAspecto :: Aspecto -> Aspecto -> Bool
mismoAspecto aspecto1 aspecto2 = tipoDeAspecto aspecto1 == tipoDeAspecto aspecto2

buscarAspecto aspectoBuscado = head.filter (mismoAspecto aspectoBuscado)

buscarAspectoDeTipo tipo = buscarAspecto (UnAspecto tipo 0)

reemplazarAspecto aspectoBuscado situacion = aspectoBuscado : (filter (not.mismoAspecto aspectoBuscado) situacion)

--punto1
tension = UnAspecto {
    tipoDeAspecto = "problematico"
    grado = 40.0
}
situacion1 = [(UnAspecto "tension" 40.0), (UnAspecto "incertidumbre" 99.0), (UnAspecto "peligro" 7.0)]
situacion1 = [(UnAspecto "peligro" 190.0), (UnAspecto "tension" 119.0), (UnAspecto "incertidumbre" 76.0)]


modificarAspecto :: (Float -> Float) -> Aspecto -> Aspecto
modificarAspecto funcion aspecto = aspecto {grado = funcion (grado aspecto)}

modificarSituacion :: Situacion -> Aspecto -> (Float -> Float) -> Aspecto
modificarSituacion aspecto funcion situacion = (modificarAspecto funcion) . buscarAspecto aspecto $ situacion

-- punto 2

data Gema = UnaGema {
    nombre :: String,
    fuerza :: Float,
    personalidad :: (Situacion -> Situacion)
}

vidente :: Situacion -> Situacion
vidente situacion = modificarsituacion incertidumbre