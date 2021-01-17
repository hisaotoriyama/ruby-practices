# !/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

module Wc
  class Main
    def operate_wc
      Wc::TextsExpression.new.expression
    end
  end
end

module Wc
  class TextsInLine
    attr_reader :file_names_in_text, :with_l

    def initialize
      opt = OptionParser.new
      opt.on('-l') { |v| @with_l = v }
      @file_names_in_text = opt.parse!(ARGV)
    end

    def read_stdin
      if file_names_in_text.empty?
        $stdin.readlines
      else
        file_names_in_text
      end
    end
  end
end

module Wc
  class TextsExpression
    attr_reader :texts_in_line_after_read_stdin, :file_names_in_text, :with_l

    def initialize
      texts_in_line = Wc::TextsInLine.new
      texts_in_line_after_read_stdin = texts_in_line.read_stdin
      @file_names_in_text = texts_in_line.file_names_in_text
      @with_l = texts_in_line.with_l
      @texts_in_line_after_read_stdin = texts_in_line_after_read_stdin
    end

    def expression
      texts_in_line_data = []
      row = 0
      summary_file_details_in_hash = { line_count: 0, word_count: 0, byte_count: 0 }
      texts_in_line_after_read_stdin.each do |text|
        if file_names_in_text == []
          summary_text(summary_file_details_in_hash, text)
        elsif File.file?(text)
          file_contents_in_text = File.open(text).read

          summary_text(summary_file_details_in_hash, file_contents_in_text)

          wc_text = Wc::Text.new(file_contents_in_text)
          texts_in_line_data << fileorfilesformalize(wc_text.text_detail, text)

          row += 1
        else
          puts "wc: #{text}: open: No such file or directory"
          row += 1
        end
      end
      fileorfilesformalize(summary_file_details_in_hash, 'total') if row >= 2

      fileorfilesformalize(summary_file_details_in_hash, '') if file_names_in_text == []
    end

    private

    def summary_text(text_data_in_hash, text)
      wc_summary = Wc::SummaryFilesData.new(text_data_in_hash, text)
      wc_summary.add_file_data
    end

    def fileorfilesformalize(summary_file_details_in_hash, with_total_expression)
      wc_fileformalize = Wc::FileFormalize.new(summary_file_details_in_hash, with_total_expression)
      if with_l
        wc_fileformalize.only_with_line
      else
        wc_fileformalize.with_full
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
    attr_reader :summary_file_details_in_hash, :file_name_in_text, :wc_text

    def initialize(summary_file_details_in_hash, file_name_in_text)
      wc_text = Wc::Text.new(file_name_in_text)
      @wc_text = wc_text
      @summary_file_details_in_hash = summary_file_details_in_hash
      @file_name_in_text = file_name_in_text
    end

    def add_file_data
      summary_file_details_in_hash[:line_count] += wc_text.text_detail[:line_count]
      summary_file_details_in_hash[:word_count] += wc_text.text_detail[:word_count]
      summary_file_details_in_hash[:byte_count] += wc_text.text_detail[:byte_count]
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
      line_count = format(detailed_info_in_hash[:line_count])
      word_count = format(detailed_info_in_hash[:word_count])
      byte_count = format(detailed_info_in_hash[:byte_count])
      puts "#{line_count}#{word_count}#{byte_count} #{file_name_in_text}"
    end

    def only_with_line
      line_count = format(detailed_info_in_hash[:line_count])
      puts "#{line_count} #{file_name_in_text}"
    end

    private

    WIDTH = 8
    def format(text)
      text.to_s.rjust(WIDTH)
    end
  end
end

main = Wc::Main.new
main.operate_wc
