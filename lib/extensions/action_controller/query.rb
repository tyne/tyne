module Extensions
  module ActionController
    # Adds query functionality to action controller
    module Query
      extend ActiveSupport::Concern

      private
      def apply_query(reflection)
        return reflection unless params[:query]

        persist_query_information!

        q = "%#{params[:query]}%"

        reflection = reflection.where("summary like ? OR description like ? OR number like ?", q, q, q)

        reflection
      end

      def persist_query_information!
        session[:query] = params[:query]
      end
    end
  end
end
