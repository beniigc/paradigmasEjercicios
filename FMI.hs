
-- punto 1
data Pais = UnPais {
    nombre :: String,
    ingresoPerCapita :: Float,
    poblacionActivaPublico :: Float,
    poblacionActivaPrivado :: Float,
    recursos :: [String],
    deuda :: Float
}


namibia = UnPais "namibia" 4140 400000 650000 ["Mineria", "Ecoturismo"] 50000000

-- punto 2

prestarleMillones :: Float -> Pais -> Pais
prestarleMillones n pais = prestarleAlPais (n * 1000000) pais
prestarleAlPais monto pais =  pais {deuda = 1.50 * monto}



reducirPuestos :: Float -> Pais -> Pais
reducirPuestos puestosReducidos pais = pais{
    ingresoPerCapita = ingresoPerCapita * (porcentajeADisminuir puestosReducidos),
    poblacionActivaPublico = poblacionActivaPublico - puestosReducidos
}

porcentajeADisminuir :: Float -> Float
porcentajeADisminuir puestos 
    | puestos > 100 = 0.2
    | otherwise     = 0.15

type Empresa = String

darRecursoAEmpresa :: Empresa -> String -> Pais -> Pais
darRecursoAEmpresa _ recurso pais = pais {recursos = filter (== recurso) recursos}

blindaje :: Pais -> Pais
blindaje pais = reducirPuestos 500 . prestarleAlPais . (/2) . (productoBruto) $ pais

productoBruto :: Pais -> Float
productoBruto pais = ingresoPerCapita pais * poblacionActivaTotal pais

poblacionActivaTotal :: Pais -> Float
poblacionActivaTotal pais = poblacionActivaPrivado pais + poblacionActivaPublico pais

-- punto 3
--a
type Receta = [(Pais -> Pais)]

receta1 :: Receta
receta1 = [prestarleMillones 200 , darRecursoAEmpresa "X" "Mineria"]

--b
aplicarEstrategia :: (Pais -> Pais)
aplicarEstrategia estrategia pais = estrategia pais

aplicarReceta :: Receta -> Pais -> Pais
aplicarReceta receta pais = foldr aplicarEstrategia pais receta

-- Ahora para lograr el efecto se deberia utilizar la funcion aplicar receta sobre namibia por consola

-- 4
puedeZafar :: [Pais] -> [Pais]
puedeZafar paises = filter (any ( == "Petroleo") . recursos) paises

deudaAcumulada = sum . map deuda $ paises

--5 
ordenada :: Receta -> [Pais] -> Bool
ordenada receta [pais] = True
ordenada receta [pais1:pais2:paises] = productoBruto . aplicarReceta  pais1 < productoBruto . aplicarReceta  pais2 && ordenada receta (pais2:paises)


