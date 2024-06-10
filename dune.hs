import Text.Show.Functions
import Data.List

data Fremen = UnFremen {
    nombre :: String,
    nivelTolerancia :: Int,
    titulos :: [String],
    reconocimientos :: Int
}deriving (Show)

stilgar = UnFremen "Stilgar" 150 ["Guia"] 3
--punto1
--a
modificarReconocimiento :: (Int -> Int) -> Fremen -> Fremen
modificarReconocimiento funcion fremen = fremen {reconocimientos = funcion . reconocimientos $ fremen}

nuevoReconocimiento :: Fremen -> Fremen
nuevoReconocimiento fremen = modificarReconocimiento (+ 1) fremen

--b
candidatoAElegido :: [Fremen] -> Bool
candidatoAElegido listaFremen = any (candidato) listaFremen

candidato :: Fremen -> Bool
candidato fremen = (elem "Domador" . titulos) fremen && nivelTolerancia fremen > 100

--c 
elElegido :: [Fremen] -> Bool
elElegido listaFremen = mayorReconocimiento . filter candidato $ listaFremen

mayorReconocimiento :: [Fremen] -> Bool
mayorReconocimiento listaFremen = 