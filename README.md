#POLYCONSULTORIO
##Estado del proyecto al 9/19/2021: Primer Entrega

### Estructura del Proyecto:
Dentro del directorio lib/polycon polycon se encuentra Commands (ya provisto por la cátedra), Models (donde se declaran todas las clases del modelo, que hasta el momento son Appointment y Professional) y utils, donde se ubican métodos que serán de utilidad para los diferentes módulos del proyecto.

Respecto al modelo de datos, como se mencionó anteriormente, hasta el momento cuenta con 2 clases con sus respectivos constructores y métodos de clases e instancia.

### Funcionalidades implementadas a la fecha:

*CRUD de Professional.
*Create, List de Appointment.

### Comandoidos implementados hasta la fecha:

ruby bin/polycon professionals create NAME
ruby bin/polycon professionales delate NAME
ruby bin/polycon professionals list
ruby bin/polycon professionals rename OLD_NAME NEW_NAME

ruby bin/polycon appointments create DATE --professional="" --name="" --surname="" --phone="" --notes=""
ruby bin/polycon appointments list PROFESSIONAL