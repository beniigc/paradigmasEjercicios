import Data.List
 

data Pokemon = Pokemon {
  nombre :: String, 
  familia :: String,
  tipoPokemon :: TipoPokemon
}

 
data Elemento = Fuego | Psiquico | Acero
data TipoPokemon = Unico Elemento | Doble Elemento Elemento

primario (Unico elemento) = elemento

primario (Doble elemento1 _) = elemento1
secundario (Doble _ elemento2) = elemento2

charmander :: Pokemon
charmander = Pokemon {
  nombre = "Charmander",
  familia = "Salamandra piola",
  tipoPokemon = Unico Fuego
}

victini :: Pokemon
victini = Pokemon "Victini" "Pokemon Peronista" (Doble Fuego Psiquico)

familia' :: Pokemon -> String
familia' (Pokemon _ unaFamilia _) = unaFamilia

