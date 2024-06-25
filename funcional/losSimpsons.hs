--------
--punto1
--------
data Simpson = Simpson{
    nombre :: String,
    dinero :: Int,
    felicidad :: Int
}deriving (Show)

type Actividad = Simpson -> Simpson
homero = Simpson "Homero" 20 10
lisa = Simpson "Lisa" 2 20
skinner = Simpson "Skinner" 30 9
srBurns = Simpson "Sr Burns" 20000 40

modificarFelicidad :: (Int -> Int) -> Simpson -> Simpson
modificarFelicidad funcion simpson 
    | felicidadModificada > 0 = simpson {felicidad = felicidadModificada}
    | otherwise       = simpson {felicidad = 0}
    where
        felicidadModificada = funcion $ felicidad simpson

modificarDinero :: (Int -> Int) -> Simpson -> Simpson
modificarDinero funcion simpson = simpson {dinero = funcion $ felicidad simpson}

irAEscuela :: Actividad
irAEscuela (Simpson "Lisa" _ _) = modificarFelicidad (+ 20) lisa
irAEscuela simpson              = modificarFelicidad (subtract 20) simpson

comerXDonas :: Int -> Actividad
comerXDonas cantidad = modificarDinero (+ cantidadX10) . modificarFelicidad (+ cantidadX10) where cantidadX10 = 10 * cantidad  

irATrabajar :: String -> Actividad
irATrabajar trabajo = modificarDinero (length trabajo +)

irATrabajarComoDirector :: Actividad
irATrabajarComoDirector = irATrabajar "escuela elemental" . modificarFelicidad (subtract 20)

--------
--punto2
--------
type Logro = Simpson -> Bool

type Aspecto = Simpson -> Int

supera :: Aspecto -> Int -> Simpson -> Bool
supera aspecto valor = (valor <) . aspecto 

serMillonario :: Logro
serMillonario = supera dinero (dinero srBurns) 

alegrarse :: Int -> Logro
alegrarse nivel = supera felicidad nivel 

verAKrosti :: Logro
verAKrosti = supera dinero 10

masGoloso :: Logro
masGoloso = supera felicidad (felicidad homero)

---
--A
---
esDecisiva :: Actividad -> Logro -> Simpson -> Bool
esDecisiva actividad logro simpson = (logro . actividad $ simpson) && not (logro simpson)




