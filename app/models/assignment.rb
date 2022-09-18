class Assignment < ApplicationRecord
  belongs_to :run

  has_many :assignment_cases, dependent: :destroy

  has_secure_token
end
