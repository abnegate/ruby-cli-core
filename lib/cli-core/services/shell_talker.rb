# frozen_string_literal: true

require "thor/shell"
require "thor/actions"

module CliCore
  class ShellTalker < Thor
    include Thor::Shell
    include Thor::Actions

    def self.new_shell
      Color.new
    end
  end

  module Shell
    module_function

    @shell = ShellTalker.new_shell

    def which(cmd)
      exts = ENV["PATHEXT"] ? ENV["PATHEXT"].split(";") : [""]
      ENV["PATH"].split(File::PATH_SEPARATOR).each do |path|
        exts.each do |ext|
          exe = File.join(path, "#{cmd}#{ext}")
          return exe if File.executable?(exe) && !File.directory?(exe)
        end
      end
      nil
    end

    def cmd(command, capture = true)
      ShellTalker.new.run(command, verbose: false, capture: capture)
    end

    def header(section_name)
      padding = 8
      section_name = "Step: #{section_name}"
      say("-" * (section_name.length + padding), :green)
      say("--- #{section_name} ---", :green)
      say("-" * (section_name.length + padding), :green)
    end

    def yes?(message)
      ask(message, options: %w[y n]) == "y"
    end

    def say(message, color = :blue)
      @shell.say(add_date(@shell.set_color(message, color)))
    end

    def ask(query, _path = false, options: nil, default: nil)
      query = add_date(@shell.set_color(query, :yellow))

      return ask_simple(query) if options.nil? && default.nil?
      if !options.nil? && !default.nil?
        return ask_default_options(query, options, default)
      end

      return ask_options(query, options) unless options.nil?

      ask_default(query, default) unless default.nil?
    end

    def error(message)
      @shell.say(add_date(@shell.set_color("ERROR: #{message}", :red)))
    end

    def ask_simple(query)
      @shell.ask(query)
    end

    def ask_default(query, default)
      @shell.ask(query, default: default)
    end

    def ask_options(query, options)
      @shell.ask(query, limited_to: options)
    end

    def ask_default_options(query, options, default)
      @shell.ask(query, limited_to: options, default: default)
    end

    def add_date(message)
      `date +"[%H:%M:%S]: "`.sub("\n", "") + message
    end

    private_class_method :ask_simple,
      :ask_default,
      :ask_default_options,
      :ask_options
  end
end
