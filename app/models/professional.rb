class Professional < ApplicationRecord
    has_many :appointments, dependent: :restrict_with_error
    validates :name, presence:{message: "El nombre es obligatorio."}, uniqueness: {message: "El nombre de profesional no puede repetirse."}
end
