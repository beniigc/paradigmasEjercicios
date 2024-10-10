import src.personas.persona.*
import src.personas.medico.*

class JefeDeDepartamento inherits Persona {
  const subordinados = #{}

  method atenderA(unaPersona) {
    subordinados.anyOne().atenderA(unaPersona)
  }

  method agregarSubordinado(unSubordinado) {
    subordinados.add(unSubordinado)
  }

}