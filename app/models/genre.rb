class Genre < ApplicationRecord
  validates :is_active, inclusion: { in: [true, false] }
end
