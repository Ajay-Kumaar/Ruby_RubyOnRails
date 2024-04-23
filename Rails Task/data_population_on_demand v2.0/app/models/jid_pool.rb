class JidPool < ApplicationRecord

  def self.generate_unused_jids threshold_value
    unused_jids_count = JidPool.where(is_used: false).count
    if unused_jids_count == 0
      threshold_value.times do
        jid = SecureRandom.hex(4)
        unless JidPool.exists?(jid: jid)
          JidPool.create(jid: jid, is_used: false)
        end
      end
      threshold_value
    elsif (unused_jids_count < threshold_value)
      (threshold_value - unused_jids_count).times do
        jid = SecureRandom.hex(4)
        unless JidPool.exists?(jid: jid)
          JidPool.create(jid: jid, is_used: false)
        end
      end
      (threshold_value - unused_jids_count)
    else
      0
    end
  end

  def self.check_unused_jids_count
    if Threshold.count != 0
      unused_jids_count = JidPool.where(is_used: false).count
      threshold_value = Threshold.last.threshold
      if( unused_jids_count == threshold_value || unused_jids_count > threshold_value)
        "success"
      else
        "failure"
      end
    else
      "failure"
    end
  end

end