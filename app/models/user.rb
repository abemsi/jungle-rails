class User < ActiveRecord::Base
  has_secure_password

  def authenticate_with_credentials(email, password)
    new_email = email.strip.downcase
    user = User.find_by_email(new_email)
    if user && user.authenticate(password)
      user
    else
      nil
    end
  end

  validates :name, :email, :password_digest, presence: true
  validates :email, uniqueness: true, case_sensitive: false
  validates :password, length: { minimum: 5 }
end
