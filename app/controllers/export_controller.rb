require 'export_helper'
class ExportController < ApplicationController

    def index
        if params[:date].present?
            ex = Export.new(params[:date])
            puts ex.export(params[:date])
        end
    end

end