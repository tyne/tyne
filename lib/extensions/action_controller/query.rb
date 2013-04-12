module Extensions
  module ActionController
    # Adds query functionality to action controller
    module Query
      extend ActiveSupport::Concern

      private
      def apply_query(reflection)
        return reflection if params[:query].blank?

        persist_query_information!

        q = "%#{params[:query]}%"

        reflection = reflection.where("issues.summary like ? OR issues.description like ? OR CAST(issues.number as TEXT) like ?", q, q, q)

        reflection
      end

      def persist_query_information!
        session[:query] = params[:query]
      end
    end
  end
end
