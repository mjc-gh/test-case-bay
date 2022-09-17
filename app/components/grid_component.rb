# frozen_string_literal: true

class GridComponent < ViewComponent::Base
  renders_many :items

  def initialize(id: nil)
    @id = id
  end
end
