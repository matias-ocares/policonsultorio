module Polycon
    module Utils

        def self.polycon_root_exists
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
    end
end