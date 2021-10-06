module Polycon
    module Models
      class Appointment
        attr_accessor :name

        def self.create(date, name)
            name=Polycon::Utils::guion(name)
            if(File.exist?(Polycon::PATH+"#{name}"+"/"+"#{date}"+".paf"))
                return false
            else
                File.open(Polycon::PATH+"#{name}"+"/"+"#{date}"+".paf", "w")
                return true
            end
        end
        def initialize (name)
          self.name = name
        end
      end
    end
end
