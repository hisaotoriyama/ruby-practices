# !/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'etc'

class Files
  def initialize(params)
    @params = params
  end

  def extract_files(params)
    if params['a']
      Dir.glob('*', File::FNM_DOTMATCH).sort
    else
      Dir.glob('*').sort
    end
  end
end

class Reverse
  attr_reader :total_files, :selected_files

  def initialize(params)
    files = Files.new(params)
    selected_files = files.extract_files(params)
    total_files = Dir.glob('*', File::FNM_DOTMATCH).sort
    @params = params
    @selected_files = selected_files
    @total_files = total_files
  end

  def reorder(files)
    @params['r'] ? files.reverse : files
  end
end

class FilesExpression
  attr_reader :reorganized_files, :files_blocks

  def initialize(params)
    reorganize = Reverse.new(params)
    @reorderd_total_files = reorganize.reorder(reorganize.total_files)
    @reorderd_selected_files = reorganize.reorder(reorganize.selected_files)
    # これでいいのか？疑問
    @params = params
  end

  def express_files
    if @params['l']
      files_blocks = 0
      @reorderd_total_files.each do |f|
        file = File.new(f)
        files_blocks += file.extract_file_block
      end
      reorganized_selected_files = @reorderd_selected_files.map do |f|
        file_content = []
        file = File.new(f)
        file_content << file.extract_file_permission.to_s.rjust(10, '  ')
        file_content << file.extract_file_hard_link.to_s.rjust(3, '  ')
        file_content << file.extract_file_owner_name.to_s.rjust(max_number_uid + 1, '  ')
        file_content << file.extract_file_group_name.to_s.rjust(max_number_gid + 2, '  ')
        file_content << file.extract_file_size.to_s.rjust(6, '  ')
        file_content << file.extract_file_month.to_s.rjust(3, '  ')
        file_content << file.extract_file_day.to_s.rjust(3, '  ')
        file_content << file.extract_file_time.to_s.rjust(6, '  ')
        file_content << " #{f}"
        file_content.join
      end
      file_formatter = FileFormatter.new
      file_formatter.vertical_format(files_blocks, reorganized_selected_files)
    else
      horizontal_format(@reorderd_selected_files)
    end
  end

  def horizontal_format(files)
    max_in_all_file_names = files.map(&:length).max
    column = `tput cols`.to_i / (max_in_all_file_names + 2)
    num_of_columns = (files.count.to_f / column).ceil
    horizontal_format_expression(num_of_columns, max_in_all_file_names, files)
  end

  def horizontal_format_expression(num_of_columns, length_max, files)
    files.each_slice(num_of_columns).to_a.transpose.each do |n|
      puts n.map { |item| item.to_s.ljust(length_max + 2) }.join
    end
  end

  def max_number_uid
    @reorderd_selected_files.map { |file| Etc.getpwuid(File.stat(file).uid).name.length }.max
  end

  def max_number_gid
    @reorderd_selected_files.map { |file| Etc.getgrgid(File.stat(file).gid).name.length }.max
  end
end

class File
  def initialize(file)
    @stat = File.stat(file)
    @file = file
  end

  def extract_file_permission
    permission_mode(@stat)
  end

  def extract_file_hard_link
    @stat.nlink
  end

  def extract_file_owner_name
    Etc.getpwuid(@stat.uid).name
  end

  def extract_file_group_name
    Etc.getgrgid(@stat.gid).name
  end

  def extract_file_size
    @stat.size
  end

  def extract_file_month
    @stat.mtime.month
  end

  def extract_file_day
    @stat.mtime.day
  end

  def extract_file_time
    @stat.mtime.strftime('%H:%M')
  end

  def extract_file_block
    @stat.blocks
  end

  private

  def permission_mode(stat)
    id = format('%<item>06d', item: stat.mode.to_s(8))
    types_of_file = { '100' => '-', '040' => 'd', '120' => 'l' }
    file_type = types_of_file[id[0..2]]
    variation_of_permission = { '7' => 'rwx', '6' => 'rw-', '5' => 'r-x', '4' => 'r--', '3' => '-wx', '2' => '-w-', '1' => '--x', '0' => '---' }
    user_permission = variation_of_permission[id[3]]
    group_permission = variation_of_permission[id[4]]
    others_permission = variation_of_permission[id[5]]
    file_type + user_permission + group_permission + others_permission
  end
end

class FileFormatter
  def vertical_format(files_blocks, reorganized_selected_files)
    puts "total #{files_blocks}"
    reorganized_selected_files.each { |each_file| print("#{each_file}\n") }
  end
end

params = ARGV.getopts('a', 'l', 'r')
expression = FilesExpression.new(params)
expression.express_files
