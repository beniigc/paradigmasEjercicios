data Pais = UnPais {
    nombre :: String,
    ingresoPerCapita :: Float,
    poblacionActivaPublico :: Float,
    poblacionActivaPrivado :: Float,
    recursos :: [String],
    deuda :: Float
}

-- punto 1
namibia = UnPais {Namibia 4140 400000 650000 ["mineria", "ecoturismo"] 50000000}

-- punto 2

prestarleMillones :: Int -> Pais -> Pais
prestarleMillones n pais =  pais {deuda = 1.50 * (n * 1000000)}



reducirPuestos :: Int -> Pais -> Pais
reducriPuestos puestosReducidos pais = pais{
    ingresoPerCapita = ingresoPerCapita * porcentajeADisminuir puestosReducidos,
    poblacionActivaPublico = poblacionActivaPublico - puestosReducidos
}

porcentajeADisminuir :: Int -> Int
porcentajeADisminuir puestos 
    | puestos > 100 = 0.2
    | otherwise     = 0.15

type Empresa = String

darRecursoAEmpresa :: Empresa -> String -> Pais -> Pais
darRecursoAEmpresa _ recurso pais = pais {recursos = filter (== recurso) recursos}

blindaje :: Pais -> Pais
blindaje pais = reducriPuestos 500 . prestarleMillones . (/2) . (productoBruto) & pais