
module Rich
  module Pluralization
    module Core
      module String
        module Inflections
  
          def pl(count = nil)
            Rich::Pluralization::Inflector.pluralize self, count
          end
                
        end
      end
    end
  end
end
