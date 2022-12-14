class Step < ApplicationRecord
  belongs_to :project, counter_cache: true

  has_many :case_steps, dependent: :destroy
  has_many :cases, through: :case_steps, counter_cache: true

  validates :title, length: { in: 3..100 }
  validates :acceptance_criteria, length: { in: 10..5_000 }
  validates :description, length: { maximum: 5_000, allow_blank: true }
end
