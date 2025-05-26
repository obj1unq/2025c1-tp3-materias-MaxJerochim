import universidad.*
import alumno.*
import carrera.*

class Materia {
    const property correlativas = []
    const property alumnosConfirmados = []
    const property listaDeEspera = []
    var property nombre
    var property cupo = 15
    var property año
    var property creditos = 15
    var property requisito
    var property estrategia = ordenDeLlegada
    var property creditosParaInscribirse = 0

    method inscribirALaMateria(alumno) {
        self.validarSiPuedeInscribirse(alumno)
        self.inscribirSiHayCupo(alumno)
    }

    method inscribirSiHayCupo(alumno) {
        if(self.tieneCupo()) { 
            alumnosConfirmados.add(alumno)
            cupo -= 1
        } else { 
            listaDeEspera.add(alumno) 
        }
    }

    method darDeBaja(alumno) {
        if(self.hayAlumnosEnListaDeEspera()) {
            alumnosConfirmados.remove(alumno)
            self.confirmarUnAlumnoDeListaDeEspera()
        } else {
            alumnosConfirmados.remove(alumno)
            cupo += 1
        }
    }

    method confirmarUnAlumnoDeListaDeEspera() {
        const alumno = estrategia.alumnoDeterminadoPorLaEstrategia(self)
        listaDeEspera.remove(alumno)
        alumnosConfirmados.add(alumno)
    }

    method cumpleElRequisitoParaInscribirse(alumno) {
        return requisito.cumpleElRequisitoParaInscribirse(alumno, self)
    }


    method validarSiPuedeInscribirse(alumno) {
        if(not alumno.puedeInscribirseA(self)) {
            self.error("El alumno no se puede inscribir a esta materia, no cumple con las condiciones.")
        } 
    }


    method tieneCupo() = cupo > 0

    method estaInscripto(alumno) = alumnosConfirmados.contains(alumno)

    method estaEnListaDeEspera(alumno) = listaDeEspera.contains(alumno)

    method esDelAño(añoAConsultar) {
        return año == añoAConsultar
    }

    method hayAlumnosEnListaDeEspera() = !listaDeEspera.isEmpty()

    method carrera() {
        // return universidad.carreraDeMateria(self)
    }
}


object ordenDeLlegada {
    method alumnoDeterminadoPorLaEstrategia(materia) {
        const alumnoDeListaDeEspera = materia.listaDeEspera().head()
        return alumnoDeListaDeEspera
    }
}

object elitista {
    method alumnoDeterminadoPorLaEstrategia(materia) {
        const listaDeEspera = materia.listaDeEspera()
        const mejorPromedio = listaDeEspera.max({alumno => alumno.promedio()})
        return mejorPromedio
    }
}

object gradoDeAvance {
    method alumnoDeterminadoPorLaEstrategia(materia) {
        const listaDeEspera = materia.listaDeEspera()
        const carreraDeMateria = materia.carrera()
        const masAvanzado = listaDeEspera.max({alumno => carreraDeMateria.cantidadDeAprobadasEnCarrera(alumno)})
        return masAvanzado
    }
}


object porAño {
    method cumpleElRequisitoParaInscribirse(alumno, materia) {
        const carrera = materia.carrera()
        const añoAVerificar = materia.año() - 1
        const materiasDelAño = carrera.materiasDelAñoEn(añoAVerificar)

        return materiasDelAño.all({materia => alumno.aprobo(materia)})
    }
}

object porCreditos {
    method cumpleElRequisitoParaInscribirse(alumno, materia) {
        return alumno.creditos() >= materia.creditos()
    }
}

object porNada {
    method cumpleElRequisitoParaInscribirse(alumno, materia) {
        return true
    }
}

// programacion

const elementosDeProgramacion = new Materia(nombre = "Elementos De Programacion", correlativas = [], año = 1, requisito = porNada)
const matematicaI  = new Materia(nombre = "Matematica I", correlativas = [], año = 1, requisito = porNada)
const basesDeDatos = new Materia(nombre = "Bases de Datos", correlativas = [], año = 1, requisito = porNada)
const objetosI     = new Materia(nombre = "Objetos I", correlativas = [], año = 1, requisito = porNada)

const programacionConcurrente = new Materia(nombre = "Programacion Concurrente", correlativas = [objetosI, basesDeDatos], año = 2, creditos = 30, requisito = porAño)
const objetosII    = new Materia(nombre = "Objetos II", correlativas = [objetosI, matematicaI], año = 2, creditos = 30, requisito = porAño)

const objetosIII   = new Materia(nombre = "Objetos III", correlativas = [objetosII, basesDeDatos], año = 3, creditos = 60, requisito = porAño)
const trabajoFinal = new Materia(nombre = "Trabajo Final", correlativas = [], año = 4, creditos = 120, requisito = porCreditos, creditosParaInscribirse = 250)

// medicina

const quimica         = new Materia(nombre = "Quimica", correlativas = [programacion], año = 1, requisito = porNada)
const anatomiaGeneral = new Materia(nombre = "Anatomia General", correlativas = [programacion], año = 1, requisito = porNada)
const biologiaI       = new Materia(nombre = "Biologia I", correlativas = [programacion], año = 1, requisito = porNada)

const biologiaII      = new Materia(nombre = "Biologia II", correlativas = [biologiaI], año = 2, creditos = 30, requisito = porAño)

// derecho

const latin          = new Materia(nombre = "Latin", correlativas = [], año = 1, requisito = porNada)
const derechoRomano  = new Materia(nombre = "Derecho Romano", correlativas = [], año = 1, requisito = porNada)
const derechoPenalI  = new Materia(nombre = "Derecho Penal I", correlativas = [], año = 1, requisito = porNada)
const historiaDeDerechoArgentino = new Materia(nombre = "Historia de Derecho Argentino", correlativas = [], año = 1, requisito = porNada)

const derechoPenalII = new Materia(nombre = "Derecho Penal II", correlativas = [derechoPenalI], año = 2, creditos = 30, requisito = porAño)