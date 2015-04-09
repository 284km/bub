require "http"
require 'pit'
require "bub/errors/missing_action_name_argument_error"
require "bub/errors/non_existent_git_repository_error"
require "bub/errors/unknown_action_name_error"

module Bub
  class Command
    def self.call(*args)
      new(*args).call
    end

    def initialize(argv)
      @argv = argv
    end

    def call
      case action_name
      when nil
        warn usage
        raise Errors::MissingActionNameArgumentError
      when "create", "delete"
        raise Errors::NonExistentGitRepositoryError, action_name unless is_repo?
        self.send(action_name)
      else
        raise Errors::UnknownActionNameError, action_name
      end
    rescue Errors::Base => exception
      abort "Error: #{exception}"
    end

    def create
      response = HTTP.basic_auth(user: "#{username}", pass: "#{config['password']}").
        post(endpoint, body: "name=#{repo}&scm=git&is_private=true&fork_policy=no_forks")
      if response.code.to_i == 200
        puts "Updating origin"
        puts "git remote add origin git@bitbucket.org:#{username}/#{repo}.git"
        system "git remote add origin git@bitbucket.org:#{username}/#{repo}.git"
        puts "created repository: #{username}/#{repo}"
      else
        puts "Error #{action_name}: #{response} (HTTP #{response.status})"
      end
    end

    def delete
      if deletable?
        response = HTTP.basic_auth(user: "#{username}", pass: "#{config['password']}").
          delete(endpoint)
        if response.code.to_i == 204
          puts "Your repository #{repo} was successfully deleted."
        else
          puts "Error #{action_name}: #{response} (HTTP #{response.status})"
        end
      else
        puts "Canceled."
      end
    end

    private

    def action_name
      @argv.first
    end

    def usage
      <<-EOS
usage: bub <command>

Commands:
   create     Create this repository on Bitbucket and remote add as origin
   delete     Delete this repository on Bitbucket

      EOS
    end

    def config
      Pit.get(
        "bitbucket",
        require: {
          "username" => "your account in bitbucket",
          "password" => "your password in bitbucket"
        }
      )
    end

    def username
      @username ||= config['username']
    end

    def endpoint
      # "https://api.bitbucket.org/1.0/repositories/#{@username}/#{@repo}"
      # "https://api.bitbucket.org/2.0/repositories/#{@username}/#{@repo}"
      "https://api.bitbucket.org/2.0/repositories/#{username}/#{repo}"
    end

    def repo
      @repo ||= repo_name
    end

    def is_repo?
      system('git rev-parse -q --git-dir >/dev/null 2>&1;')
    end

    def git_path
      @git_path ||= `git rev-parse -q --git-dir`.chomp
    end

    def repo_name
      return File.basename(Dir.pwd) if git_path == ".git"
      File.basename(File.dirname("#{git_path}"))
    end

    def deletable?
      print "Please type in the name of the repository to confirm [(#{repo})] :"
      if STDIN.gets.chomp == repo
        print "Delete this repository? [y/N] :"
        if STDIN.gets.chomp =~ /y/i
          return true
        end
      end
      false
    end
  end
end
