module Tokenize
  extend ActiveSupport::Concern

private

  def generate_token(column, options = { size: 10, secure: false })
    size = options[:size] || 10
    secure = options[:secure] || false

    begin
      self[column] = secure ? secure_token : human_token(size)
    end while self.class.exists?(column => self[column])
  end

  def human_token(size)
    authorized_chars = 'ABCDEFHIJKLMNPQRSTUVWXYZ'.split('') | '123456789'.split('')
    Array.new(size) { authorized_chars[rand(authorized_chars.size)] }.join.to_s
  end

  def secure_token
    #SecureRandom.urlsafe_base64(25).tr('lIO0', 'sxyz')
    SecureRandom.hex
  end
end