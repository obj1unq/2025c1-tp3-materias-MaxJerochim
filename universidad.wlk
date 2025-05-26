import carrera.*
import materia.*
import alumno.*

object universidad {
    // const property genera getter solamente
    const property carrerasDeLaUniversidad = [medicina, programacion, derecho]
    
    method aprobar(materia, nota, alumno){
        const cursada = new Cursada(materia = materia, nota = nota)
        alumno.agregarNuevaCursada(cursada)
    }

    method inscribirMateria(materia, alumno){
        materia.inscribirAMateria(alumno)
    }

    method inscribirACarrera(carrera, alumno) {
        alumno.inscribirACarrera(carrera)
    }

    method darDeBajaEnMateria(materia, alumno) {
        materia.darDeBaja(alumno)
    }

    method carreraTieneMateria(materia) {
        return carrerasDeLaUniversidad.find({carrera => carrera.tieneLaMateria(materia)})
    }

}