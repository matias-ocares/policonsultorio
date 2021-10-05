module Polycon
    module Utils

        def self.polycon_root_exists
            Dir.exist?("/home/mocares/.polycon")
        end

        def self.professional_exists(name)
            Dir.exist? ("/home/mocares/.polycon/#{name}")
        end

        def self.create_professional(name)
            FileUtils.mkdir_p "/home/mocares/.polycon/#{name}"
        end

        def self.guion (name) #Cambiar espacios por guión para profesionales
            return name.gsub " ", "_"
          end

        def self.espacio (name) #Cambiar guiones por espacios para profesionales
            return name.gsub "_", " "
          end
    end
end