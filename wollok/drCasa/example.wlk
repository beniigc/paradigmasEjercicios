class persona{
  var enfermedadContraida = malaria
  var celulas = 0
  var temperatura = 0

  method temperatura() = 0
  method celulas ()= celulas
  method contraerEnfermedad(enfermedad){
    enfermedadContraida = enfermedad
  }
  pasoDelTiempo(diasPasados){
    31.times(enfermedadContraida.efectoEnfermedad(self))
  }
}

class enfermedadAutoinmune{
  var celulasAmenazadas = 0
  method efectoEnfermedad(persona){
    persona.celulas -= celulasAmenazadas
  }
}

class enfermedadInfecciosa(){
  var celulasAmenazadas = 0
  method efectoEnfermedad(persona){
    persona.temperatura = 45 . max . (persona.temperatura += celulasAmenzadas/1000)
    celulasAmenazadas = 2 * celulasAmenazadas
  }
}