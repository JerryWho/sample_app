# == Schema Information
# Schema version: 20101029155113
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :name, :email, :password, :password_confirmation
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name,  :presence => true,
                    :length   => { :maximum => 50 }
                    
  validates :email, :presence => true,
                    :format   => { :with => email_regex },
                    :uniqueness => { :case_sensitive => false }
   
  validates :password, :presence     => true,
                       :confirmation => true,
                       :length       => { :within => 6..40 }
   
     
  before_save :encrypt_password
   
   
  def has_password?(submitted_password)
    encrypt(submitted_password) == encrypted_password
  end   
   
   
  private

    def encrypt_password
      self.encrypted_password = encrypt(password)
    end

    def encrypt(string)
      string # Only a temporary implementation!
    end
                    
end
