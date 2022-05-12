# frozen_string_literal: true

module Algorithms
  module_function

  def fizzbuzz(max)
    return if max.to_s.strip.empty? || max <= 0

    organize_fizzbuzz(max)
  end

  # sorry, I don't have enough time to implement it
  def smallest_rectangle_of_aspect(ratio, rectangle); end

  def parse_time(str)
    calc_time_difference(str)
  end

  private

  def self.organize_fizzbuzz(max)
    (1..max).to_a.map! do |el|
      remainder_of_three = el % 3.to_f
      remainder_of_five = el % 5.to_f

      if remainder_of_three == 0 && remainder_of_five == 0
        'fizzbuzz'
      elsif remainder_of_three == 0
        'fizz'
      elsif remainder_of_five == 0
        'buzz'
      else
        el
      end
    end
  end

  def self.calc_time_difference(str)
    (Time.parse(str) - Time.parse('00:00')).to_i
  end
end
