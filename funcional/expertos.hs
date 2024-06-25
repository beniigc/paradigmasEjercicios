import Text.Show.Functions
import Data.List

data Persona = UnaPersona{
    nombre :: String,
    dinero :: Float,
    suerte :: Int,
    factores :: [Factor]
} deriving (Show)

type Factor = (String, Int)

nico = UnaPersona "Nico" 100.0 30 [("amuleto", 3), ("manos magicas",100)]
maiu = UnaPersona "Maiu" 100.0 42 [("inteligencia",55), ("paciencia",50)]

-- punto1
{- 1. Conocer la suerte total de una persona. Si no tiene un amuleto, es su suerte normal, si tiene uno, 
su suerte se multiplica por el valor de ese amuleto.
En general, sólo se considera que una persona tiene un factor si el valor del mismo es mayor a cero. Tener un amuleto
 de valor 0 es lo mismo que no tenerlo en absoluto.
-}

suerteTotal :: Persona -> Int
suerteTotal persona 
    | null (factores persona) = suerte persona
    | hayValorMayorQue0 (factores persona) = suerte persona * (map snd) factores  persona
    | otherwise = suerte persona


hayValorMayorQue0 :: [Factor] -> Bool
hayValorMayorQue0 factores = sumatoriaDeValores factores /= 0

sumatoriaDeValores :: [Factor] -> Int
sumatoriaDeValores factores = sum . (map snd) $ factores

