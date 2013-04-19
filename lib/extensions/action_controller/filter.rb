module Extensions
  # ActionController extensions
  module ActionController
    # Adds filter functionality to action controller
    module Filter
      extend ActiveSupport::Concern

      private
      def apply_filter(reflection)
        return reflection unless params[:filter]

        persist_filter_information!

        params[:filter].each do |filter|
          filter[1][0] = nil if filter[1][0] == '-1'

          if reflection.respond_to?(:"filter_by_#{filter[0]}")
            reflection = reflection.send(:"filter_by_#{filter[0]}", filter[1])
          else
            reflection = reflection.where(:issues => Hash[*filter])
          end
        end

        reflection
      end

      def persist_filter_information!
        session[:filter] = params[:filter]
      end
    end
  end
end
