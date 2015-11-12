module Foxycart
  LISTENERS = Array.new

  def self.subscribe(&block)
    LISTENERS << block
  end

  def self.propagate(event)
    LISTENERS.each {|block| block.call event}
  end

end
