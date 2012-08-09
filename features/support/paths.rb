module NavigationHelpers

  def path_to page_name

    case page_name
 
    when 'home'
      '/'
    when 'sign up'
      #edit_post_path(Post.last)
    else
      begin
        path_components = page_name.split(/\s+/)
        self.send path_components.push('path').join('_').to_sym
      rescue Object => e
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end

  def path_to_file filename
    Rails.root.to_s + "/public/" + filename
  end
end

World(NavigationHelpers)