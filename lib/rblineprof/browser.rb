require "rblineprof/browser/version"
require "rblineprof"
require "pygments"
require "highline"

module Rblineprof
  class Browser
    attr_reader :profile

    def self.from_lineprof(regex = /./, &block)
      profile = lineprof(regex, &block)
      new(profile)
    end
    
    def self.profile_and_browse(regex = /./, &block)
      from_lineprof(regex, &block).browse
    end

    def initialize(profile)
      @profile = profile
    end

    def print_profile(fn)
      highlight(fn).each_with_index do |line, num|
        if (sample = profile[fn][num+1]) && (sample[0] > 0)
          puts "% 8.1fms, % 8.1fms excl | %s" % [sample[0]/1000.0, sample[2] / 1000.0, line]
        else
          puts "                            | %s" % [line]
        end
      end

      nil
    end

    def highlight(fn)
      begin
        Pygments.highlight(File.read(fn), :lexer => 'ruby', :formatter => 'terminal').split("\n")
      rescue
        (0..profile[fn].size).map { |i| "File not found: #{fn}" }
      end
    end

    def usage
      puts "Usage: print_profile(filename)"
      puts "Filenames:"
      profile.keys.sort.map { |fn| " - #{fn}" }.each { |line| puts line }
    end
    
    def browse
      done = false
      while !done do
        highline.choose do |menu|
          menu.prompt = "Choose a file to view the profile of: "
        
          profile.keys.each do |filename|
            menu.choice(filename) { print_profile(filename) }
          end
          
          menu.choice("Quit") { done = true }
        end
      end
    end
    
    private
    def highline
      @highline ||= HighLine.new
    end
  end
end
