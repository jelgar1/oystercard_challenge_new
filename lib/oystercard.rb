require 'pry'

class Oystercard

  attr_reader :balance, :current_journey, :journey_log

  MAXIMUM_BALANCE = 100

  def initialize
    @balance = 0
    @current_journey = nil
    @journey_log = {}
  end

  def top_up(amount)
    fail "you cannot exceed your maximum balance of #{MAXIMUM_BALANCE}" if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(station)
    fail "you have less than #{Journey::DEFAULT_FARE} remaining, please top up!" if balance - Journey::DEFAULT_FARE < 0
    @current_journey = Journey.new
    @current_journey.update_entry_station(station)
  end

  def touch_out(station)
    @current_journey.update_exit_station(station)
    deduct
    update_journey_log
  end

  def in_journey?
    current_journey != nil
  end

  private
  def deduct
    @balance -= @current_journey.fare
  end

  def update_journey_log
    @journey_log[:"journey#{index}"] = @current_journey
    reset_current_journey
  end

  def reset_current_journey
    @current_journey = nil
  end

  def index
    journey_log.count + 1
  end

end
