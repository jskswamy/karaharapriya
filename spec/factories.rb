Factory.sequence :name do |n|
  "first#{n}"
end

Factory.define :song do |f|
  f.name {Factory.next(:name)}
  f.association :song_type
  f.association :ragam
  f.association :talam
  f.association :composer
end

Factory.define :song_type do |f|
  f.name {Factory.next(:name)}
  f.description "description"
end

Factory.define :ragam do |f|
  f.sequence(:name) { |n| "ragam #{n}" }
  f.sequence(:arohana) do |n|
    arohana_list = ["sa", "re1", "re2", "ga1", "ga2", "ma1", "ma2", "pa", "th1", "th2", "ni1", "ni2", "sa^"]
    arohana = ""
    (0...8).each { arohana << "#{arohana_list[rand(100 * n) % arohana_list.count]} " }
    arohana.chop
  end
  f.sequence(:avarohana) do |n|
    avarohana_list = ["sa", "re1", "re2", "ga1", "ga2", "ma1", "ma2", "pa", "th1", "th2", "ni1", "ni2", "sa^"].reverse
    avarohana = ""
    (0...8).each { avarohana << "#{avarohana_list[rand(100 * n) % avarohana_list.count]} " }
    avarohana.chop
  end
end

Factory.define :talam do |f|
  f.name { Factory.next(:name) }
  f.sequence(:avartanam) { |n| "1 0 0 " * n }
  f.sequence(:laghu_length) { |n| n }
end

Factory.define :composer do |f|
  f.name { Factory.next(:name) }
  f.sequence(:century) { |n| "178#{n}-188#{n}" }
  f.sequence(:info) { |n| "Additional information for composer #{n}" }
end
