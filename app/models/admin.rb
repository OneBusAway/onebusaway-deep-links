class Admin < ApplicationRecord
  has_secure_password
  strip_attributes only: [:name, :email]
  
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  
  def email=(val)
    sanitized = if val.nil?
      nil
    else
      val.downcase
    end
    write_attribute(:email, sanitized)
  end
  
  ######
  # Creation
  ######
  
  after_create :send_password_reset
  
  def self.create_admin!(name, email, region_id)
    region = Region.find(region_id)
    admin = region.admins.build
    admin.name = name
    admin.email = email
    admin.password = SecureRandom.urlsafe_base64
    admin.save!
    
    admin
  end
  
  def send_password_reset
    self.reset_sent_at = DateTime.now
    self.reset_digest = SecureRandom.urlsafe_base64
    self.save!
    
    UserMailer.password_reset(self)
  end
  
  ######
  # Regions
  ######
  
  belongs_to :region
  
  ######
  # Password Resets
  ######
  
  ######
  # Sessions
  ######
  
  def generate_session_token
    generate_token(:session_token)
  end
  
  before_validation(on: :create) do
    generate_session_token
  end
  
  private
  
  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while Admin.exists?(column => self[column])
  end
end
