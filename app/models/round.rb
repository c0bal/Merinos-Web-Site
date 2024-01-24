class Round < ApplicationRecord
  belongs_to :team
  has_many :holes, dependent: :destroy
  accepts_nested_attributes_for :holes, allow_destroy: true

  after_initialize :build_default_holes, if: :new_record?

  def build_default_holes
    (1..9).each { |number| holes.build(number: number, score: 0) }
  end
  
  def total_score
    holes.sum(:score)
  end

  def num_holes
    holes.where.not(score: 0).count
  end
end