object tom{
  var energia = 80

  method esMasVeloz(raton){
    return self.velocidad() > raton.velocidad()
  }

  method velocidad() {
    return 5 + (energia / 10)
  }

}

object jerry {
  var peso = 3

  method velocidad() {
    return 10 - peso
  }
}

object robotRaton {
  method velocidad() {
    return 8
  }
}