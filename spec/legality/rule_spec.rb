require "spec_helper"

describe Legality::Rule do
  subject(:instance) { described_class.new([]) }
  before { Legality::Rule.any_instance.stub(:decide_ruling_for) }

  it { should respond_to :facts }
end
