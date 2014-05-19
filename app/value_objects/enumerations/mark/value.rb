class Enumerations::Mark::Value < Enumerations::Base
  def self.options
    @options ||= (1..5)
  end
end
