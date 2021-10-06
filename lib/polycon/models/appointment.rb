module Polycon
    module Models
      class Appointment
        attr_accessor :name

        def self.create(date, name)
            name=Polycon::Utils::guion(name)
            File.open(Polycon::PATH+"#{name}"+"/"+"#{date}"+".paf", "w")
        end
        def initialize (name)
          self.name = name
        end
      end
    end
end
