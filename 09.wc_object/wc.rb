# !/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

module Wc
  class Main
    def wc_operation
      textexpression = Wc::TextsExpression.new
      textexpression.expression
    end
  end
end

module Wc
  class FileNameTextOrTextInLine
    attr_reader :argv, :with_l

    def initialize
      opt = OptionParser.new
      opt.on('-l') { |v| @with_l = v }
      @argv = opt.parse!(ARGV)
    end

    def extract_text_in_line
      text_in_line = []
      if argv.empty?
        $stdin.readlines
      else
        argv
      end
    end
  end
end

module Wc
  class TextsExpression
    attr_reader :text_in_line, :argv, :with_l

    def initialize
      filenametextortextinline = Wc::FileNameTextOrTextInLine.new
      text_in_line = filenametextortextinline.extract_text_in_line
      @argv = filenametextortextinline.argv
      @with_l = filenametextortextinline.with_l
      @text_in_line = text_in_line
    end

    def expression
      text_in_line_data = []
      row = 0
      total_number = {
        line_count: 0,
        word_count: 0,
        byte_count: 0
      }
      text_in_line.each do |text|
        if argv == []
          wc_summary = Wc::SummaryFilesData.new(total_number, text)
          wc_summary.add_file_data
        elsif File.file?(text)
          file_data = File.open(text)
          file_contents_in_text = file_data.read # string

          wc_summary = Wc::SummaryFilesData.new(total_number, file_contents_in_text)
          wc_summary.add_file_data

          wc_text = Wc::Text.new(file_contents_in_text)
          file_contents_in_text = wc_text.text_detail

          wc_fileformalize = Wc::FileFormalize.new(file_contents_in_text, text)

          formalized_text = ''
          formalized_text = if with_l # (with_l = true)
                              wc_fileformalize.only_with_line
                            else
                              wc_fileformalize.with_full
                            end
          text_in_line_data << formalized_text
          row += 1
        else
          # p text_in_line_data
          # p "wc: #{text}: open: No such file or directory"
          puts "wc: #{text}: open: No such file or directory"
          row += 1
          # p text_in_line_data
        end
      end
      # p text_in_line_data
      if row >= 2
        wc_fileformalize = Wc::FileFormalize.new(total_number, 'total')
        formalized_text = if with_l
                            wc_fileformalize.only_with_line
                          else
                            wc_fileformalize.with_full
                          end
      end

      if argv == []
        wc_fileformalize = Wc::FileFormalize.new(total_number, '')
        formalized_text = if with_l
                            wc_fileformalize.only_with_line
                          else
                            wc_fileformalize.with_full
                          end
      end
    end
  end
end

module Wc
  class Text
    attr_reader :text

    def initialize(text)
      @text = text
    end

    def text_detail
      {
        line_count: text.lines.size,
        word_count: text.split(' ').size,
        byte_count: text.size
      }
    end
  end
end

module Wc
  class SummaryFilesData
    attr_reader :total_number, :file_name_in_text, :wc_text

    def initialize(total_number, file_name_in_text)
      wc_text = Wc::Text.new(file_name_in_text)
      @wc_text = wc_text
      @total_number = total_number
      @file_name_in_text = file_name_in_text
    end

    def add_file_data
      total_number[:line_count] += wc_text.text_detail[:line_count]
      total_number[:word_count] += wc_text.text_detail[:word_count]
      total_number[:byte_count] += wc_text.text_detail[:byte_count]
    end
  end
end

module Wc
  class FileFormalize
    attr_reader :detailed_info_in_hash, :file_name_in_text

    def initialize(detailed_info_in_hash, file_name_in_text)
      @detailed_info_in_hash = detailed_info_in_hash
      @file_name_in_text = file_name_in_text
    end

    def with_full
      puts "#{detailed_info_in_hash[:line_count].to_s.rjust(8)}#{detailed_info_in_hash[:word_count].to_s.rjust(8)}#{detailed_info_in_hash[:byte_count].to_s.rjust(8)} #{file_name_in_text}"
    end

    def only_with_line
      puts "#{detailed_info_in_hash[:line_count].to_s.rjust(8)} #{file_name_in_text}"
    end
  end
end

main = Wc::Main.new
main.wc_operation
