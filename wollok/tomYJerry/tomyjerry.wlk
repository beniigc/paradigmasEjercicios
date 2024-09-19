object tom{
  var energia = 80

  method posicion() = 0

  method esMasVeloz(raton){
    return self.velocidad() > raton.velocidad()
  }

  method velocidad() {
    return 5 + (energia / 10)
  }

  method correrA(raton) {
    energia -= 0.5 * self.velocidad() * (self.posicion() - raton.posicion()).abs()
  }
}

object jerry {
  var peso = 3

  method posicion() = 10

  method velocidad() {
    return 10 - peso
  }
}

object robotRaton {

  method posicion() = 12
  
  method velocidad() {
    return 8
  }
}

