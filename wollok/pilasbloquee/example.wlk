object manic {
  var estrellasEncontradas = 4
  var estrellasRegaladas = 0
  var globos = 60

  method cantidadGlobos() {
    return globos
  }

  method encontrarEstrellas() {
    estrellasEncontradas += 8
  }

  method regalarEstrella(){
    if(estrellasEncontradas != 0){
    estrellasRegaladas += 1
    }
  }

  method estrellas() {
    return estrellasEncontradas - estrellasRegaladas
  }

  method estaListo() {
    return self.estrellas() > 3
  }
}

object fiesta{
  method estaPreparada(organizador) {
    return (organizador.cantidadGlobos() > 50) && organizador.estaListo()
  }
}

object chuy {
  method estaListo() {
    return true
  }
}

object capy {
  var latas = 0
  var latasRecolectadas = 0

  method recolectar(){
    latasRecolectadas += 1
  }

  method reciclar() {
    if (latasRecolectadas > 4){
    latas -= 5
    latasRecolectadas -= 5
    }
  }

  method estaListo() {
    return self.cantidadPar(latas)
  }

  method cantidadPar(cantidad) {
    return cantidad % 2 == 0
  }
}

