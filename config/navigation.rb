SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|
    primary.item :song, t(:song), songs_path, :highlights_on => /\/song/
    primary.item :ragam, t(:ragam), ragams_path, :highlights_on => /\/ragam/
    primary.item :talam, t(:talam), talams_path, :highlights_on => /\/talam/
    primary.item :composer, t(:composer), composers_path, :highlights_on => /\/composer/
  end
end
