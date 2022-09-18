class Assignment < ApplicationRecord
  belongs_to :run, counter_cache: true

  has_many :assignment_case_steps, dependent: :destroy

  has_secure_token
end
