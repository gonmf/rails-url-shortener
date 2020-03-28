class Link < ApplicationRecord
  validates :code, :url, :visits, :enabled, presence: true
  validates :code, uniqueness: true
end
