
module Rich
  module Pluralization
    module Engine
      extend self

      def init(test_locale = nil)
        if test_locale
          I18n.load_path  =    [File.join(File.dirname(__FILE__), "..", "..", "..", "locales", "#{test_locale}.yml")]
        else
          I18n.load_path += Dir[File.join(File.dirname(__FILE__), "..", "..", "..", "locales", "*.yml")]
        end

        I18n.backend.reload!
        Rich::Pluralization::Inflector.inflections.reset_attrs if test_locale

        initial_locale = I18n.locale

        I18n.backend.available_locales.each do |locale|
          I18n.locale = locale

          Rich::Pluralization::Inflector.inflections locale do |inflections|
            (I18n.t! "e9s" rescue []).each do |type, entries|
              entries.each do |inflection|
                inflections.send *[type, inflection].flatten
              end
            end
          end
        end

        I18n.locale = initial_locale

        test_locale
      end

    end
  end
end

Rich::Pluralization::Engine.init
