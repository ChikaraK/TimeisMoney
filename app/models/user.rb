class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable,
         :omniauthable,omniauth_providers:[:google_oauth2],
         :authentication_keys => [:employee_code];
  has_many :timecards, dependent: :destroy
  # 登録時に email を不要にする
  def email_required?
    false
  end
  def email_changed?
    false
  end
end

