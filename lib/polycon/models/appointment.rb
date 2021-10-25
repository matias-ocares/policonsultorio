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
      
      def self.list(professional)
        Dir.children(Polycon::PATH+"#{professional}").map{|element|element.gsub(".paf","")}
       
    end
        def initialize (date, professional, name, surname, phone, notes)
          @date = date
          @professional = professional
          @name= name
          @surname = surname
          @phone = phone
          @notes = notes
        end

        def self.show(date, professional)
          turno=File.read(PATH+"#{professional}"+"/"+"#{date}"+".paf").split("\n")
          
          { date: date,
            professional: professional,
            name:turno[0],
            surname:turno[1],
            phone:turno[2],
            notes:turno[3]
          }
        end

        def self.edit(date, professional, **options)
          professional=Polycon::Utils::guion(professional)
          path = Polycon::PATH+"#{professional}"+"/"+"#{date}"+".paf"
          if(File.exist?(path))
            turno = show(date, professional).merge(options)
            file = File.open(PATH+"#{professional}"+"/"+"#{date}"+".paf", 'w')
            file.puts(turno[:surname])
            file.puts(turno[:name])
            file.puts(turno[:phone])
            if(turno[:notes]!= nil)
              file.puts(turno[:notes])
            end
          return "Se modificó el turno exitosamente."
        else
          return "El turno ingresado no existe."
          
        end
      end

      def self.reschedule(old_date, new_date, professional)
        new_path = Polycon::PATH+"#{professional}"+"/"+"#{new_date}"+".paf"
        if(File.exist?(new_path))
          return "El turno para #{new_date} ya se encuentra tomado"
        else
          old_path = Polycon::PATH+"#{professional}"+"/"+"#{old_date}"+".paf"
          if(File.exist?(old_path))
            File.rename(old_path, new_path)
            return "Se reprogramó el turno."
          else
            return "El turno #{old_date} para el profesional #{professional} no existe"
          end
        end

      end


      end
    end
end
