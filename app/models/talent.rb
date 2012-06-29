class Talent < User
  belongs_to :agent
  has_many :requests
end
