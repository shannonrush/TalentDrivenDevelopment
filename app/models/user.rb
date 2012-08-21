class User < ActiveRecord::Base
  
  # paperclip
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => '/assets/missing_avatar.png'
    
  # devise
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :background, :statement, :avatar, :public

  # sunspot
  searchable :auto_index => true, :auto_remove => true do
    text :background, :statement, :first_name, :last_name, :email
    boolean :public
  end

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
