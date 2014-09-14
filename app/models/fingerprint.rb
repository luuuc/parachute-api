require 'digest/sha1'

class Fingerprint
  class << self
    def generate
      new(notice).to_s
    end
  end

  def initialize(notice)
    @notice = notice
  end

  def to_s
    Digest::SHA1.hexdigest(source.to_s)
  end

  def source
    {
      notice.api_key,
      notice.error_class,
      notice.message,
      notice.environment_name,
      notice.framework,
      notice.backtrace.map { |b| [b.line, b.location, b.method].join }.join
    }
  end
end


