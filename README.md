# POLYCONSULTORIO
## SEGUNDA ENTREGA: Estado del proyecto al 30/10/2021.
### Correcciones de primer entrega:

* Constante PATH se calcular a partir de método home de Dir.
* Controla la creación de Professional con caracteres vaciós.
* Si no existe directorio .polycon, lo crea.
* Controla el renombre de Professional por un nombre que ya esté en uso.

### Funcionalidades implementadas a la fecha:
#### Pendientes de primer entrega:
* Show, reschedule, edit, cancel, and cancel all appointments.
#### Segunda entrega:
* Hola

# -----------------------------------------------------------

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