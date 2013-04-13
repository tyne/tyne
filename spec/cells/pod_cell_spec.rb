require 'spec_helper'

describe PodCell do
  subject { cell(:pod) }

  context :cell do
    describe '#collapsable' do
      before :each do
        subject.stub(:render)
      end

      it 'should render the view' do
        subject.should_receive(:render)
        subject.collapsable 'My title'
      end

      it 'should assign the @title' do
        subject.collapsable 'My Title'
        subject.instance_variable_get('@title').should == 'My Title'
      end

      it 'should assign the @features' do
        subject.collapsable 'My Title'
        subject.instance_variable_get('@features').should == [:collapsable]
      end

      it 'should accept an initial state' do
        subject.collapsable 'My title', :state => :collapsed
        subject.instance_variable_get('@state').should == :collapsed
      end
    end
  end

  context :views do
    describe :collapsable do
      context :block_given do
        it 'should render without errors' do
          expect {
            render_cell :pod, :collapsable, 'My Title' do |cell|
              cell.content = 'My Content'
            end
          }.to_not raise_error
        end
      end

      context :no_block_given do
        it 'should render without errors' do
          expect {
            render_cell :pod, :collapsable, 'My Title'
          }.to_not raise_error
        end
      end

      describe :layout do
        subject do
          render_cell :pod, :collapsable, 'My Title' do |c|
            c.content = 'My Content'
          end
        end

        it 'should have .Pod slector' do
          subject.should have_selector('.Pod')
        end

        it 'should have .PodTitle selector' do
          subject.should have_selector('.Pod .PodTitle span', :text => 'My Title')
        end
      end
    end
  end
end
