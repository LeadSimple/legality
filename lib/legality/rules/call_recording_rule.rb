module Legality
  module Rules
    class CallRecordingRule < Legality::Rule
      # Public: The available rulings for this particular rule.
      #
      # single_party_consent - One party must know that the call is being
      #                        recorded.
      # all_party_consent    - All parties must know and consent to the call
      #                        being recorded.
      RULINGS = %i( single_party_consent all_party_consent )

      # Public: The default ruling, if all else fails. We've set it
      # conservatively here, since it's better to be safe than sorry.
      DEFAULT = :all_party_consent

      private
      # Internal: Determine what ruling to return. Parses
      # statutes/call_recording.yml to determine what laws apply to the various
      # callers in the conversation.
      #
      # phone_numbers - An array of phone numbers as strings. Expects E.164 international format
      #                 Ex. ["+13601112222","+12102223333"]
      #
      # NOTE: if the number is not US/Canada (+1), no area code will be found, and the default policy will be used
      #
      # Returns a Symbol.
      def decide_ruling_for(phone_numbers)
        area_codes = phone_numbers.map { |p| parse_area_code(p).to_s.to_i }.uniq

        RULINGS.each do |rule|
          return rule if (area_codes_for(rule) & area_codes).size == area_codes.size
        end

        DEFAULT
      end

      # Internal: Find the area code in a phone number.
      #
      # number - The phone number to parse.
      #
      # Returns a String or nil, if no area code is found.
      def parse_area_code(number)
        if number && number.gsub(/\D/, "").match(/^1?(\d{3})(\d{3})(\d{4}|\d{3})/)
          $1
        end
      end

      # Internal: Find all the area codes where a given rule has sway.
      #
      # rule - Either :single_party_consent or :all_party_consent.
      #
      # Returns an Array of area codes.
      def area_codes_for(rule)
        regions_for(rule.to_s).map { |n, o| o["codes"] }.flatten
      end

      # Internal: Find all the regions where a given rule has sway.
      #
      # rule - Either :single_party_consent or :all_party_consent.
      #
      # Returns an Array of hashes, each item representing a state.
      def regions_for(rule)
        statute.select do |state_name, options|
          options["rule"] == rule
        end
      end
    end
  end
end
