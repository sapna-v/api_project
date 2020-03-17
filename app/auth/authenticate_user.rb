class AuthenticateUser
  prepend SimpleCommand
  attr_accessor :email, :password

  def initialize(email, password)
    @email = email
    @password = password
  end

  def call
    JsonWebToken.encode(user_id: user.id) if user
  end

  private

  def user
    user = User.find_by_email(email)
    #Disabled user cannot login
    return user if user && user.authenticate(password) && user.status == "A"

    errors.add :user_authentication, 'Invalid credentials or User is Disabled'
    nil
  end
end