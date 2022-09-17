# frozen_string_literal: true

class PageComponent < ViewComponent::Base
  renders_one :header
  renders_many :actions
end
