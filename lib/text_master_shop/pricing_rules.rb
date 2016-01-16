module TextMasterShop
  class PricingRules
    private
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
        rule_name = match_line(line, /"(\w+)"/)
        rule_def = match_line(line, /"\w+"\s(.+)/)
        unit_price = match_line(rule_def, /unit price\s([\d\.]+)/).to_f
        every = (match_line(rule_def, /for every\s(\d+)/) || 1).to_i
        conditions = match_line(rule_def, /if\s(.+)/)
        conditions.gsub!(/\sis at least\s/, ' >= ')
        conditions.gsub!(/\sis\s/, ' == ')
        conditions.gsub!(/\sand\s/, ' && ')

        rules[rule_name] = {}
        rules[rule_name]['unit_price'] = unit_price
        rules[rule_name]['every'] = every
        rules[rule_name]['conditions'] = conditions
      end
    end

    def match_line(line, pattern)
      line = line.chomp
      match = line.match(pattern)
      match && match[1]
    end
  end
end
