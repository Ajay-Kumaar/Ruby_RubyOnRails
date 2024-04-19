class User < ApplicationRecord
  def self.process_manual_user_details user_details
    jid = JidPool.where(is_used: false).first.jid
    user_details[0] = jid

    
    User.create(jid: user_details[0], name: user_details[1], email: user_details[2], phone_number: user_details[3], address: user_details[4])
    JidPool.where(jid: jid).update(is_used: true)
  end

  def self.process_bulk_user_details count
    count.times do
      jid = JidPool.where(is_used: false).first.jid
      name = SecureRandom.hex(4)
      email = SecureRandom.hex(4) + "@gmail.com"
      phone_number = SecureRandom.hex(5)
      address = SecureRandom.hex(10)
      User.create(jid: jid, name: name, email: email, phone_number: phone_number, address: address)
      JidPool.where(jid: jid).update(is_used: true)
    end
  end

  def self.process_show_user_details
    User.all
  end
end