class Project < ApplicationRecord
  belongs_to :user

  has_many :suites, dependent: :destroy
  has_many :steps, dependent: :destroy

  validates :title, length: { in: 3..100 }
  validates :description, length: { maximum: 5_000, allow_blank: true }
end
