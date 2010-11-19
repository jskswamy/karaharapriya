Factory.sequence :name do |n|
  "first#{n}"
end

Factory.define :song do |f|
  f.name {Factory.next(:name)}
  f.association :composer
  f.association :song_type
end

Factory.define :song_type do |f|
  f.name {Factory.next(:name)}
  f.sequence(:description) { |n| "song description #{n}" }
end

Factory.define :song_content do |f|
  f.sequence(:body) { |n| 'sa re ga ma ' * n }
  f.association :song
  f.association :song_content_type
end

Factory.define :song_content_type do |f|
  f.name { Factory.next(:name) }
  f.sequence(:description) { |n| "song content type #{n}" }
end

Factory.define :song_content_info do |f|
  f.association :song_content
  f.association :info, :factory => :ragam
end

Factory.define :ragam do |f|
  f.name "karaharapriya"
  f.arohana "sa re2 ga1 ma1 pa th2 ni1 sa^"
  f.avarohana "sa^ ni1 th2 pa ma1 ga1 re2 sa"
  f.major true
end

Factory.define :talam do |f|
  f.name { Factory.next(:name) }
  f.sequence(:avartanam) { |n| "1 0 0 " * n }
  f.laghu_length 4
end

Factory.define :composer do |f|
  f.name { Factory.next(:name) }
  f.sequence(:century) { |n| "178#{n}-188#{n}" }
  f.sequence(:info) { |n| "Additional information for composer #{n}" }
end

Factory.define :song_composition do |f|
  f.association :song_content_type
  f.association :song_type
end
