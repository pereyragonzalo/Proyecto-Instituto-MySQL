# Instituto SQL Database Script

Este proyecto contiene un script SQL para crear y gestionar una base de datos llamada `instituto`. La base de datos está diseñada para un instituto educativo y contiene varias tablas relacionadas con alumnos, profesores, carreras, cursos, inscripciones, y más.

## Estructura del Script

1. **Creación de la Base de Datos**
   - Verifica si la base de datos `instituto` ya existe.
   - Si no existe, crea la base de datos junto con sus archivos de datos y log.
   - Modifica la base de datos para añadir un archivo `.ndf` adicional para distribuir la carga.

2. **Creación de Tablas**
   - Tablas principales: `profesor`, `alumno`, `carrera`, `curso`, `inscripcion`, `pension`, `carrera_curso`, `catedra`.
   - Cada tabla es creada solo si no existe previamente.
   - Se definen claves primarias y claves foráneas para mantener la integridad referencial entre las tablas.

3. **Inserción de Datos**
   - Datos iniciales para las tablas `profesor`, `alumno`, `carrera`, `curso`, `inscripcion`, `pension`, `carrera_curso`, y `catedra`.

4. **Consultas SQL**
   - Se incluyen varias consultas para:
     - Obtener datos específicos de las tablas.
     - Realizar selecciones y filtrados basados en condiciones.
     - Ordenar y agrupar resultados.

5. **Procedimientos Almacenados**
   - Procedimientos para insertar, actualizar, y eliminar datos en las tablas.
   - Ejemplos incluyen la inserción de nuevos profesores, cursos, inscripciones, y más.

6. **Vistas**
   - Se crean varias vistas para facilitar el acceso a datos específicos:
     - `vista_cursos`: Cursos con precio mayor o igual a 200.
     - `vista_profesor`: Profesores con apellido 'Paredes'.
     - `vista_inscripciones_sistemas`: Inscripciones en la carrera de Ingeniería en Sistemas.
     - `vista_alumnos_basica`: Información básica de los alumnos.
     - `vista_alumnos_inscripciones`: Alumnos con sus fechas de inscripción.

7. **Eliminación de la Base de Datos**
   - Finalmente, se incluye una instrucción para eliminar la base de datos `instituto` si se desea.

## Ejecución

Para ejecutar este script:

1. Abra su entorno de administración de SQL Server (SSMS).
2. Copie y pegue el script en una nueva consulta.
3. Ejecute el script para crear la base de datos y sus componentes.

## Notas

- Asegúrese de que las rutas especificadas para los archivos de base de datos (`.mdf`, `.ldf`, `.ndf`) sean correctas y accesibles en su sistema.
- Revise los procedimientos almacenados y las vistas para adaptarlas a sus necesidades específicas.
