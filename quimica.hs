import Text.Show.Functions
import Data.List


data Sencillo = Sencillo {
    nombreSencillo :: String,
    simbolo :: String,
    nAtomico :: Int,
    familiaSencillo :: Familia
} deriving (Show, Eq)

data Familia = Metal | NoMetal | Halogeno | GasNoble deriving (Show, Eq)

data Compuesto = Compuesto {
    componente1 :: TipoComponente,
    componente2 :: TipoComponente,
    nombreCompuesto :: String,
    familiaCompuesto :: Familia
} deriving (Show, Eq)

data TipoComponente = TipoComponente {
    sustanciaComponente :: Elemento,
    cantMoleculas :: Int
} deriving (Show, Eq)

data Elemento = Simple Sencillo | Complejo Compuesto deriving (Show, Eq)

--Punto 1
--a)
hidrogeno = Sencillo {
    nombreSencillo = "Hidrogeno",
    simbolo = "H",
    nAtomico = 1,
    familiaSencillo = NoMetal
} 

oxigeno = Sencillo {
    nombreSencillo = "Oxigeno",
    simbolo = "O",
    nAtomico = 8,
    familiaSencillo = NoMetal
}

agua = Compuesto {
    componente1 = hidrogenoC,
    componente2 = oxigenoC,
    nombreCompuesto = "Agua",
    familiaCompuesto = NoMetal
}

hidrogenoC = TipoComponente {
    sustanciaComponente = Simple hidrogeno,
    cantMoleculas = 2
}

oxigenoC = TipoComponente {
    sustanciaComponente = Simple oxigeno,
    cantMoleculas = 1
}

--Punto 2
verificarElectricidadSustancia (Sencillo _ _ _ unaFamilia)  
    | unaFamilia == Metal = "Conduce bien"
    | unaFamilia == GasNoble = "Conduce bien"
    | otherwise              = "No conduce bien"

verificarCalorSustancia (Sencillo _ _ _ unaFamilia) 
    | unaFamilia == Metal = "Conduce bien"
    | otherwise           = "No conduce bien"    

verificarCalorComplejo (Compuesto _ _ _ unaFamilia) 
    | unaFamilia == Metal = "Conduce bien"
    | unaFamilia == Halogeno = "Conduce bien"
    | otherwise           = "No conduce bien"    

verificarElectricidadComplejo (Compuesto _ _ _ unaFamilia) 
    | unaFamilia == Metal = "Conduce bien"
    | otherwise           = "No conduce bien" 

{-conduceBien :: Elemento -> String -> String
conduceBien unElemento criterio 
    | Simple && criterio == "calor" = verificarCalorSustancia unElemento
    | Simple && criterio == "electricidad" = verificarElectricidadSustancia unElemento
    | Complejo && criterio == "calor" = verificarCalorComplejo unElemento
    | Complejo && criterio == "electricidad" = verificarElectricidadComplejo unElemento
    | otherwise                              = "no existe este criterio"
-}

--punto 3

esVocal letra = elem letra ['A','E','I','O','U','a','e','i','o','u'] 

verificarVocal :: String -> Bool
verificarVocal nombre = (esVocal . last) nombre

eliminarUltimaLetra nombre = (reverse . tail . reverse) nombre
nombreDeUnion :: String -> String
nombreDeUnion nombre 
    | verificarVocal nombre = nombreDeUnion (eliminarUltimaLetra nombre)
    | otherwise              = nombre ++ "uro" 

nombreDeData (Sencillo nombre _ _ _) = nombre