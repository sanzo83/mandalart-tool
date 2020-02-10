class Record < ApplicationRecord
  has_many :user_records
  has_many :users, through: :user_records
end
