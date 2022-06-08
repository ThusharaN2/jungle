class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true
  validates :email, uniqueness: { case_sensitive: false }, presence: true
  validates :password, presence: true, length: { minimum: 3 }
  validates :password_confirmation, presence: true

  def self.authenticate_with_credentials(email, password)
    user = User.find_by(email: email)
    if  user && user.authenticate(password)
      user
    else
      nil
    end
  end

end