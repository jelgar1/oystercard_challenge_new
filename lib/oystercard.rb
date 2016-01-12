class Oystercard

  attr_reader :balance, :in_journey

  MAXIMUM_BALANCE = 100
  DEFAULT_FARE = 1

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    fail "you cannot exceed your maximum balance of #{MAXIMUM_BALANCE}" if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def deduct(fare=DEFAULT_FARE)
    @balance -= fare
  end

  def touch_in
    fail "you have less than #{Oystercard::DEFAULT_FARE} remaining, please top up!" if balance - DEFAULT_FARE < 0
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

  # def in_journey?
  #   in_journey
  # end

end
