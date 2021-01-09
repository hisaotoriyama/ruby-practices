# !/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'etc'
require './ls_files'

class Reverse
  attr_reader :params, :selected_files, :all_files

  def initialize(params)
    files = Files.new(params)
    @params = params
    @selected_files = files.choose_files(params)
    @all_files = files.all_files
  end

  def reorder(files)
    @params['r'] ? files.reverse : files
  end
end
