import Text.Show.Functions
import Data.List

data Ninja = UnNinja{
    nombreNinja :: String,
    herramientas :: [Herramienta],
    rango :: Float
}deriving (Show)

type Herramienta = (String,Float)

nombreHerramienta :: Herramienta -> String
nombreHerramienta = fst

cantidadHerramienta :: Herramienta -> Float
cantidadHerramienta = snd

obtenerHerramienta :: Herramienta -> Ninja -> Ninja
obtenerHerramienta herramienta ninja 
    | cantidadHerramienta herramienta + (cantTotalHerramientas ninja) < 100 = agregarHerramienta herramienta ninja
    | otherwise                                               = agregarHerramienta (nombreHerramienta herramienta, 100 - cantTotalHerramientas ninja) ninja

cantTotalHerramientas :: Ninja -> Float
cantTotalHerramientas = (sum . map cantidadHerramienta . herramientas)

agregarHerramienta :: Herramienta -> Ninja -> Ninja
agregarHerramienta herramienta ninja = ninja {herramientas = herramienta : herramientas ninja}

usarHerramienta :: Herramienta -> Ninja -> Ninja
usarHerramienta herramienta ninja = eliminarHerramienta herramienta ninja

eliminarHerramienta :: Herramienta -> Ninja -> Ninja
eliminarHerramienta herramienta ninja = ninja {herramientas = filter (herramienta /=) (herramientas ninja)}

data Mision = UnaMision{
    cantNinjas :: Int,
    rangoRecomendable :: Float,
    ninjasEnemigos :: [Ninja],
    recompensa :: Herramienta
}

esDesafiante :: Mision -> [Ninja] -> Bool
esDesafiante mision ninjas = (any (rangoRecomendable mision >) . map rango $ ninjas) && (length (ninjasEnemigos mision) > 2)

esCopada :: Mision -> Bool
esCopada mision = recompensa mision == ("bombas de humo", 3) || recompensa mision == ("shurikens", 5) || recompensa mision == ("kunai", 14)

esFactible :: Mision -> [Ninja] -> Bool
esFactible mision ninjas = not (esDesafiante mision ninjas )&& cantNinjas mision == length ninjas && sumaHerramientasEquipo ninjas > 500.0

sumaHerramientasEquipo :: [Ninja] -> Float
sumaHerramientasEquipo ninjas = sum . map cantTotalHerramientas $ ninjas