# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)

       if user.administracion?
         can :manage, :all
       elsif user.asistencia?
         can :manage, Appointment
         can :read, Professional
       else
        can :read, Appointment #Rol Consulta
        can :read, Professional
       end
  end
end
