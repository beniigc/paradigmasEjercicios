import Text.Show.Functions
import Data.List

data Chofer = UnChofer {
    nombreChofer :: String,
    kilometraje :: Float,
    viajesTomados :: [Viaje],
    condicion :: (Viaje -> Bool)
} deriving(Show)

data Viaje = UnViaje {
    fechaViaje :: String,
    costo :: Float,
    clienteDelViaje :: Cliente
}deriving(Show)

data Cliente = UnCliente{
    nombreCliente :: String,
    domicilioCliente :: String
}deriving(Show)

choferPedro = UnChofer {
    nombreChofer = "Pedro",
    kilometraje = 145,
    viajesTomados = [belgrano, cordoba],
    condicion = (condicionPrecio)
}

belgrano = UnViaje {
    fechaViaje = "12/3/2024",
    costo = 599,
    clienteDelViaje = clienteJuan
}

cordoba = UnViaje {
    fechaViaje = "12/4/2024",
    costo = 900,
    clienteDelViaje = clienteJuan
}

clienteJuan = UnCliente{
    nombreCliente = "Juan",
    domicilioCliente = "Sarmiento"
}



data Condicion = LongitudNombreCliente Int | Domicilio String | precio
aplicarCondicion :: Viaje -> Condicion -> Bool
aplicarCondicion (UnViaje _ _ cliente) (LongitudNombreCliente n) = ((n<) . length . nombreCliente) cliente
aplicarCondicion viaje (Domicilio domicilio) = domicilio /= (domicilioCliente . clienteDelViaje) viaje
aplicarCondicion (UnViaje _ precio _) = precio > 200

{-}

condicionPrecio :: Condicion
condicionPrecio (UnViaje _ precio _) = precio > 200

--se tiene que aplicar parcialmente cuando declaremos la condicion de un nuevo chofer debido a que recibe un int ademas del viaje
condicionNombreCliente :: Int -> Condicion
condicionNombreCliente n (UnViaje _ _ cliente) = ((n<) . length . nombreCliente) cliente

condicionDomicilio :: String -> Condicion
condicionDomicilio domicilio viaje = domicilio /= (domicilioCliente . clienteDelViaje) viaje