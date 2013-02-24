module Extensions
  # Contains logic for issue extensions
  module Issues
    # Defines a basic workflow for issues
    # The workflow is as follows:
    # ---
    # default_state: open
    # ---
    # open or reopened -> wip
    # open or reopened or wip -> done
    # open or reopened or wip -> invalid
    # wip -> open
    # done or invalid -> reopened
    module Workflow
      extend ActiveSupport::Concern

      included do
        state_machine :state, :initial => :open do
          # When closing an issue
          after_transition [:open, :reopened, :wip] => [:done, :invalid] do |issue, transition|
            issue.after_close
          end

          # When reopening an issue
          after_transition [:done, :invalid] => [:open, :reopened] do |issue, transition|
            issue.after_reopen
          end

          event :start_working do
            transition [:open, :reopened] => :wip
          end

          event :stop_working do
            transition :wip => :open
          end

          event :task_is_done do
            transition [:open, :reopened, :wip] => :done
          end

          event :task_is_invalid do
            transition [:open, :reopened, :wip] => :invalid
          end

          event :reopen do
            transition [:done, :invalid] => :reopened
          end

          state all - [:done, :invalid] do
            def completed?
              false
            end
          end

          state :done, :invalid do
            def completed?
              true
            end
          end
        end

        def available_transitions
          current = { self.state => nil }
          self.state_transitions.each do |x|
            current[x.to] = x.event
          end unless self.new_record?

          current
        end

        scope :to_do, where(:state => ["open", "reopened"])
        scope :in_progress, where(:state => ["wip"])
        scope :not_completed, where(:state => ["open", "wip", "reopened"])
        scope :closed, where(:state => ["done", "invalid"])
      end
    end
  end
end
