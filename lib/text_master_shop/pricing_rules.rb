module TextMasterShop
  class PricingRules
    private
    PATTERNS = {
      rule_name: /"(\w+)"/,
      rule_def: /"\w+"\s(.+)/,
      unit_price: /unit price\s([\d\.]+)/,
      every: /for every\s(\d+)/,
      conditions: /if\s(.+)/,
    }

    attr_reader :file

    public
    attr_reader :rules

    def initialize(rules_file)
      @file = rules_file
      @rules = {}
      read_rules
    end

    def [](key)
      rules[key]
    end

    private
    def read_rules
      file.readlines.each do |line|
        rule_name = match_line(line, :rule_name)
        rule_def = match_line(line, :rule_def)

        rules[rule_name] = {}
        rules[rule_name]['unit_price'] = unit_price(rule_def)
        rules[rule_name]['every'] = every(rule_def)
        rules[rule_name]['conditions'] = conditions(rule_def)
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
      conds = match_line(line, :conditions)
      conds.gsub!(/\sis at least\s/, ' >= ')
      conds.gsub!(/\sis\s/, ' == ')
      conds.gsub!(/\sand\s/, ' && ')
      conds
    end
  end
end
