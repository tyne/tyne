require 'spec_helper'

describe NotificationCell do
  subject { cell(:notification) }

  context :cell do
    describe '#show' do
      it "should render the view" do
        subject.should_receive(:render)
        subject.show
      end
    end
  end

  context :views do
    describe 'show' do
      subject { render_cell :notification, :show }

      it 'should have data-cell value' do
        subject.should have_selector('[data-cell="Notification"]')
      end

      it 'should have .Notification selector' do
        subject.should have_selector('.Notification')
      end

      it 'should have .NotificationLayer selector' do
        subject.should have_selector('.Notification .NotificationLayer')
      end

      it 'should have .NotificationContent selector' do
        subject.should have_selector('.Notification .NotificationContent')
      end
    end
  end
end
