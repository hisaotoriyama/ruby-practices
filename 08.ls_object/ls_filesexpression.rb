# !/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'etc'
require 'active_support/core_ext/array/grouping'
require './ls_reverse'
require './ls_file'
require './ls_filesformatter'

class FilesExpression
  attr_reader :reorganized_files, :files_blocks

  def initialize(params)
    reorganize = Reverse.new(params)
    @reorderd_all_files = reorganize.reorder(reorganize.all_files)
    @reorderd_selected_files = reorganize.reorder(reorganize.selected_files)
    @params = params
  end

  def express_files
    file_formatter = FilesFormatter.new
    if @params['l']
      files_blocks = 0
      @reorderd_all_files.each do |each_file|
        file = File.new(each_file)
        files_blocks += file.retrieve_block
      end
      reorganized_selected_files = @reorderd_selected_files.map do |each_file|
        file = File.new(each_file)
        file_content(file, each_file)
      end
      file_formatter.vertical_format(files_blocks, reorganized_selected_files)
    else
      file_formatter.horizontal_format(@reorderd_selected_files)
    end
  end

  def file_content(file, each_file)
    [
      format(file.retrieve_permission, 10),
      format(file.retrieve_hardlink, 3),
      format(file.retrieve_owner, max_num_uid + 1),
      format(file.retrieve_group, max_num_gid + 2),
      format(file.retrieve_size, 6),
      format(file.retrieve_month, 3),
      format(file.retrieve_day, 3),
      format(file.retrieve_time, 6),
      " #{each_file}"
    ].join
  end

  private

  def max_num_uid
    length_array_of_selected_files = @reorderd_selected_files.map do |selected_file|
      file = File.new(selected_file)
      file.retrieve_owner.length
    end
    length_array_of_selected_files.max
  end

  def max_num_gid
    length_array_of_selected_files = @reorderd_selected_files.map do |selected_file|
      file = File.new(selected_file)
      file.retrieve_group.length
    end
    length_array_of_selected_files.max
  end

  def format(text, width)
    text.to_s.rjust(width, '  ')
  end
end
