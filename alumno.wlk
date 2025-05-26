import universidad.*
import materia.*
import carrera.*

class Alumno {
    const property cursadas = [] 
    const property carrerasInscriptas = []

    method agregarNuevaCursada(cursada) {
        self.validarSiAproboMateria(cursada.materia())
        cursadas.add(cursada)
    }
    
    method materiasAprobadas() = cursadas.map({cursada => cursada.materia()})
    
    method aprobo(materia) = self.materiasAprobadas().contains(materia)

    method promedio() = cursadas.average({cursada => cursada.nota()})

    method puedeInscribirseA(materia) {
        return self.estaEnLasDeCarrerasInscriptas(materia)
               and not self.aprobo(materia)
               and not self.estaInscriptoEnMateria(materia)
               and self.cumpleElRequisitoDe(materia)
    }

    method notaEn(materia) {
        self.validarSiNoAproboMateria(materia)
        const materiaABuscar = cursadas.find({cursada => cursada.materia() == materia})
        return materiaABuscar.nota()
    }

    method inscribirACarrera(carrera) {
        self.validarSiPuedeInscribirseEnCarrera(carrera)
        carrerasInscriptas.add(carrera)
    }

    method materiasEnEspera() {
        const todasLasMaterias = self.materiasDeCarrerasInscriptas()
        return todasLasMaterias.filter({materia => materia.estaEnListaDeEspera(self)})
    }

    method materiasInscriptas() {
        const todasLasMaterias = self.materiasDeCarrerasInscriptas()
        return todasLasMaterias.filter({materia => materia.estaInscripto(self)})
    }

    method materiasALaQueSePuedeInscribir() {
        const todasLasMaterias = self.materiasDeCarrerasInscriptas()
        return todasLasMaterias.filter({materia => self.puedeInscribirseA(materia)})
    }

    method creditos() {
        const todasLasMaterias = self.materiasInscriptas()
        return todasLasMaterias.sum{materia => materia.credito()}
    }

    
    method validarSiAproboMateria(materia) {
        if(self.aprobo(materia)) {
           self.error("El alumno ya tiene registrada como aprobada la materia dada.")
        }
    }
    
    method validarSiNoAproboMateria(materia) {
        if(not self.aprobo(materia)) {
           self.error("El alumno no tiene registrada como aprobada la materia dada.")
        }
    }

    method validarSiPuedeInscribirseEnCarrera(carrera) {
        if(self.estaInscriptoEnCarrera(carrera)) {
            self.error("El alumno no se puede inscribir porque ya se encuentra inscripto a la materia dada.")
        } 
    }


    method estaInscriptoEnCarrera(carrera) = carrerasInscriptas.contains(carrera)

    method cantidadDeMateriasAprobadas() = self.materiasAprobadas().size()

    method estaInscriptoEnMateria(materia) = materia.estaInscripto(self)

    method cumpleElRequisitoDe(materia) = materia.cumpleElRequisitoParaInscribirse(self)

    method estaEnLasDeCarrerasInscriptas(materia) = self.materiasDeCarrerasInscriptas().contains(materia)

    method materiasDeCarrerasInscriptas() {
        const materiasDeLasCarreras = carrerasInscriptas.map({carrera => carrera.materias()}) 
        return materiasDeLasCarreras.flatten()
    }
}


class Cursada {
    var property materia
    var property nota
}