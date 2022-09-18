class Run < ApplicationRecord
  belongs_to :project

  has_many :case_runs, dependent: :destroy
  has_many :cases, through: :case_runs
end
