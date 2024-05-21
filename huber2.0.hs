import Text.Show.Functions
import Data.List

data Chofer = UnChofer {
    nombreChofer :: String,
    kilometraje :: Float,
    viajesTomados :: [Viaje],
    condicion :: Condicion
} deriving (Show)

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
    condicion = (Precio)
}

choferDaniel = UnChofer {
    nombreChofer = "Daniel",
    kilometraje = 23500,
    viajesTomados = [viajeLucas],
    condicion = (Domicilio "Olivos")
}

clienteJuan = UnCliente{
    nombreCliente = "Juan",
    domicilioCliente = "Sarmiento"
}

clienteLucas = UnCliente{
    nombreCliente = "Lucas",
    domicilioCliente = "Victoria"
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

viajeLucas = UnViaje {
    fechaViaje = "20/04/2017",
    costo = 150,
    clienteDelViaje = clienteLucas
}

choferAlejandra = UnChofer {
    nombreChofer = "Alejandra",
    kilometraje = 180000,
    viajesTomados = [], 
    condicion = (CualquierViaje)
}

data Condicion = LongitudNombreCliente Int | Domicilio String | Precio | CualquierViaje
aplicarCondicion :: Viaje -> Condicion -> Bool
aplicarCondicion (UnViaje _ _ cliente) (LongitudNombreCliente n) = ((n<) . length . nombreCliente) cliente
aplicarCondicion viaje (Domicilio domicilio) = domicilio /= (domicilioCliente . clienteDelViaje) viaje
aplicarCondicion (UnViaje _ precio _) Precio= precio > 200
aplicarCondicion _ CualquierViaje = True

-- 4
tomarViaje :: Viaje -> Chofer -> Bool
tomarViaje viaje (UnChofer _ _ _ condicionParaViaje) = aplicarCondicion viaje condicionParaViaje

-- 5
liquidacionChofer :: Chofer -> Float
liquidacionChofer (UnChofer _ _ viajes _) = sum (map costo viajes)

-- 6
-- a
filtrarChoferesParaViaje :: Viaje -> [Chofer] -> [Chofer]
filtrarChoferesParaViaje viaje listaChoferes = filter (tomarViaje viaje) listaChoferes
mostrarChoferesHabilitadosParaViaje :: Viaje -> [Chofer] -> [String]
mostrarChoferesHabilitadosParaViaje viaje choferes = map nombreChofer (filtrarChoferesParaViaje viaje choferes)

-- b
choferConMenosViajes :: [Chofer] -> Chofer
choferConMenosViajes (chofer1 : _) = chofer1
choferConMenosViajes (chofer1 : chofer2 : resto) = choferConMenosViajes (menorCantidadViajes chofer1 chofer2 : resto)

cantidadDeViajes :: Chofer -> Int
cantidadDeViajes chofer = (length . viajesTomados) chofer 

menorCantidadViajes :: Chofer -> Chofer -> Chofer
menorCantidadViajes chofer1 chofer2
    | cantidadDeViajes chofer1 > cantidadDeViajes chofer2 = chofer2
    | otherwise = chofer1