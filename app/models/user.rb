class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :validatable

  ## Database authenticatable
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  ## Confirmable
  # field :confirmation_token,   type: String
  # field :confirmed_at,         type: Time
  # field :confirmation_sent_at, type: Time
  # field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time

  # Token
  field :access_token, :type => String
  field :username, :type => String

  # Flags
  field :is_host, :type => Boolean
  validates_presence_of :is_host

  field :host_code, :type => String

  # Associations
  has_many :items

  # Self reference association for Guest/Host
  has_one :host, :class_name => 'User', :inverse_of => :guest
  belongs_to :guest, :class_name => 'User', :inverse_of => :host

  has_one :guest, :class_name => 'User', :inverse_of => :host
  belongs_to :host, :class_name => 'User', :inverse_of => :guest

  after_create :update_access_token!, :generate_host_code

  private

  def update_access_token!
    self.access_token = generate_access_token
    save
  end

  def generate_access_token
    loop do
      token = "#{self.id}:#{Devise.friendly_token}"
      break token unless User.where(access_token: token).first
    end
  end

  def generate_host_code
    if self.is_host
      self.host_code = (('a'...'z').to_a.sample(4) + (0..9).to_a.sample(3)).shuffle.join
      save
    end
  end

end
