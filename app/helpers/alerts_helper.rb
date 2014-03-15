module AlertsHelper
  def alert_class(kind)
    case kind.to_s
      when "alert" then "alert-danger"
      when "notice" then "alert-success"
      else raise "Invalid alert kind"
    end
  end
end
