class Alarm < ApplicationRecord
  belongs_to :region
  validates_presence_of :push_identifier, :message
  
  before_validation(on: :create) do
    generate_token(:secure_token)
  end
  
  def to_param
    secure_token
  end
    
  private

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while Alarm.exists?(column => self[column])
  end
end
