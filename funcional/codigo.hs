--guia 1
f x = x * 2
esMultiploDeTres numero = (mod numero 3) == 0
multiplos num1 num2 = (mod num2 num1) == 0
cubo number = number * number * number
area base altura = base * altura
celsiusToFahr grados = grados + 273

--guia 2
siguiente numero = numero + 1
mitad numero = numero / 2
inversa numero = 1 / numero
esNumeroPositivo numero = (numero >= 0)
--Composicion
igualCero numero = numero == 0
-- aplicacion parcial
restoDeDivision numero = mod numero 
esMultiploDeDos numero = (igualCero . (restoDeDivision numero)) 2
raizCuadrada numero = numero ** (1/2)
inversaRaizCuadrada numero = (inversa.raizCuadrada) numero
cuadrado numero = numero * numero
incrementaMCuadradoN m n = ( (+n).cuadrado) m

--guia 3
numero = [1,2,3,4,5]
frecuenciaCardiaca = [80, 100, 120, 128, 130, 123, 125]
promedioFrecuenciaCardiaca frecuenciaCardiaca = sum (map fromIntegral frecuenciaCardiaca) / fromIntegral (length frecuenciaCardiaca)
frecuenciaCardiacaMinuto = ((frecuenciaCardiaca !!) . (`div` 10))
frecuenciaHastaMomento num = ((`take` frecuenciaCardiaca) . (+1) .(`div` 10))num
esCapicua palabra = ( (== concat(palabra)) . reverse . concat) palabra
duracionLlamadas = (("horarioReducido",[20,10,25,15]),("horarioNormal",[10,5,8,2,9,10]))
mejoresNotas notas = map maximum notas
aprobo notas = (not . elem False . map(> 5)) notas

--guia 4
mapa :: (a -> b) -> [a] -> [b]
mapa funcion [] = []
mapa funcion (x:xs) = funcion x : mapa funcion xs

sacar :: Int -> [a] -> [a]
sacar 0 (x:xs) = (x:xs)
sacar n (x:xs) = sacar (n-1) xs

alguno :: (a -> Bool) -> [a] -> Bool
alguno funcion [] = False
alguno funcion (x:xs) = (funcion x) || (alguno funcion xs)