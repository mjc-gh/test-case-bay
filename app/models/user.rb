class User < ApplicationRecord
  # TODO add :confirmable, :lockable, :timeoutable, and :trackable in the future
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
end
