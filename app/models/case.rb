class Case < ApplicationRecord
  belongs_to :suite, counter_cache: true

  validates :title, length: { in: 3..100 }
  validates :description, :acceptance_criteria length: { maximum: 5_000, allow_blank: true }
end
