import materia.*
import universidad.*
import alumno.*

class Carrera {
    const property materias = []

    method materiasAprobadas(alumno) {
       const materiasAprobadas = materias.filter({materia => alumno.aprobo(materia)})
       return materiasAprobadas.size()
    }

    method materiasEnElAño(año) {
        return materias.filter({materia => materia.esDeAño(año)})
    }
    
    method tieneMateria(_materia) {
        return materias.any({materia => materia.nombre() == _materia.nombre()})
    }

}

const medicina = new Carrera(materias = [quimica, anatomiaGeneral, biologiaI, biologiaII])

const programacion = new Carrera(materias = [elementosDeProgramacion, matematicaI, basesDeDatos, objetosI, objetosII, programacionConcurrente, trabajoFinal])

const derecho = new Carrera(materias = [latin, derechoRomano, historiaDeDerechoArgentino, derechoPenalI, derechoPenalII])