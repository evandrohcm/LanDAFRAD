class Acesso < ActiveRecord::Base
  belongs_to :cliente

  scope :recent_acesso, -> { order("id DESC") }
end
