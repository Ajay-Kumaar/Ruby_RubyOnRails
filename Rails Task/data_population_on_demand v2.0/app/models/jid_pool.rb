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
    elsif (unused_jids_count < threshold_value)
      (threshold_value - unused_jids_count).times do
        jid = SecureRandom.hex(4)
        unless JidPool.exists?(jid: jid)
          JidPool.create(jid: jid, is_used: false)
        end
      end
    end
  end
end