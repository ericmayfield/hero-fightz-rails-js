
class EmailValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
        record.errors[attribute] << (options[:message] || "is not an email")
      end
    end
  end

class User < ApplicationRecord
    has_many :heros, dependent: :destroy
    has_many :teams, through: :heros
    has_secure_password

    validates :name, format: { without: /[0-9]/, message: "does not allow numbers" }, presence: true
    validates :email, presence: true, uniqueness: true, email: true
    validates :password, confirmation: true, on: :create
    validates :password_confirmation, presence: true, on: :create
end
