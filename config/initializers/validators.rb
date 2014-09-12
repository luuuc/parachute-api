class EmailValidator < ActiveModel::EachValidator
  @@default_options = {}

  def self.default_options
    @@default_options
  end

  def validate_each(record, attribute, value)
    options = @@default_options.merge(self.options)
    options[:strict_mode] = true unless options[:strict_mode]

    name_validation = options[:strict_mode] ? "-a-z0-9+._" : "^@\\s"
    unless value =~ /\A\s*([#{name_validation}]{1,64})@((?:[-a-z0-9]+\.)+[a-z]{2,})\s*\z/i
      record.errors.add(attribute, options[:message] || :invalid)
    end
  end
end

class CheckMail
  include ActiveModel::Validations

  attr_accessor :email
  validates :email, email: true
end