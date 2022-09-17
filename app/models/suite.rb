class Suite < ApplicationRecord
  belongs_to :project, counter_cache: true

  validates :title, length: { in: 3..100 }
  validates :description, length: { maximum: 5_000, allow_blank: true }
end
