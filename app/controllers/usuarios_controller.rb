class UsuariosController < ApplicationController
  #load_and_authorize_resource
  before_action :set_usuario, only: [:show, :edit, :update, :destroy]

  # GET /usuarios
  def index
    @usuarios = User.all
    authorize! :read, @usuarios
  end

  # GET /usuarios/1
  def show
  end

  # GET /usuarios/new
  def new
    @usuario = User.new
  end

  # GET /usuarios/1/edit
  def edit
  end

  # POST /usuarios
  def create
    @usuario = User.new(usuario_params)

    if @usuario.save
      redirect_to usuarios_url, notice: 'Se creó el usuario correctamente.'
    else
      render :new
    end
  end

  # PATCH/PUT /usuarios/1
  def update
    if @usuario.update(usuario_params)
      redirect_to usuarios_url, notice: 'Se modificó el usuario correctamente.'
    else
      render :edit
    end
  end

  # DELETE /usuarios/1
  def destroy
    @usuario.destroy
    redirect_to usuarios_url, notice: 'Usuario was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_usuario
      @usuario = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def usuario_params
      params.require(:usuario).permit(:email, :password, :role)
    end
end
