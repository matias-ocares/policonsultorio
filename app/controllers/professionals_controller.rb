class ProfessionalsController < ApplicationController
  before_action :set_professional, only: [:show, :edit, :update, :destroy]

  # GET /professionals
  def index
    @professionals = Professional.all
  end

  # GET /professionals/1
  def show
  end

  # GET /professionals/new
  def new
    @professional = Professional.new
  end

  # GET /professionals/1/edit
  def edit
  end

  # POST /professionals
  def create
    if(professional_exists(professional_params[:name]))
      @professional = Professional.new(professional_params)

      if @professional.save
        redirect_to @professional, notice: 'El profesional '+professional_params[:name]+' fue creado exitosamente.'
      else
        render :new
      end
    else
      redirect_to professionals_url,  notice: 'El profesional '+professional_params[:name]+' ya existe.'
    end
  end

  # PATCH/PUT /professionals/1
  def update
    if @professional.update(professional_params)
      redirect_to @professional, notice: 'Professional was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /professionals/1
  def destroy
    if(has_appointments(@professional))
      @professional.destroy
      redirect_to professionals_url, notice: 'El profesional '+@professional.name+' fue eliminado correctamente.'
    else
      redirect_to professionals_url, notice: 'El profesional '+@professional.name+' tiene turnos asignados. No pudo eliminarse.'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_professional
      @professional = Professional.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def professional_params
      params.require(:professional).permit(:name)
    end

#Validaciones-----------

  def professional_exists (professional)
    return !(Professional.exists?(name: professional))
  end

  def has_appointments(professional)
    return !(professional.appointments.size >0)
  end
end
