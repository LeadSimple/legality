module Legality
  class Rule
    attr_reader :facts
    attr_reader :ruling

    class LegalityUnknown < Exception; end;

    RULINGS = []

    def initialize(facts)
      @facts = facts
      @ruling = decide_ruling_for(facts)
    end

    def decide_ruling_for(facts)
      raise LegalityUnknown, "Could not find any legal information."
    end

    def statute
      @statute ||= begin
                     file = File.new(File.join(ROOT, "legality/statutes/#{statute_name}.yml"))
                     YAML.load(file.read)
                   rescue
                     binding.pry
                   end
    end

    def statute_name
      self.class.name.gsub("Legality::", "")
                     .gsub(/Rule(s)?(::)?/, "")
                     .underscore
    end
  end
end
