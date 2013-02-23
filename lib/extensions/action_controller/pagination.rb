module Extensions
  # ActionController extensions
  module ActionController
    # Adds pagination functionality to action controller
    module Pagination
      extend ActiveSupport::Concern

      private
      def apply_pagination(reflection)
        @total = reflection.count

        persist_pagination_information!

        @page_size = get_page_size
        @current_page = get_current_page
        @page_count = get_page_count(@total, @page_size)
        reflection = reflection.limit(@page_size).offset((@current_page - 1) * @page_size)

        reflection
      end

      def get_page_size
        size = 25
        size = params[:pagination][:size].to_i if params[:pagination]
        size = 25 if size < 1 || size > 100
        size
      end

      def get_current_page
        current = 1
        current = params[:pagination][:page].to_i if params[:pagination]
        current = 1 if current < 1 || current > get_page_count(@total, @page_size)
        current
      end

      def get_page_count(total, page_size)
        if total.zero?
          1
        else
          (total / page_size.to_f).ceil
        end
      end

      def persist_pagination_information!
        session[:pagination] = params[:pagination]
      end
    end
  end
end
