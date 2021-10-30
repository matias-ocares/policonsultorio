# POLYCONSULTORIO
## SEGUNDA ENTREGA: Estado del proyecto al 30/10/2021.
### Correcciones de primer entrega:
Se realizaron las mejoras y correcciones indicadas en la primer entrega:

* Constante PATH se calcular a partir de método **home** de Dir.
* Controla la creación de Professional con caracteres vacíos.
* Si no existe directorio *.polycon*, lo crea.
* Controla el renombre de Professional por un nombre que ya esté en uso.

### Funcionalidades implementadas a la fecha:
#### Pendientes de primer entrega:
Se terminaron de desarrollar los requerimientos planteados en la primer entrega que habían quedado pendientes:
* Show, reschedule, edit, cancel, and cancel all appointments.
#### Segunda entrega:
Se desarrollaron la totalidad de los requerimientos solicitados para la segunda entrega:
* Listar turnos en un día particular para todos los profesionales.
* Listar turnos en un día particular para un profesional particular.
* Listar turnos en una semana a partir de una fecha ingresada para todos los profesionales.
* Listar turnos en una semana y un profesional a partir de una fecha y profesional ingresados.

### Decisiones de diseño:
* Para los nuevos requerimientos nos permitieron asumir que los turnos se dan siempre respetando el horario de comienzo de cada bloque. En este caso decidí manejar turnos de una hora, desde las 8:00 hasta las 17:00 hs inclusive.

* A partir del primer punto mencionado, también podemos asumir que los turnos para un mismo profesional nunca se van a superponer, ya que siempre serán de una hora de duracción arrancando en una hora puntal.

* Para el manejo de comandos, creé dos nuevos comandos **exportday** y **exportweek**. Ambos comandos tienen como argumento requerido la fecha, y como opcional el profesional.

* Para la grilla semanal, a partir de la fecha que se ingresa por comando, se calcula el lunes previo y desde ese lunes se calculan los 5 días siguientes. La grilla se forma de lunes a viernes. Para este cálculo se crearon  2 métodos en el archivo *utils*: **get_monday** y **get_array_week**.

* El archivo con la grilla de turnos se crea en formato html y se guarda dentro del directorio *.polycon*.

## PRIMER ENTREGA: Estado del proyecto al 9/10/2021.

### Estructura del Proyecto:
Dentro del directorio lib/polycon se encuentra Commands (ya provisto por la cátedra), Models (donde se declaran todas las clases del modelo, que hasta el momento son Appointment y Professional) y el archvivo utils.rb donde se ubican métodos que serán de utilidad para los diferentes módulos del proyecto.

Respecto al modelo de datos, como se mencionó anteriormente, hasta el momento cuenta con 2 clases con sus respectivos constructores y métodos de clases e instancia.

En el archivo polycon.rb se declaró, entre otras cosas, la constante PATH para usar y verificar siempre la misma ruta correspondiente al directorio de quien desarrolla "/home/mocares/.polycon/"

### Funcionalidades implementadas a la fecha:

* CRUD de Professional.
* Create - List de Appointment.

### Comandos implementados hasta la fecha:

ruby bin/polycon professionals create NAME  
ruby bin/polycon professionals delate NAME  
ruby bin/polycon professionals list  
ruby bin/polycon professionals rename OLD_NAME NEW_NAME  

ruby bin/polycon appointments create DATE --professional="" --name="" --surname="" --phone="" --notes=""  
ruby bin/polycon appointments list PROFESSIONAL