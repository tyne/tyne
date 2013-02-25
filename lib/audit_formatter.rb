# Contains logic to format audit messages
module AuditFormatter
  # Base class for formatted audit messages
  class Base
    include ActionView::Helpers::TranslationHelper

    attr_reader :object, :options

    def initialize(object, options={})
      @object, @options = object, options
    end

    # Abstract format method. Needs to be overriden in the sub class.
    def format
      raise NotImplementedError
    end

    # Returns details for an audit.
    def details
      nil
    end

    # Returns an image_tag with the correct icon
    def icon
      raise NotImplementedError
    end

    private

    def format_context
      FormatContexts::Html.new
    end

    def user
      @user ||= object.user
    end

    def user_link
      LinkHelper.new(format_context).user_link(user)
    end

    def create?
      object.action == 'create'
    end

    def update?
      object.action == 'update'
    end

    def i18n_base_scope
      "audits.#{object.auditable_type.underscore}"
    end
  end

  # Extends the audit class to have a formatted method.
  module Support
    extend ActiveSupport::Concern

    # Returns the particular formatter constant.
    #
    # e.g. Foo => FooAuditFormatter
    def audit_formatter_class
      klass = self.auditable_type
      "#{klass}AuditFormatter".safe_constantize
    end

    # Proxy method for format on the formatter class.
    def formatted
      audit_formatter.format
    end

    # Proxy method for details on the formatter class
    def details
      audit_formatter.details
    end

    # Proxy method for icon
    def icon
      audit_formatter.icon
    end

    # Returns an instance of formatter class.
    def audit_formatter
      @audit_formatter ||= audit_formatter_class.new(self)
    end
  end
end
