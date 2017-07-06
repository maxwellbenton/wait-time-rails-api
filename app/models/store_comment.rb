class StoreComment < ApplicationRecord
  belongs_to :store
  belongs_to :user
  belongs_to :wait_time
  belongs_to :comment
end
