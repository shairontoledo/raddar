require 'yaml'

raddar_unicorn_default = {'listen' => 5000, 'worker_processes' => 4}

raddar_unicorn = YAML.load_file(File.expand_path("../../raddar.yml", __FILE__))['unicorn'] || raddar_unicorn_default

raddar_unicorn = raddar_unicorn_default.merge(raddar_unicorn)


listen raddar_unicorn['listen']
worker_processes raddar_unicorn['worker_processes']