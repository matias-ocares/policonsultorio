# POLYCONSULTORIO
## CORRECCIONES - TERCER ENTREGA: Estado del proyecto al 16/12/2021.
Se realizaron las correcciones marcadas respecto a la última entrega.
* Las grillas semanales ahora exportan correctamente desde el día lunes respecto a la fecha ingresada.

* Al exportar grillas ahora se permite la descarga del archivo desde el browser. Esto se resolvió haciendo uso del método *send_data*.


## TERCER ENTREGA: Estado del proyecto al 05/12/2021.
Se realizaron los requerimientos detallados para la última entrega.

Se adaptaron los requerimientos desarrollados en las primeras entregas dentro de una aplicación web Ruby on Rails.

De las entregas anteriores se mantuvo el modelo original de Appointment y Professional, habiendo incorporando User.

Los elementos del modelo de datos ya no son persistidos en archivos y directorios, para esta nueva etapa hice uso de *ActiveRecord* y *sqlite3*.

* Para el manejo de sesión de usuarios se utilizó la gema *devise*.
* Para la validación de roles y permisos se utilizó la gema *cancancan*.

En el archivo *seeds* se cargó un set inicial de 3 usuarios con sus roles respectivos, 2 profesionales y 2 turnos para poder comenzar con una prueba de la aplicación.
* Este set de datos debe cargarse corriendo el comando *rails db:seed*. Previamente se debe correr el comando *rails db:migrate*.

De las entregas anteriores se mantuvieron la totalidad de las restricciones y reglas de negocio indicadas. Por ejemplo: no poder crear 2 turnos simultáneos para un mismo profesional, no poder borrar profesional con turnos asociados, no poder cargar 2 profesionales con el mismo nombre, no poder crear turnos con fechas pasadas, sólo permitir creación de turnos en horas exactas de 8 a 17 hs., poder exportar grilla de turnos de 4 tipos (diaria o semanal, ambas con un profesional específico o para todos los profesionales), etc.

Para esta nueva entrega se incorporaron las restricciones vinculadas a los usuarios y roles:
* El rol Administración habilita la gestión de la totalidad de las funcionalidades, incluyendo la de crear y modificar usuarios.
* El rol Asistencia habilita la gestión de turnos, y la consulta de profesionales.
* El rol Consulta sólo habilita consulta de turnos y profesionales.
* *Para los 3 perfiles se habilitó la opción de exportar grilla de turnos.*



## SEGUNDA ENTREGA: Estado del proyecto al 30/10/2021.
### Correcciones de primer entrega:
Se realizaron las mejoras y correcciones indicadas en la primer entrega:

* Constante PATH se calcula a partir de método **home** de Dir.
* Controla la creación de Professional con caracteres vacíos.
* Si no existe directorio *.polycon*, lo crea.
* Controla el renombre de Professional por un nombre que ya esté en uso.

### Funcionalidades implementadas a la fecha:
#### Pendientes de primer entrega:
Se terminaron de desarrollar los requerimientos planteados en la primer entrega que habían quedado pendientes:
* Show, reschedule, edit, cancel, and cancel all appointments.
#### Segunda entrega:
Se desarrollaron la totalidad de los requerimientos solicitados para la segunda entrega:
* Crear grilla turnos en un día particular para todos los profesionales.
* Crear grilla turnos en un día particular para un profesional particular.
* Crear grilla turnos en una semana a partir de una fecha ingresada para todos los profesionales.
* Crear grilla turnos en una semana y un profesional a partir de una fecha y profesional ingresados.

### Decisiones de diseño:
* Para los nuevos requerimientos nos permitieron asumir que los turnos se dan siempre respetando el horario de comienzo de cada bloque. En este caso decidí manejar turnos de una hora, desde las 8:00 hasta las 17:00 hs inclusive.

* A partir del primer punto mencionado, también podemos asumir que los turnos para un mismo profesional nunca se van a superponer, ya que siempre serán de una hora de duracción arrancando en una hora puntual.

* Para el manejo de comandos, creé dos nuevos comandos **exportday** y **exportweek**. Ambos comandos tienen como argumento requerido la fecha, y como opcional el profesional.

* Para la creación de la grilla hice uso de la librería ERB.

* Para la grilla semanal, a partir de la fecha que se ingresa por comando, se calcula el lunes previo y desde ese lunes se calculan los 5 días siguientes. La grilla se forma de lunes a viernes. Para este cálculo se crearon  2 métodos en el archivo *utils*: **get_monday** y **get_array_week**.

* El archivo con la grilla de turnos se crea en formato html y se guarda dentro del directorio *.polycon*.

### Comandos implementados para la segunda entrega:
ruby bin/polycon appointments show DATE --professional=""  
ruby bin/polycon appointments reschedule OLD_DATE NEW_DATE --professional=""  
ruby bin/polycon appointments edit DATE --professional="" --name="new name"  
ruby bin/polycon appointments cancel DATE --professional=""  
ruby bin/polycon appointments cancel-all PROFESSIONAL  

ruby bin/polycon appointments exportday DATE  
ruby bin/polycon appointments exportday DATE --professional=""  
ruby bin/polycon appointments exportweek DATE  
ruby bin/polycon appointments exportweek DATE --professional=""


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