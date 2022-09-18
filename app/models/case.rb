class Case < ApplicationRecord
  belongs_to :suite, counter_cache: true

  has_many :case_steps, dependent: :destroy
  has_many :steps, through: :case_steps

  has_many :case_runs, dependent: :destroy

  validates :title, length: { in: 3..100 }
  validates :description, :acceptance_criteria, length: { maximum: 5_000, allow_blank: true }
end
