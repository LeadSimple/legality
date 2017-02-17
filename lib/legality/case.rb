module Legality
  # Public: Represents a set of data that we want to get a "ruling" on.
  #
  # Examples
  #
  #   phone_numbers = ["3334445555", "3336667777"]
  #   rule = Legality::Case.new(:call_recording, phone_numbers).rule
  #   rule.is_legal?(:single_party_notification)
  class Case
    # Public: The area of law that the case deals with. A symbol.
    attr_reader :issue

    # Public: An array of "facts" about the case. They may be strings or
    # objects, as the area of law requires.
    attr_reader :facts

    # Public: The specific rule of law that would apply to this issue. A
    # Legality::Rule instance.
    attr_reader :rule

    # Public: The ruling from the #rule. A Symbol.
    attr_reader :ruling

    def initialize(issue, facts = [])
      @issue = issue
      @facts = facts
      @rule = rule_for(issue, facts)
      @ruling = @rule.ruling
    end

    private
    # Internal: Find a rule for a given issue and return an instance.
    # 
    # Returns a Legality::Rule.
    def rule_for(issue, facts)
      klass = "Legality::Rules::#{issue.to_s.camelize}Rule".constantize
      klass.new(facts)
    end
  end
end

