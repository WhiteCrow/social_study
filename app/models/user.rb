class User
  include Mongoid::Document
  include Mongoid::Timestamps
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  ROLES = %w(admin user)

  has_many :microblogs
  has_many :entries
  has_many :relays
  has_many :notes
  has_many :experiences
  has_many :reviews
  has_many :comments
  has_many :reputations
  has_many :reminds, class_name: 'Audit', inverse_of: :receiver
  has_and_belongs_to_many :following, :class_name => 'User', :inverse_of => :followers
  has_and_belongs_to_many :followers, :class_name => 'User', :inverse_of => :following

  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :description

  validates_presence_of :name, :encrypted_password, :role
  validates_uniqueness_of :email, :case_sensitive => false
  validates_inclusion_of :role, in: ROLES
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  def role?(target_role)
    self.role == target_role.to_sym||target_role.to_s
  end

  def image(version=:normal)
    case version
    when :small
      'default-user-small.png'
    else
      'default-user.png'
    end
  end

  def followed?(user)
    self.following_ids.include? user.id
  end

  def can_follow?(user)
    !(([self.id] + self.following_ids).include? user.id)
  end

  def follow(user)
    self.following << user
  end

  def unfollow(user)
    self.following.delete(user)
  end

  def repute(item, type)
    Reputation.create!({
      user: self,
      reputable: item,
      type: type
    })
  end

  def reputation_with(item)
    begin
      Reputation.find_by(user_id: self.id, reputable: item)
    rescue Mongoid::Errors::DocumentNotFound
      nil
    end
  end

  def relay?(relayable)
    return false if self.relays.blank?
    self.relays.map(&:relayable).include? relayable
  end

  def relay(relayable)
    if relayable.user != self
      relay = relayable.relays.new(user_id: self.id)
      relay.save!
    else
      return false
    end
  end

  def unrelay(relayable)
    relay = Relay.where(relayable: relayable, user_id: self.id).first
    relay.destroy
  end

  def unread_reminds
    self.reminds.where(unread: true)
  end

  def read_all_reminds
    self.unread_reminds.each do |remind|
      remind.update_attributes(unread: false)
    end
  end

  def special_entry_by(type)
    return nil if type.blank?
    begin
      self.entries.find_by(type: type)
    rescue
      Entry.send("create_#{type}_with", self.id)
    end
  end

  ## Database authenticatable
  field :name,               :type => String
  field :email,              :type => String, :default => ""
  field :encrypted_password, :type => String, :default => ""
  field :role,               :type => String, :default => "user"
  field :description,        :type => String

  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  ## Confirmable
  # field :confirmation_token,   :type => String
  # field :confirmed_at,         :type => Time
  # field :confirmation_sent_at, :type => Time
  # field :unconfirmed_email,    :type => String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
  # field :locked_at,       :type => Time

  ## Token authenticatable
  # field :authentication_token, :type => String
end
