module TextMasterShop
  class PricingRules
    PATTERNS = {
      rule_name: /"(\w+)"/,
      rule_def: /"\w+"\s(.+)/,
      unit_price: /unit price\s([\d\.]+)/,
      every: /for every\s(\d+)/,
      conditions: /if\s(.+)/,
      is_at_least: /\sis at least\s/,
      is: /\sis\s/,
      and: /\sand\s/,
      and_op: /\s&&\s/,
      condition: /([\w_]+)\s([<>=]+)\s(.+)/,
      digit: /^[\d\.]+$/,
      extra_quotes: /['\\"]/,
    }

    private
    attr_reader :file

    public
    attr_reader :parsed

    def initialize(rules_file = nil)
      @file = rules_file
      @parsed = {}
      parse_rules unless file.nil?
    end

    def [](key)
      parsed[key]
    end

    private
    def parse_rules
      file.readlines.each do |line|
        rule_name = match_line(line, :rule_name)
        rule_def = match_line(line, :rule_def)

        parsed[rule_name] = {}
        parsed[rule_name]["unit_price"] = unit_price(rule_def)
        parsed[rule_name]["every"] = every(rule_def)
        parsed[rule_name]["conditions"] = conditions(rule_def)
      end
    end

    def match_line(line, pattern_key)
      line = line.chomp
      match = line.match(PATTERNS[pattern_key])
      match && match[1]
    end

    def unit_price(line)
      match_line(line, :unit_price).to_f
    end

    def every(line)
      (match_line(line, :every) || 1).to_i
    end

    # The team expects this method to improve
    # as more use cases are introduced by the client
    def conditions(line)
      conds = []
      matched = match_line(line, :conditions)

      matched.gsub!(PATTERNS[:is_at_least], " >= ")
      matched.gsub!(PATTERNS[:is], " == ")
      matched.gsub!(PATTERNS[:and], " && ")

      matched.split(PATTERNS[:and_op]).each_with_index do |c, i|
        match = c.match(PATTERNS[:condition])
        attr = match[1]
        operator = match[2]
        expected_value = match[3].gsub(PATTERNS[:extra_quotes], "")
        digit = expected_value.match(PATTERNS[:digit])
        expected_value = expected_value.to_f unless digit.nil?

        conds.push({
          "chain_operator" => i == 0 ? "" : " && ",
          "attr" => attr,
          "operator" => operator,
          "expected_value" => expected_value,
        })
      end

      conds
    end
  end
end
