class User::SignInFromFacebookService
  
  attr_reader :auth
  
  def initialize(auth)
    @auth = auth
  end
  
  def user
    @user ||= begin
      user = (find_user_by_provider || find_user_by_email || create_user)
      user.remember_me = true
      user
    end
  end
  
  private
  
  def find_user_by_email
    user = User.find_by(email: email)
    user.update_columns(provider_type: provider, provider_id: user_id) if user.present?
    user
  end
  
  def create_user
    User.create(
      email: email,
      password: password,
      confirmed_at: Time.now,
      provider_type: provider, 
      provider_id: user_id,
      #remote_avatar_url: profile_picture_url
    )
  end
  
  def find_user_by_provider
    User.find_by(provider_type: provider, provider_id: user_id)
  end
  
  def provider
    "facebook"
  end
  
  def email
    auth.info.email
  end
  
  def password
    Devise.friendly_token[0, 20]
  end
  
  def user_id
    auth.uid
  end
  
  #  def profile_picture_url
  #    @profile_picture_url ||= graph.get_picture("me", type: "large")
  #  end
  
  #  def graph
  #    @graph ||= Koala::Facebook::API.new(access_token)
  #  end
  
  def access_token
    auth.credentials.token
  end
end
