class Run < ApplicationRecord
  belongs_to :project

  has_many :case_runs, dependent: :destroy
  has_many :cases, through: :case_runs

  has_many :assignments

  validates :title, length: { in: 3..100 }
  validates :description, length: { maximum: 5_000, allow_blank: true }
end
