SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|
    primary.item :home, '', root_path
    primary.item :song, t(:song), songs_path
    primary.item :ragam, t(:ragam), '#'
    primary.item :talam, t(:talam), '#'
    primary.item :composer, t(:composer), '#'
  end
end
