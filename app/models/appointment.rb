class Appointment < ApplicationRecord
  belongs_to :professional

  validates :date, presence: true, uniqueness: {scope: :professional, message: "El turno ya se encuentra tomado para ese profesional."}, length: {minimum: 2}
  validates :name, presence: true
  validates :surname, presence: true
  validates :phone, presence: true
end
