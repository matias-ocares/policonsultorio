class Appointment < ApplicationRecord
  belongs_to :professional

  #validates :date, presense: true, uniqueness: {scope: :professional, message: "Ya existe para ese profesional."}, length: {minimum: 2}
  validates :name, presence: true
  validates :surname, presence: true
  validates :phone, presence: true
end
