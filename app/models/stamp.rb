class Stamp < ApplicationRecord

  belongs_to :user
  belongs_to :stamper, class_name: 'User'
end