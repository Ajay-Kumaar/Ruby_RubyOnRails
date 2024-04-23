class Threshold < ApplicationRecord

  def self.set_threshold threshold_value
    Threshold.create(threshold: threshold_value)
  end
  
  def self.get_threshold
    if Threshold.count == 0
      return nil
    else
      Threshold.last.threshold
    end
  end
  
end