class CaseRun < ApplicationRecord
  include RankedModel

  belongs_to :case
  belongs_to :run, counter_cache: 'case_runs_count'

  ranks :row_order, with_same: [:run_id]
end
