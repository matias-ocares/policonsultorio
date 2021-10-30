require 'polycon/models/appointment'
require 'polycon/export/export'

module Polycon
  module Commands
    module Appointments
      class Create < Dry::CLI::Command
        desc 'Create an appointment'

        argument :date, required: true, desc: 'Full date for the appointment'
        option :professional, required: true, desc: 'Full name of the professional'
        option :name, required: true, desc: "Patient's name"
        option :surname, required: true, desc: "Patient's surname"
        option :phone, required: true, desc: "Patient's phone number"
        option :notes, required: false, desc: "Additional notes for appointment"

        example [
          '"2021-09-16 13:00" --professional="Alma Estevez" --name=Carlos --surname=Carlosi --phone=2213334567'
        ]

        def call(date:, professional:, name:, surname:, phone:, notes: nil)
        if(Polycon::Utils::polycon_root_exists)
            puts Models::Appointment.create(date, professional, name, surname, phone, notes)
        else
          warn "El directorio Polycon no existe"
        end
        end
      end
      class Show < Dry::CLI::Command
        desc 'Show details for an appointment'

        argument :date, required: true, desc: 'Full date for the appointment'
        option :professional, required: true, desc: 'Full name of the professional'

        example [
          '"2021-09-16 13:00" --professional="Alma Estevez" # Shows information for the appointment with Alma Estevez on the specified date and time'
        ]

        def call(date:, professional:)
          professional = Polycon::Utils.guion(professional)
          if(Polycon::Utils::polycon_root_exists)
            Models::Appointment.show(date,professional).each do |clave, valor|
              puts "#{clave}: #{valor}"
            end
          end
        end
      end

      class Cancel < Dry::CLI::Command
        desc 'Cancel an appointment'

        argument :date, required: true, desc: 'Full date for the appointment'
        option :professional, required: true, desc: 'Full name of the professional'

        example [
          '"2021-09-16 13:00000000" --professional="Alma Estevez" # Cancels the appointment with Alma Estevez on the specified date and time'
        ]

        def call(date:, professional:)
          professional = Polycon::Utils.guion(professional)
          puts Models::Appointment.cancel(date, professional)
        end
      end

      class CancelAll < Dry::CLI::Command
        desc 'Cancel all appointments for a professional'

        argument :professional, required: true, desc: 'Full name of the professional'

        example [
          '"Alma Estevez" # Cancels all appointments for professional Alma Estevez',
        ]

        def call(professional:)
          professional = Polycon::Utils.guion(professional)
          puts Models::Appointment.cancelall(professional)
        end
      end

      class List < Dry::CLI::Command
        desc 'List appointments for a professional, optionally filtered by a date'

        argument :professional, required: true, desc: 'Full name of the professional'
        option :date, required: false, desc: 'Date to filter appointments by (should be the day)'

        example [
          '"Alma Estevez" # Lists all appointments for Alma Estevez',
          '"Alma Estevez" --date="2021-09-16" # Lists appointments for Alma Estevez on the specified date'
        ]

        def call(professional:)
          if(Polycon::Utils::polycon_root_exists)
            lista = Models::Appointment.list(Polycon::Utils.guion(professional))
            if (lista.length()>0)
              puts lista
            else
              warn"No hay profesionales para mostrar."
            end
          else
            warn "El directorio Polycon no existe"
          end
        end
    
      end

      class Reschedule < Dry::CLI::Command
        desc 'Reschedule an appointment'

        argument :old_date, required: true, desc: 'Current date of the appointment'
        argument :new_date, required: true, desc: 'New date for the appointment'
        option :professional, required: true, desc: 'Full name of the professional'

        example [
          '"2021-09-16 13:00" "2021-09-16 14:00" --professional="Alma Estevez" # Reschedules appointment on the first date for professional Alma Estevez to be now on the second date provided'
        ]

        def call(old_date:, new_date:, professional:)
          professional = Polycon::Utils.guion(professional)
          puts Models::Appointment.reschedule(old_date, new_date, professional)
        end
      end
    
      class Edit < Dry::CLI::Command
        desc 'Edit information for an appointments'

        argument :date, required: true, desc: 'Full date for the appointment'
        option :professional, required: true, desc: 'Full name of the professional'
        option :name, required: false, desc: "Patient's name"
        option :surname, required: false, desc: "Patient's surname"
        option :phone, required: false, desc: "Patient's phone number"
        option :notes, required: false, desc: "Additional notes for appointment"

        example [
          '"2021-09-16 13:00" --professional="Alma Estevez" --name="New name" # Only changes the patient\'s name for the specified appointment. The rest of the information remains unchanged.',
          '"2021-09-16 13:00" --professional="Alma Estevez" --name="New name" --surname="New surname" # Changes the patient\'s name and surname for the specified appointment. The rest of the information remains unchanged.',
          '"2021-09-16 13:00" --professional="Alma Estevez" --notes="Some notes for the appointment" # Only changes the notes for the specified appointment. The rest of the information remains unchanged.',
        ]

        def call(date:, professional:, **options)
          professional = Polycon::Utils.guion(professional)
          if(Polycon::Utils::polycon_root_exists)
            puts Models::Appointment.edit(date, professional, **options)
          end
        end
      end


    #COMANDOS ENTREGA 2
    class ExportDay < Dry::CLI::Command
      desc 'Exportar appointments por dia'

      argument :date, required: true, desc: 'Full date for the appointments'
      option :professional, required: false, desc: 'Full name of the professional'

      example [
        '"2021-09-16 15:00" --professional="Alma Estevez" # Exporta todos los turnos para ese día y para ese profesional particular'
      ]

      def call(date:, professional:nil)     
        if(professional== nil)
          puts "No profe"
            ex = Export.new(date)
            puts ex.export(date)
        else
          professional=Polycon::Utils::guion(professional)
          path = Polycon::PATH+"#{professional}"
          if(File.exist?(path))
            ex = Export.new(date)
            puts ex.exportprof(date, professional)
          else
            puts "No existe el profesional #{professional}"
          end
        end
      end
    end

    class ExportWeek < Dry::CLI::Command
      desc 'Exportar appointments por semana'

      argument :date, required: true, desc: 'Full date for the appointments'
      option :professional, required: false, desc: 'Full name of the professional'

      example [
        '"2021-09-16 15:00" --professional="Alma Estevez" # Exporta todos los turnos para ese día y para ese profesional particular'
      ]

      def call(date:, professional:)
        professional=Polycon::Utils::guion(professional)
        path = Polycon::PATH+"#{professional}"
        if(File.exist?(path))
          ex = Export.new(date)
          puts ex.export(date, professional)
        else
          puts "No existe el profesional #{professional}"
        end
      end
    end
    end
  end
end