module TextMasterShop
  class PricingRules
    PATTERNS = {
      rule_name: /"(\w+)"/,
      rule_def: /"\w+"\s(.+)/,
      unit_price: /unit price\s([\d\.]+)/,
      every: /for every\s(\d+)/,
      conditions: /if\s(.+)/,
    }

    private
    attr_reader :file

    public
    attr_reader :parsed

    def initialize(rules_file)
      @file = rules_file
      @parsed = {}
      parse_rules
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
        parsed[rule_name]['unit_price'] = unit_price(rule_def)
        parsed[rule_name]['every'] = every(rule_def)
        parsed[rule_name]['conditions'] = conditions(rule_def)
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

    def conditions(line)
      conds = []
      matched = match_line(line, :conditions)

      matched.gsub!(/\sis at least\s/, ' >= ')
      matched.gsub!(/\sis\s/, ' == ')
      matched.gsub!(/\sand\s/, ' && ')

      matched.split(/\s&&\s/).each_with_index do |c, i|
        match = c.match(/([\w_]+)\s([<>=]+)\s(.+)/)
        attr = match[1]
        operator = match[2]
        expected_value = match[3].gsub(/'/, '')
        digit = expected_value.match(/^\d+$/)
        expected_value = expected_value.to_f unless digit.nil?

        conds.push({
          'group_operator' => i == 0 ? '' : '&&',
          'attr' => attr,
          'operator' => operator,
          'expected_value' => expected_value,
        })
      end

      conds
    end
  end
end
