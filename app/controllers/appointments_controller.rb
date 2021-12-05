class AppointmentsController < ApplicationController
  load_and_authorize_resource
  before_action :set_professional
  #before_action :set_appointment, only: [:show, :edit, :update, :destroy]

  # GET /appointments
  def index
    if params[:fecha].present?
      fecha=Date.parse(params[:fecha])
      @appointments = Appointment.where(:date=> fecha.beginning_of_day..fecha.end_of_day, professional: @professional)
    else
      @appointments = @professional.appointments
    end 
  end

  # GET /appointments/1
  def show
  end

  # GET /appointments/new
  def new
    @appointment = @professional.appointments.new
  end

  # GET /appointments/1/edit
  def edit
  end

  # POST /appointments
  def create
    @appointment = @professional.appointments.new(appointment_params)

    if @appointment.save
      redirect_to [@appointment.professional, @appointment], notice: 'Appointment was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /appointments/1
  def update
    if @appointment.update(appointment_params)
      redirect_to [@appointment.professional, @appointment], notice: 'Appointment was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /appointments/1
  def destroy
    @appointment.destroy
    redirect_to professional_appointments_url, notice: 'Se canceló el turno correctamente.'
  end

  #DELETE ALL
  def delete_all
    @professional.appointments.destroy_all
    redirect_to professional_appointments_url, notice: 'Se cancelaron todos los turnos.'
  end


  private
    def set_professional
      @professional = Professional.find(params[:professional_id])  
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_appointment
      @appointment = @professional.appointments.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def appointment_params
      params.require(:appointment).permit(:date, :name, :surname, :phone, :notes, :belongs_to)
    end
end
