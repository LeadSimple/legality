require "active_support/inflector"
require "legality/version"
require "legality/rule"
require "legality/case"

# Rules
require "legality/rules/call_recording_rule"

module Legality
  ROOT = File.dirname(__FILE__)
end
