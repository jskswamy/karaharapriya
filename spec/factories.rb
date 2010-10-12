Factory.define :song do |f|
  f.name 'A song'
  f.composer 'Unknown composer'
  f.association :song_type
end

Factory.define :song_type do |f|
  f.name 'varnam'
  f.description 'varnam'
end

Factory.define :song_content do |f|
  f.body 'sa re ga ma'
  f.association :song
  f.association :song_content_type
end

Factory.define :song_content_type do |f|
  f.name "Pallavi"
  f.description "Starting portion of a song"
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
  f.name "aathi"
  f.avartanam "1 0 0"
  f.laghu_length 4
end
