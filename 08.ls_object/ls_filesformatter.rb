# !/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'etc'

module Ls
  class FilesFormatter
    def vertical_format(files_blocks, reorganized_selected_files)
      puts "total #{files_blocks}"
      reorganized_selected_files.each { |each_file| print("#{each_file}\n") }
    end

    def horizontal_format(files)
      max_in_all_file_names = files.map(&:length).max
      column = `tput cols`.to_i / (max_in_all_file_names + 2)
      num_of_columns = (files.count.to_f / column).ceil
      horizontal_format_expression(num_of_columns, max_in_all_file_names, files)
    end

    def horizontal_format_expression(num_of_columns, length_max, files)
      add_nil_num = num_of_columns - (files.length % num_of_columns)
      add_nil_num.times { |_n| files << nil }
      files_group = files.each_slice(num_of_columns).map { |arr| arr }
      files_group.transpose.each do |n|
        puts n.map { |item| item.to_s.ljust(length_max + 2) }.join
      end
    end
  end
end
