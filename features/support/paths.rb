module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /the home\s?page/
      '/'
    when /the new composers page/
      new_composers_path

    when /the new talams page/
      new_talams_path

    when /the new ragams page/
      new_ragams_path

    when /the new song page/
      new_song_path

    when /the songs_list page/
      songs_path

    when /the ragams_list page/
      ragams_path

    when /the talams_list page/
      talams_path

    when /the composers_list page/
      composers_path

    when /the sign_in page/
      new_user_session_path

    when /^ragam (.*)'s show page$/i
      ragam_path(Ragam.find_by_translated_field("name", $1))

    when /^talam (.*)'s show page$/i
      talam_path(Talam.find_by_translated_field("name", $1))

    when /^composer (.*)'s show page$/i
      composer_path(Composer.find_by_translated_field("name", $1))

    when /^song (.*)'s show page$/i
      song_path(Song.find_by_translated_field("name", $1))

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /the (.*) page/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue Object => e
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
