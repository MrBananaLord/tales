Tales::Application.configure do
  config.cache_classes = false

  config.eager_load = false

  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.default_url_options = { host: Settings.default_url_options.host }
  config.action_mailer.delivery_method = :letter_opener
  
  config.active_support.deprecation = :log

  config.active_record.migration_error = :page_load

  config.assets.debug = true
  
  # debug tłumaczeń
  #  I18n.class_eval do
  #    class << self

  #      def translate_with_output(*args)
  #        puts "Translation called with arguments: "
  #        args.each{|a| puts a.inspect}
  #        translate_without_output(*args)
  #      end

  #      alias_method_chain :translate, :output
  #      alias_method :t, :translate
  #    end
  #  end
end
