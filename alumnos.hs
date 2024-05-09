import Text.Show.Functions
import Data.List

data Alumno = Alumno {
    nombre :: String,
    fNacimiento :: Int,
    legajo :: Int,
    materia :: [String],
    criterio :: Criterio
} deriving (Show, Eq)

data Criterio = Estudioso | HijoDelRigor | Cabuleros deriving (Show, Eq)

data HijoDelRigor = HijoDelRigor {
    nPreguntas = Int
}

data Parcial = Parcial {
    materia :: String,
    cantidadPreguntas :: Int
} deriving (Show, Eq)

cantImparLetras :: Parcial
cantImparLetras parcial = (odd . length)(Parcial Materia _)

estudiaParaElParcial :: Parcial -> Alumno -> Bool
estudiaParaElParcial _ (Alumno _ _ _ _ Estudioso) = True
estudiaParaElParcial (cantImparLetras Parcial) (Alumno _ _ _ _ HijoDelRigor) = True
estudiaParaElParcial  (Alumno _ _ _ _ Estudioso) = True