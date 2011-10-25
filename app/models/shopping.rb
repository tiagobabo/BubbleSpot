 # -*- coding: utf-8 -*-

class Shopping < ActiveRecord::Base
  
  has_many :lojas, :dependent => :destroy
  
  validates_presence_of :nome, :telefone, :localizacao, :email, :descricao, :imagem
  validates_uniqueness_of :nome
  validates_numericality_of :telefone, :only_integer => true, :count => 9, :message => "só pode ter dígitos."
  validates :telefone, :length => {:is => 9}
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, :message => "inválido."
  
  geocoded_by :localizacao
  after_validation :geocode
end
