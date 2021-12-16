require 'export_helper'
class ExportController < ApplicationController

    def index
        if params[:date].present?
        
            if !params[:week] #Sólo exporta un día.
                if params[:name].present?
                    ex = ExportHelper::Export.new(params[:date])
                    grilla = ex.exportprof(params[:date], params[:name])
                    send_data grilla, filename: "grilla-diaria-profesional.html"
                else
                    ex = ExportHelper::Export.new(params[:date])
                    grilla = ex.export(params[:date])
                    send_data grilla, filename: "grilla-diaria.html"
                end
            else
                #Exporta semana completa
                date = get_monday(params[:date])
                week = get_array_week(date)
                if params[:name].present?
                    ex = ExportHelper::Export.new(week)
                    grilla = ex.exportweekprof(week, params[:name])
                    send_data grilla, filename: "grilla-semanal-profesional.html"
                else
                    ex = ExportHelper::Export.new(week)
                    grilla = ex.exportweek(week)
                    send_data grilla, filename: "grilla-semanal.html"
                end
                
            end
            #redirect_to export_index_url, notice: message
            
        end
    end

    def get_monday(date)
        date = Date.parse date
        date = date - date.wday.days
        return date
      end

    def get_array_week(date)
        week=[]
        for a in 1..5 do          
        day = date.next_day(a)
        week << day.to_s
        end
        return week    
      end

end