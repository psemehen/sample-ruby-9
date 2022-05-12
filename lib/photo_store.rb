# frozen_string_literal: true

module PhotoStore
  module_function

  def finish_time_for_day(date, opening_hours)
    return false unless opening_hours.keys.include?(parsed_visit_day(date))

    self.calc_finish_time(parsed_visit_day(date), date, opening_hours)
  end

  def start_time_for_day(date, opening_hours)
    return false unless opening_hours.keys.include?(parsed_visit_day(date))

    self.calc_start_time(parsed_visit_day(date), date, opening_hours)
  end

  def calculate_completion_time(placed_at, num_hours, opening_hours)
    return false unless opening_hours.keys.include?(parsed_visit_day(placed_at))

    processing_order_time = placed_at + num_hours * 3600
    start_time = self.calc_start_time(parsed_visit_day(placed_at), placed_at, opening_hours)
    finish_time = self.calc_finish_time(parsed_visit_day(placed_at), placed_at, opening_hours)
    return processing_order_time if processing_order_time.between?(start_time, finish_time)

    postponed_days_amount = parsed_visit_day(placed_at) == 'Fri' ? 3 * 86_400 : 1 * 86_400
    start_time + (processing_order_time - finish_time) + postponed_days_amount
  end

  private

  def self.parsed_visit_day(date)
    date.strftime('%a')
  end

  def self.calc_start_time(visit_day, date, opening_hours)
    start_working_hour = opening_hours[visit_day].first.split(':').first
    start_working_minutes = opening_hours[visit_day].first.split(':').last
    Time.mktime(date.year, date.month, date.day, start_working_hour, start_working_minutes)
  end

  def self.calc_finish_time(visit_day, date, opening_hours)
    finish_working_hour = opening_hours[visit_day].last.split(':').first
    finish_working_minutes = opening_hours[visit_day].last.split(':').last
    Time.mktime(date.year, date.month, date.day, finish_working_hour, finish_working_minutes)
  end
end
