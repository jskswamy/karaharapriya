SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|
    primary.item :home, '', root_path
    primary.item :song, 'Song', songs_path
    primary.item :ragam, 'Ragam', '#'
    primary.item :talam, 'Talam', '#'
    primary.item :composer, 'Composer', '#'
  end
end
