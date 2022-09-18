class CaseStep < ApplicationRecord
  include RankedModel

  belongs_to :case, counter_cache: 'steps_count'
  belongs_to :step

  ranks :row_order, with_same: [:case_id]
end
