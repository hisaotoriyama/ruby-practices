# !/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'etc'
require 'active_support/core_ext/array/grouping'
require './ls_file'

class File
  def initialize(file)
    @stat = File.stat(file)
    @file = file
  end

  def retrieve_permission
    permission_mode(@stat)
  end

  def retrieve_hardlink
    @stat.nlink
  end

  def retrieve_owner
    Etc.getpwuid(@stat.uid).name
  end

  def retrieve_group
    Etc.getgrgid(@stat.gid).name
  end

  def retrieve_size
    @stat.size
  end

  def retrieve_month
    @stat.mtime.month
  end

  def retrieve_day
    @stat.mtime.day
  end

  def retrieve_time
    @stat.mtime.strftime('%H:%M')
  end

  def retrieve_block
    @stat.blocks
  end

  private

  def permission_mode(stat)
    id = format('%<item>06d', item: stat.mode.to_s(8))
    file_type_code = { '100' => '-', '040' => 'd', '120' => 'l' }
    file_type = file_type_code[id[0..2]]
    permission_code = { '7' => 'rwx', '6' => 'rw-', '5' => 'r-x', '4' => 'r--', '3' => '-wx', '2' => '-w-', '1' => '--x', '0' => '---' }
    user_permission = permission_code[id[3]]
    group_permission = permission_code[id[4]]
    others_permission = permission_code[id[5]]
    file_type + user_permission + group_permission + others_permission
  end
end
