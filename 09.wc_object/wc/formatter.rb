# !/usr/bin/env ruby
# frozen_string_literal: true

require './texts_in_line'
require './text'
require './file_content'

module Wc
  class Formatter
    def initialize(file_names_or_texts_in_line, with_l)
      @file_names_or_texts_in_line = file_names_or_texts_in_line
      @with_l = with_l
    end

    # （フォーマット）全ファイルとNonファイルの内容のフォーマット
    def show_detail_each_file
      @file_names_or_texts_in_line.each do |text|
        if File.file?(text)
          file_contents_in_text = File.open(text).read

          wc_text = Wc::Text.new(file_contents_in_text)
          format_file_or_files(wc_text.text_detail, text).to_s # （1行1行フォーマット）1行1行あたりのファイル情報の内容のフォーマット

        else
          puts "wc: #{text}: open: No such file or directory"
        end
      end
    end

    # （with_l or without_l）1行1行あたりの対象情報の抽出方法
    def format_file_or_files(sum_hashed_file_detail, with_total)
      wc_filecontent = Wc::FileContent.new(sum_hashed_file_detail, with_total)
      if @with_l
        wc_filecontent.show_only_with_line
      else
        wc_filecontent.show_with_full
      end
    end
  end
end
