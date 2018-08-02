class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :collections
  has_many :challenges
  has_many :prompts
  has_many :assigned_prompts, foreign_key: :assignee_id
  has_many :tag_sets
  has_many :set_taggings
  has_many :challenge_mods
  has_many :modded_challenges, through: :challenge_mods
end
