module Polycon
  module Commands
    module Professionals
      class Create < Dry::CLI::Command
        desc 'Create a professional'

        argument :name, required: true, desc: 'Full name of the professional'

        example [
          '"Alma Estevez"      # Creates a new professional named "Alma Estevez"',
          '"Ernesto Fernandez" # Creates a new professional named "Ernesto Fernandez"'
        ]

        def call(name:, **)
          if(name.empty?)
            warn "Ingreso un campo vacío."
          else
          if(Polycon::Utils::polycon_root_exists)
            crear = Models::Professional.create(name)
            if(crear)
              warn "Se cargó el profesional #{name} exitosamente."
            else
              warn "Ya existia el profesional #{name}."
            end
          else
            warn "El directorio Polycon no existe"
          end
        end
        end
      end

      class Delete < Dry::CLI::Command
        desc 'Delete a professional (only if they have no appointments)'

        argument :name, required: true, desc: 'Name of the professional'

        example [
          '"Alma Estevez"      # Deletes a new professional named "Alma Estevez" if they have no appointments',
          '"Ernesto Fernandez" # Deletes a new professional named "Ernesto Fernandez" if they have no appointments'
        ]

        def call(name: nil)
          if(Polycon::Utils::polycon_root_exists)
            if(Polycon::Utils::professional_exists(Polycon::Utils::guion(name)))
              del=Models::Professional::delete(name)
              if(del)
                warn"Se elminió el profesional #{name} correctamente."
              else
                warn"El profesional #{name} tiene turnos, no puede ser borrado."
              end
            else
              warn"El profesional #{name} no existe."
            end
          else
            warn "El directorio Polycon no existe"
          end
        end
      end

      class List < Dry::CLI::Command
        desc 'List professionals'

        example [
          "          # Lists every professional's name"
        ]

        def call(*)
          if(Polycon::Utils::polycon_root_exists)
            lista = Models::Professional.list
            if (lista.length()>0)
              puts lista
            else
              warn"No hay profesionales para mostrar."
            end
          else
            warn "El directorio Polycon no existe"
          end
        end
      end

      class Rename < Dry::CLI::Command
        desc 'Rename a professional'

        argument :old_name, required: true, desc: 'Current name of the professional'
        argument :new_name, required: true, desc: 'New name for the professional'

        example [
          '"Alna Esevez" "Alma Estevez" # Renames the professional "Alna Esevez" to "Alma Estevez"',
        ]

        def call(old_name:, new_name:, **)
          if(Polycon::Utils::polycon_root_exists)
            puts Models::Professional.rename(old_name, new_name)
          else
            warn "El directorio Polycon no existe"
          end
        end
      end
    end
  end
end
