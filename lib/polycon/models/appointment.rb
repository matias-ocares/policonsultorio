module Polycon
    module Models
      class Appointment
        attr_accessor :name

        def self.create(date, name)
            name=Polycon::Utils::guion(name)
            path = Polycon::PATH+"#{name}"+"/"+"#{date}"+".paf"
            if(File.exist?(path))
                return false
            else
                File.open(path, "w")
                return true
            end
        end
        def initialize (name)
          self.name = name
        end
      end
    end
end
