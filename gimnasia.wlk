class Rutina {
    method intensidad()

    method descanso(tiempo)

    method caloriasQueBaja(tiempo) {
        return 100 * (tiempo - self.descanso(tiempo)) * self.intensidad()
    }

}

class Running inherits Rutina {

    var intensidad = 0

    method intensidad(int){
        intensidad = int
    }

    override method intensidad() {
        return intensidad
    }

    override method descanso(tiempo) {
        return if (tiempo > 20){
            5
        } else {
            2
        }
    }

}

class Maraton inherits Running {
    
    override method caloriasQueBaja(tiempo){
        return super(tiempo) * 2
    }

}

class Remo inherits Rutina {

    override method descanso(tiempo){
        return tiempo / 5
    }

    override method intensidad () {
        return 1.3
    }

}

class RemoPorCompeticion inherits Remo {

    override method intensidad (){
        return 1.7
    }

    override method descanso (tiempo){
        return (super(tiempo) - 3).max(2)
    }

}




class Persona {
    var property kilos 
    method tiempoDeEjercicio ()
    method puedeHacerRutina(rutina)
    method kilosPorCaloriaQuePierde()

    method cuantosKilosBajaSiHace(rutina) {
        return rutina.caloriasQueBaja(self.tiempoDeEjercicio()) / self.kilosPorCaloriaQuePierde()
    }

    method realizarRutina(rutina){
        self.validarRutina(rutina)
        kilos = kilos - self.cuantosKilosBajaSiHace(rutina)
    }

    method validarRutina(rutina) {
        if (!self.puedeHacerRutina(rutina)){
            self.error("No puede hacer la rutina dada")
        }
    }

}

class PersonaSedentaria inherits Persona {
    
    var tiempoDeEjercicio = 0

    method tiempoDeEjercicio(int) {
        tiempoDeEjercicio = int
    }

    override method tiempoDeEjercicio(){
        return tiempoDeEjercicio
    }

    override method kilosPorCaloriaQuePierde(){
        return 7000
    }

    override method puedeHacerRutina(rutina){
        return kilos > 50
    }
}

class PersonaAtleta inherits Persona {

    override method cuantosKilosBajaSiHace(rutina){
        return super(rutina) - 1
    }

    override method kilosPorCaloriaQuePierde(){
        return 8000
    }

    override method tiempoDeEjercicio() {
        return 90
    }

    override method puedeHacerRutina(rutina) {
        return 10000 < rutina.caloriasQueBaja(self.tiempoDeEjercicio())
    }

}



class Clubes {
    
   const predios = []

    method añadirPredio(predioAñadido) {
        predios.add(predioAñadido)
    }

   method predios() {
        return predios
   }

    method prediosTranquisPara(persona) {
        return predios.filter({predio => predio.tieneRutinaTranquiPara(persona)})
    }

    method elMejorPredioPara(persona) {
        return predios.max({predio => predio.cantidadDeCaloriasQuemadasPor(persona)})
    }

    method lasRutinasMasExigentesPara(persona) {
        return predios.map({predio => predio.laRutinaMasExigentePara(persona)})
    }

}

class Predio {
    const rutinas = []

    method añadirRutina(rutina) {
        rutinas.add(rutina)
    }

    method tieneRutinaTranquiPara(persona) {
        return rutinas.any({rutina => rutina.caloriasQueBaja(persona.tiempoDeEjercicio()) < 500})
    }

    method cantidadDeCaloriasQuemadasPor(persona) {
        return rutinas.sum({rutina => rutina.caloriasQueBaja(persona.tiempoDeEjercicio())})
    }

    method laRutinaMasExigentePara(persona){
       return rutinas.max({rutina => rutina.caloriasQueBaja(persona.tiempoDeEjercicio())})
    }

}