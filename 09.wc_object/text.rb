# !/usr/bin/env ruby
# frozen_string_literal: true

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
