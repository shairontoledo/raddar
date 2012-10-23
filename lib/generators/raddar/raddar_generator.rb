class RaddarGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  def copy_files
    template "raddar.yml", "raddar.yml"

    directory "theme", "theme"


  end
end
