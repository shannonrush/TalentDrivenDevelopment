class User < ActiveRecord::Base
  
  # paperclip
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => '/assets/missing_avatar.png'
    
  # devise
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :background, :statement, :avatar, :public

  def full_name
    self.first_name+" "+self.last_name
  end

  def agent?
    self.kind_of? Agent
  end

  def talent?
    self.kind_of? Talent
  end

end
