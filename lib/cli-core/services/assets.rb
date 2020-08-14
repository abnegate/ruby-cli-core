# frozen_string_literal: true

module CliCore
  module Assets
    module_function

    def path
      File.join(__dir__, "../../../resources/")
    end

    def get_template_path(asset_path)
      File.join(path, "templates/#{asset_path}")
    end

    def get_template(name)
      template_path = File.join(path, "templates/#{name}")
      Result.new(true, nil, File.read(template_path))
    rescue => e
      Result.new(false, "Couldn't template #{name}: #{e.message}")
    end
  end
end
