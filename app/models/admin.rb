class Admin < ApplicationRecord
  has_secure_password
  strip_attributes only: [:name, :email]
  
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
  # Sessions
  ######
  
  before_validation(on: :create) do
    generate_token(:session_token)
  end
  
  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while Admin.exists?(column => self[column])
  end
end
