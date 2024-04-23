class User < ApplicationRecord

  validates :name, :email, :phone_number, :address, presence: true
  validates :email, uniqueness: {message: ': An account associated with email %{value} already exists.'}
  validates :email, :email_format => { :message => "is not valid. Please enter a vaild email address." }
  validates :phone_number, numericality: true, :length => { :minimum => 10, :maximum => 15 }

  def self.process_bulk_user_details count
    unused_jids_count = JidPool.where(is_used: false).count
    if (unused_jids_count < count || unused_jids_count < Threshold.last.threshold)
      "failure"
    else
      count.times do
        jid = JidPool.where(is_used: false).first.jid
        name = Faker::Name.name
        email = name.delete(' ') + "@gmail.com"
        phone_number = Faker::PhoneNumber.cell_phone_in_e164
        address = Faker::Address.full_address
        User.create(jid: jid, name: name, email: email, phone_number: phone_number, address: address)
        JidPool.where(jid: jid).update(is_used: true)
      end
      "success"
    end
  end

end