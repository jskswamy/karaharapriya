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
