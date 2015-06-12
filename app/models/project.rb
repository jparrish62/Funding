class Project < ActiveRecord::Base

  validates :name,:target_pledge_amount,:team_members, presence: true
  validates :description, length: {minimum: 25}
  validates :image_file_name, allow_blank: true, format: {
    with: /\w+\.(gif|jpg|png)\z/i,
    message: "must refrence a GIF, JPG, or PNG image"
  }
  has_many :registrations, dependent: :destroy

  def self.accepting_pledges
    where("pledging_ends_on >= ?", Time.now).order("pledging_ends_on asc")
  end

  def pledging_expired?
    pledging_ends_on < Date.today
  end
end
