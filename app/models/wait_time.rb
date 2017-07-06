class WaitTime < ApplicationRecord
  belongs_to :user
  belongs_to :store
  has_one :store_comment

  
end
