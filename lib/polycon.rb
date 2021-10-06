module Polycon
  autoload :Polycon, 'polycon/models'
  autoload :VERSION, 'polycon/version'
  autoload :Commands, 'polycon/commands'
  autoload :Utils, 'polycon/utils'
  autoload :Models, 'polycon/models/professional'
  autoload :Professional, 'polycon/models/professional'
  autoload :Appointment, 'polycon/models/appointment'
  
  PATH= "/home/mocares/.polycon/"

  # Agregar aquí cualquier autoload que sea necesario para que se cargue las clases y
  # módulos del modelo de datos.
  # Por ejemplo:
  # autoload :Appointment, 'polycon/appointment'
end
