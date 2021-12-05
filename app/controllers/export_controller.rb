require 'export_helper'
class ExportController < ApplicationController

    def index
        if params[:date].present?
        
            if !params[:week] #Sólo exporta un día.
                if params[:name].present?
                    ex = ExportHelper::Export.new(params[:date])
                    message = ex.exportprof(params[:date], params[:name])
                else
                    ex = ExportHelper::Export.new(params[:date])
                    message = ex.export(params[:date])
                end
            else
                #Exporta semana completa
                date = get_monday(params[:date])
                week = get_array_week(date)
                if params[:name].present?
                    ex = ExportHelper::Export.new(week)
                    message= ex.exportweekprof(week, params[:name])
                else
                    ex = ExportHelper::Export.new(week)
                    message = ex.exportweek(week)
                end
                
            end
            redirect_to export_index_url, notice: message
            
        end
    end

    def get_monday(date)
        date = Date.parse date
        date = date -((date.wday - 1)%7)
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