module Polycon
    module Models
      class Professional

        attr_accessor :name

        def self.create(name)
            name = Polycon::Utils::guion (name)
              if Polycon::Utils.professional_exists(name)
                return false
              end
              new(name)
              Polycon::Utils.create_professional(name)
              return true
        end

        def initialize (name)
          self.name = name
        end

        def self.rename(old_name, new_name)
          old_name = Polycon::Utils::guion (old_name)
          new_name = Polycon::Utils::guion (new_name)
          if(Polycon::Utils::professional_exists(new_name))
            return "El nuevo nombre de profesional ya está en uso."
          else
            if Polycon::Utils::professional_exists(old_name)
              File.rename(Polycon::PATH+"#{old_name}",Polycon::PATH+"#{new_name}")
              return "Se modificó el nombre del profesional correctamente."
            end
            return "El profesional que intenta modificar no existe."
          end
        end

        def self.list
            Dir.children(Polycon::PATH).map{|element|Polycon::Utils::espacio(element)}
           
        end

        def self.delete(name)
          name = Polycon::Utils::guion (name)
          if(Dir.empty?(Polycon::PATH+"#{name}")) #pregunto si el directorio está vacío
            Dir.rmdir(Polycon::PATH+"#{name}")
            return true
          else
            return false
          end
        end
        

      end
    end
end