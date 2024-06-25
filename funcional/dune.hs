import Text.Show.Functions
import Data.List

data Fremen = UnFremen {
    nombre :: String,
    nivelTolerancia :: Int,
    titulos :: [String],
    reconocimientos :: Int
}deriving (Show)

stilgar = UnFremen "Stilgar" 150 ["Guia"] 3
jose = UnFremen "Jose" 150 ["Guia"] 4
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
candidato fremen = esDomador fremen && nivelTolerancia fremen > 100

esDomador :: Fremen -> Bool
esDomador = (elem "Domador" . titulos)

--c 
elElegido :: [Fremen] -> Fremen
elElegido listaFremen = mayorReconocimiento . filter candidato $ listaFremen

mayorReconocimiento :: [Fremen] -> Fremen
mayorReconocimiento (f1 : []) = f1
mayorReconocimiento (f1 : f2 : fremens) 
    | masReconocido f1 f2 = mayorReconocimiento (f1 : fremens)
    | otherwise           = mayorReconocimiento (f2 : fremens)

masReconocido :: Fremen -> Fremen -> Bool
masReconocido fremen1 fremen2 = reconocimientos fremen1 > reconocimientos fremen2

--punto2
data Gusano = Gusano{
    longitud :: Float,
    hidratacion :: Float,
    descripcion :: String
}deriving (Show)

reproduccion :: Gusano -> Gusano -> Gusano
reproduccion gusano1 gusano2 = gusano1{
                                        longitud = (0.10 *) . longitud . masLargo $ gusano1,
                                        hidratacion = 0,
                                        descripcion = descripcion gusano1 : " - " : descripcion gusano2
}
masLargo :: Gusano -> Gusano -> Gusano
masLargo gusano1 gusano2 
    | longitud gusano1 > longitud gusano2 = gusano1
    | otherwise                           = gusano2

listaDeCrias :: [Gusano] -> [Gusano] -> [Gusano]
listaDeCrias lista1 [] = []
listaDeCrias [] lista2 = []
listaDeCrias (gusanoLista1 : gusanoLista1) (gusanoista2 : gusanoLista2) = reproduccion gusanoLista1 gusanoLista2 : listaDeCrias restoLista1 restoLista2

--punto3

