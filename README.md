# Legality

A gem to determine whether given actions are legal or illegal. It can easily be
extended to cover new situations and new laws as needed, since it is entirely
possible that LeadSimple will be subject to other laws and regulations.

## How It Works
1. You create a `Legality::Case` with two parameters, the `issue` at hand and
an array of `facts` about the case.
2. You ask the `Legality::Case` for a `#rule` on the case. This will return a
`Legality::Rule` object.
3. You can then ask the `Legality::Rule` whether any given conduct `is_legal?`
or `is_illegal?`. If you just want the token summary of the rule, you can ask
the `Legality::Rule` for the `#ruling` and get back a `symbol`. 

## Supported Laws

### Call Recording
The gem supports call recording legislation in the United States.

```ruby
# Determine whether we can legally record a phone call between these two
# phone numbers.
rule = Legality::Case.new(:call_recording, ["3603334444", "3335556666"]).rule
rule.ruling # => :all_party_consent

# Or, shorthand
rule = Legality::Case.new(:call_recording, ["3603334444", "3335556666"]).ruling
# => :all_party_consent
```

## DISCLAIMER
The results returned from this gem are not a substitute for legal advice.
Neither LeadSimple nor the author, Daniel Berkompas, will be liable for any
violation of law resulting from trusting this gem.
