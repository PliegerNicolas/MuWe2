class User < ApplicationRecord
  after_create :create_profile

  has_one :profile
  has_many :jams

  has_many :user_languages
  has_many :languages, through: :user_languages, source: :language

  has_many :user_instruments
  has_many :instruments, through: :user_instruments, source: :instrument

  has_many :user_music_styles
  has_many :music_styles, through: :user_instruments, source: :music_style

  has_many :ratings

  has_many :participants
  has_many :jam_participations, through: :participants, source: :jam # Events the user is participating in

  has_many :votes

  has_many :messages

  has_many :follows
  has_many :following_relationships, foreign_key: :user_id, class_name: 'Follow'
  has_many :following, through: :following_relationships, source: :following
  has_many :follower_relationships, foreign_key: :following_id, class_name: 'Follow'
  has_many :followers, through: :follower_relationships, source: :follower

  # Add friendship system

  has_many :friendships
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable

  def full_name
    "#{first_name} #{self&.profile&.last_name}".strip
  end

  def non_host_jam_participations
    # Jams where you're participating in without being host
    # (A User is forced to participate to the event as spectator or player to manage the group)
    jam_participations.where.not(user: self)
  end

  def host_jam_participations
    # Jam where you're the host and participating
    # (A User is forced to participate to the event as spectator or player to manage the group)
    jam_participations.where(user: self)
  end

  def friends
    # See my friends (requested and accepted that are confirmed)
    fs = friendships.map { |friendship| friendship.friend if friendship.confirmed }
    i_fs = inverse_friendships.map { |friendship| friendship.user if friendship.confirmed }
    (fs + i_fs).compact.uniq
  end

  def pending_friends
    # Friend requests I sent but are not confirmed yet
    friendships.map { |friendship| friendship.friend unless friendship.confirmed }.compact
  end

  def friend_requests
    # Friend requests from other users that are sent to me
    inverse_friendships.map { |friendship| friendship.user unless friendship.confirmed }.compact
  end

  def friend?(other_user)
    # Check if you're friend with a specific user
    friends.include?(other_user)
  end

  def confirm_friend_request(other_user)
    # Confirm a recieved friend request if exists. If it already exists return true
    fs = inverse_friendships.find { |friendship| friendship.user == other_user }
    fs.confirmed = true
    fs.save
  end

  private

  def create_profile
    Profile.create!(user_id: User.last.id)
  end
end
