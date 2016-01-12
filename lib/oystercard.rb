require 'pry'

class Oystercard

  attr_reader :balance, :current_journey, :journey_log

  MAXIMUM_BALANCE = 100
  DEFAULT_FARE = 1

  def initialize
    @balance = 0
    @current_journey = {}
    @journey_log = {}
  end

  def top_up(amount)
    fail "you cannot exceed your maximum balance of #{MAXIMUM_BALANCE}" if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(station)
    fail "you have less than #{Oystercard::DEFAULT_FARE} remaining, please top up!" if balance - DEFAULT_FARE < 0
    @current_journey[:entry_station] = station
  end

  def touch_out(station)
    deduct
    @current_journey[:exit_station] = station
    update_history
  end

  def in_journey?
    current_journey[:entry_station] != nil
  end

  private
  def deduct(fare=DEFAULT_FARE)
    @balance -= fare
  end

  def update_history
    journey_log[:"journey#{index}"] = current_journey
    reset_current_journey
  end

  def reset_current_journey
    @current_journey = {}
  end

  def index
    journey_log.count + 1
  end

end
