class IpLog < ActiveRecord::Base
  belongs_to :user

  def self.update_log(ip_log)
    ip_log.update_attribute(:last_seen, Time.now.utc)
  end

  def self.create_log(ip, user)
    user.ip_logs.create(ip: ip, last_seen: Time.now.utc)
  end

  def self.log_ip(ip, user)
    user.update_attribute(:last_ip, ip)
    ip_record = user.ip_logs.where(ip: ip).first
    ip_record.nil? ? create_log(ip, user) : update_log(ip_record)
  end
end
