require "spec_helper"

describe Legality::Case do
  let(:issue) { :call_recording }
  let(:facts) { ["3605554444", "2223334444"] }
  subject(:instance) { described_class.new(issue, facts) }

  it { should respond_to :issue }
  it { should respond_to :facts }
  it { should respond_to :rule }
  it { should respond_to :ruling }

  describe "#initialize" do
    its(:issue) { should eq :call_recording }
    its(:facts) { should eq facts }
    its(:rule) { should be_a Legality::Rule }
  end
end
