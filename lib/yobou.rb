# frozen_string_literal: true

require 'open3'

class Yobou

  # Generates a `.sql` file using the `mysqldump` command
  #
  # @param host [String] the hostname of the database
  # @param username [String] the username for the database connection
  # @param password [String] the password for the database connection
  # @param database [String] the name of the database
  # @param filename [String] a path on the filesystem where the generated dump should be saved
  # @return [Response] a `Response` object having a +bool+ `success` attribute and +Array<String>+ `errors` attribute
  #
  def self.dump(host: '127.0.0.1', username:, password:, database:, filename:)
    command = "mysqldump -h #{host} -u #{username} -p#{password} #{database} > #{filename}"
    Open3.popen3(command) do |_stdin, _stdout, stderr, wait_thr|
      raise "Failed to dump database: #{stderr.read}" unless wait_thr.value.success?
    end

    Response.new(true)
  rescue StandardError => e
    Response.new(false, [e.message])
  end

  # Loads a `.sql` file using the `mysql` command
  #
  # @param host [String] the hostname of the database
  # @param username [String] the username for the database connection
  # @param password [String] the password for the database connection
  # @param database [String] the name of the database
  # @param filename [String] the path on the filesystem to the .sql file that should be loaded
  # @param drop_existing [Boolean] whether an existing database with the same name should be dropped before loading the SQL file
  # @return [Response] a `Response` object having a +bool+ `success` attribute and +Array<String>+ `errors` attribute
  #
  # noinspection RubyMismatchedReturnType
  def self.load(host: '127.0.0.1', username:, password:, database:, filename:, drop_existing: true)
    if drop_existing
      command = "mysql -h #{host} -u #{username} -p#{password} -e \"DROP DATABASE IF EXISTS #{database}\""
      Open3.popen3(command) do |_stdin, _stdout, stderr, wait_thr|
        raise "Failed to drop database: #{stderr.read}" unless wait_thr.value.success?
      end
      command = "mysql -h #{host} -u #{username} -p#{password} -e \"CREATE DATABASE #{database}\""
      Open3.popen3(command) do |_stdin, _stdout, stderr, wait_thr|
        raise "Failed to create database: #{stderr.read}" unless wait_thr.value.success?
      end
    end
    command = "mysql -h #{host} -u #{username} -p#{password} #{database} < #{filename}"
    Open3.popen3(command) do |_stdin, _stdout, stderr, wait_thr|
      raise "Failed to load database: #{stderr.read}" unless wait_thr.value.success?
    end
    
    Response.new(true)
  rescue StandardError => e
    Response.new(false, [e.message])
  end

  private
  
  class Response
    attr_accessor :success, :errors

    def initialize(success, errors = [])
      @success = success
      @errors = errors
    end
    
  end
  
end
