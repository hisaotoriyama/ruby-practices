# !/usr/bin/env ruby
# frozen_string_literal: true

require './bowling_oop_shot'

class Frame
  attr_reader :first_shot, :second_shot

  def initialize(first_shot, second_shot)
    @first_shot = Shot.new(first_shot)
    @second_shot = Shot.new(second_shot)
  end
end
