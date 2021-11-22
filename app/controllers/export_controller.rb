require 'export_helper'
class ExportController < ApplicationController

    def index
        if params[:date].present?
            if params[:name].present?
                ex = Export.new(params[:date])
                ex.exportprof(params[:date], params[:name])
            else
                ex = ExportHelper::Export.new(params[:date])
                ex.export(params[:date])
            end
        end
    end

end