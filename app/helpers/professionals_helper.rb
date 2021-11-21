require 'export'
module ProfessionalsHelper

    def export(date)
        ex = Export.new(date)
        puts ex.export(date)
    end


end
