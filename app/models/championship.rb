class Championship < ApplicationRecord
    has_and_belongs_to_many :users
    has_many :teams

    validates :estado, inclusion: { in: %w[preparacion en_progreso finalizado] }
end
