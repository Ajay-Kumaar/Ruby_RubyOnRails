class JidPool < ApplicationRecord
  def self.generate_unused_jids count
    unused_jids = []
    loop do
      jid = SecureRandom.hex(4)
      unless JidPool.exists?(jid: jid)
        unused_jids << jid
        break if unused_jids.size == count
      end
    end
    unused_jids
  end
end