module Polycon
    module Utils

        def self.polycon_root_exists
            if( Dir.exist?(Polycon::PATH))
              return true
            else
              Dir.mkdir(Polycon::PATH)
              return true
            end
        end

        def self.professional_exists(name)
            Dir.exist? (Polycon::PATH+"#{name}")
          end

        def self.create_professional(name)
            Dir.mkdir (Polycon::PATH+"#{name}")
        end

        def self.guion (name) #Cambiar espacios por guión para profesionales
            return name.gsub " ", "_"
          end

        def self.espacio (name) #Cambiar guiones por espacios para profesionales
            return name.gsub "_", " "
          end
    end
end