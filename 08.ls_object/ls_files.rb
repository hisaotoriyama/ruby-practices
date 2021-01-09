# !/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'etc'

class Files
  attr_reader :params, :all_files

  def initialize(params)
    @params = params
    @all_files = Dir.glob('*', File::FNM_DOTMATCH).sort
  end

  def choose_files(params)
    if params['a']
      Dir.glob('*', File::FNM_DOTMATCH).sort
    else
      Dir.glob('*').sort
    end
  end
end
