module Polycon
    module Models
      class Professional

        attr_accessor :name

        def self.create(name)
            name = Polycon::Utils::guion (name)
              if Polycon::Utils::professional_exists(name)
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
          if Polycon::Utils::professional_exists(old_name)
            File.rename("/home/mocares/.polycon/#{old_name}","/home/mocares/.polycon/#{new_name}")
            return true
          end
          return false
        end

        def self.list
            Dir.children("/home/mocares/.polycon/").map{|element|Polycon::Utils::espacio(element)}
           
        end
      end
    end
end