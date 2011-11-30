 # -*- coding: utf-8 -*-

class Shopping < ActiveRecord::Base
  
  has_many :lojas, :dependent => :destroy
  has_many :filmes, :dependent => :destroy
  
  validates_presence_of :nome, :telefone, :localizacao, :email, :descricao, :imagem, :message => "O campo tem de ser preenchido"
  validates_uniqueness_of :nome, :message => "Já existe um shopping com esse nome"
  validates_numericality_of :telefone, :only_integer => true, :count => 9, :message => "O telefone só pode ter dígitos."
  validates :telefone, :length => {:is => 9, :message => "O telefone tem de ter 9 dígitos"} 
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, :message => "E-mail inválido."
  
  geocoded_by :localizacao
  after_validation :geocode
  
end
