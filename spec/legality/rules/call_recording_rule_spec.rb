require "spec_helper"

describe Legality::Rules::CallRecordingRule do
  let(:facts) { [] }
  subject(:rule) { described_class.new(facts) }

  describe "#ruling" do
    context "when it is between people in a two party state" do
      let(:facts) { ["2091112222", "2391112222"] }
      its(:ruling) { should eq :all_party_consent }
    end

    context "when it is between people in a single-party state" do
      let(:facts) { ["2101112222", "2101112222"] }
      its(:ruling) { should eq :single_party_consent }
    end

    context "when it is between people in mixed states" do
      let(:facts) { ["2101112222", "2091112222"] }
      its(:ruling) { should eq :all_party_consent } # conservative rule
    end
  end
end
