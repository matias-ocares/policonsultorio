class Appointment < ApplicationRecord
  belongs_to :professional

  validates :date, presence: true, uniqueness: {scope: :professional, message: "El turno ya se encuentra tomado para ese profesional."}, length: {minimum: 2}
  validates :name, presence: true
  validates :surname, presence: true
  validates :phone, presence: true, numericality: true, length: {minimum: 8, maximum: 15}

  validate :past_date
  validate :right_time,

  def past_date
    if(date < DateTime.now)
      errors.add(:date, "La fecha ingresada es pasada.")
    end
  end

  def right_time #valida que la hora del turno sea correcto (hora en punto de 8 a 17 hs.)
    time = date.strftime("%H:%M")
    turnos =['08:00','09:00','10:00','11:00','12:00','13:00','14:00','15:00','16:00','17:00',]
    if(!turnos.include?(time))
      errors.add(:date, "La hora elegida es incorrecta. Debe ser hora exacta entre 08:00 a 17:00.")
    end
  end

end
