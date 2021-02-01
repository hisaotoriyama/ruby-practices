# !/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../text_detail_calc'
require_relative '../formatter'

module Wc
  module FileNames
    class ResultForEachFileDetail
      def initialize(file_names_in_line, with_l)
        @file_names_in_line = file_names_in_line
        @with_l = with_l
      end

      def show_detail_each_file
        @file_names_in_line.each do |text|
          if File.file?(text)
            wc_text = Wc::TextDetailCalc.new(File.open(text).read)
            Wc::Formatter.new(wc_text.hashed_text_detail, text, @with_l).format_file_or_files.to_s
          else
            puts "wc: #{text}: open: No such file or directory"
          end
        end
      end
    end
  end
end
