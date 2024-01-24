class Team < ApplicationRecord
    has_and_belongs_to_many :users
    belongs_to :championship

    has_one :round
end
