 # -*- coding: utf-8 -*-

class Admin < ActiveRecord::Base
  
  attr_accessible :email, :password, :password_confirmation, :tipo, :idref
  
  attr_accessor :password
  before_save :encrypt_password
  
  validates_confirmation_of :password, :message => "A password não coincide com a de confirmação"
  validates_presence_of :password, :on => :create, :message => "O campo não pode estar vazio"
  validates_presence_of :email, :message => "O campo não pode estar vazio"
  validates_uniqueness_of :email, :message => "O e-mail já existe"
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, :message => "O e-mail é inválido"
  validates :password, :length => {:is => 6, :message => "A password tem de conter mais de 6 caracteres"}
  
  
  
  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end
  
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
  
end
