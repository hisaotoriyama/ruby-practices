# !/usr/bin/env ruby
# frozen_string_literal: true

require './wc_textsexpression'

module Wc
  class Main
    def operate_wc
      Wc::TextsExpression.new.expression
    end
  end
end

main = Wc::Main.new
main.operate_wc
