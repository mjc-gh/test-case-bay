# frozen_string_literal: true

class PageComponent < ViewComponent::Base
  renders_one :header
  renders_one :sub_header

  renders_many :actions
end
