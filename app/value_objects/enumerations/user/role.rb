class Enumerations::User::Role < Enumerations::Base
  def self.options
    @options ||= %w(standard_user admin)
  end
  
  def admin?
    value == "admin"
  end
end
