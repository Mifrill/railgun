class User < ApplicationRecord
  # :lockable - consider using it when users has financial transactions
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :timeoutable

  validates_presence_of :email

  validates_presence_of :password, if: :password_required?
  validate :password_match?, if: :password_required?

  has_many :user_roles
  accepts_nested_attributes_for :user_roles, allow_destroy: true

  # TODO: def timeout_in
  #   if employee?
  #     30.minutes
  #   else
  #     7.days
  #   end
  # end
  #
  # TODO: def employee?
  #   role != 'consumer'
  # end
  #
  # TODO: def confirmation_required?
  #   employee?
  # end

  # def customer?
  #   true
  # end

  # def employee?
  #   false
  # end
  #
  # def administrator?
  #   true
  # end
  #
  def developer?
    false
  end

  def password_required?
    # Password is required if it is being set, but not for new records
    if persisted?
      !password.nil? || !password_confirmation.nil?
    else
      false
    end
  end

  def password_match?
    self.errors[:password] << 'cannot be blank' if password.blank?
    self.errors[:password_confirmation] << 'cannot be blank' if password_confirmation.blank?
    self.errors[:password_confirmation] << 'does not match' if password != password_confirmation
    password.present? && password == password_confirmation
  end
end
