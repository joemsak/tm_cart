# TextMasterShop

Hello TextMaster!

I hope you will enjoy the code herein for my application audition.

I'd like to add just a couple of notes about my choices in this code base:

* You may notice there are no direct unit specs for `Product` - I feel confident this class is simple enough for now and covered adequately by its use in integration specs

* You may notice I leave trailing `,` at the end of arrays and hashes. - I have recently learned from `thoughtbot` developers that this is a good practice to reduce diff noise

* You may notice I avoid `let` even when I have the same assignments in each test. - Again, I have picked this convention up from `thoughtbot` because being able to see all the setup in the test is more valuable than saving a couple lines of simple code. Often, `let` is abused and hides very messy and complex setup. If your setup variables aren't simple and easy to type, perhaps there is a problem in the system design.

* Finally, you will notice I use `let` in the integration spec with your test data. This is to make the test faster and easier to read for the purposes of my application to the position available within your company.

Relevant links:

[Integration test based on TextMaster test data](https://github.com/joemsak/tm_cart/blob/master/spec/integration/text_master_data_spec.rb)

[PricingRules](https://github.com/joemsak/tm_cart/blob/master/lib/text_master_shop/pricing_rules.rb)

Originally, I planned to make `PricingRules` allow for a sort of DSL script the client could create and update on the site themselves, however this lead to a mess and a headache that just wasn't worth it in the end. I feel confident that my design of `PricingRules` is reasonably adaptable to future changes, though I am open to suggestions and feedback from my team.

Example idea for DSL script that got canned in this sprint:

```
# ./lib/pricing_rules_script

rule "bogo" set unit price 0 for every 2 if id is FR1
rule "bulk" set unit price 4.5 if id is AP1 and quantity is at least 3
```

If you're willing to indulge my failed attempt, the code for this idea was last left in this condition:

[PricingRules with DSL script enabled](https://github.com/joemsak/tm_cart/blob/ee2584f5f9c93c70bf1b9d166dc52eeedc60d958/lib/text_master_shop/pricing_rules.rb)
