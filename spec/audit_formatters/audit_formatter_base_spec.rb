require 'spec_helper'

describe AuditFormatter::Base do
  subject do
    described_class.new(nil)
  end

  it "should have an abstract method for the base class" do
    expect do
      subject.format
    end.to raise_error NotImplementedError

    expect do
      subject.icon
    end.to raise_error NotImplementedError
  end
end
