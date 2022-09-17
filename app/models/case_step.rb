class CaseStep < ApplicationRecord
  include RankedModel

  belongs_to :case
  belongs_to :step

  ranks :row_order, with_same: [:case_id, :step_id]
end
