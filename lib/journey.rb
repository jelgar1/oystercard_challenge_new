require_relative 'oystercard'

class Journey

  attr_reader :entry_station, :exit_station, :fare

  PENALTY_FARE = 3
  DEFAULT_FARE = 1

  def initialize
    @entry_station = nil
    @exit_station = nil
    @fare = 0
  end

  def update_entry_station(station)
    @entry_station = station
  end

  def update_exit_station(station)
    @exit_station = station
    complete? ? apply_default_fare : apply_penalty_fare
  end

  private

  def complete?
    (entry_station == nil && exit_station == nil) || (entry_station != nil && exit_station != nil)
  end

  def apply_penalty_fare
    @fare += PENALTY_FARE
  end

  def apply_default_fare
    @fare += DEFAULT_FARE
  end


end
