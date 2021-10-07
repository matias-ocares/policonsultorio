require 'date'
module Polycon
    module Models
      class Appointment
        attr_accessor :date, :professional, :name, :surname, :phone, :notes

        def self.create(date, professional, name, surname, phone, notes)
            professional=Polycon::Utils::guion(professional)
            appointment = Appointment.new(date,professional,name,surname,phone,notes)
            if(appointment.valid?)
              path = Polycon::PATH+"#{professional}"+"/"+"#{date}"+".paf"
              if(File.exist?(path))
                return "El turno se encuentra tomado."
             
              else
                  File.open(path, "w") do |fichero|
                    fichero.puts(surname)
                    fichero.puts(name)
                    fichero.puts(phone)
                    if(notes!= nil)
                      fichero.puts(notes)
                    end
                  end
                  return "Se creó el turno para #{name} #{surname} correctamente."
             end
            end
            
        end
        def valid?
          valid_date?(date) && valid_professional?(professional)
        end
        def valid_date?(date)
           Date.strptime(date, '%Y-%m-%d %H:%M')
           true
        rescue ArgumentError
           puts "Formato de fecha invalidad invalida."
        end
        def valid_professional?(professional)
          Polycon::Utils.professional_exists(Polycon::Utils.guion(professional))
          
            rescue ArgumentError
            puts"El profesional no existe." #no funciona ese mensaje
            
      end

        def initialize (date, professional, name, surname, phone, notes)
          @date = date
          @professional = professional
          @name= name
          @surname = surname
          @phone = phone
          @notes = notes
        end
      end
    end
end
