 # -*- coding: utf-8 -*-

class Promo < ActiveRecord::Base
  belongs_to :loja  
  validates_presence_of :detalhes, :imagem, :dataf, :produto, :message => "O campo tem de ser preenchido"
  validates_numericality_of :precoi, :greater_than => 0,:message => "O preço inicial não pode ser negativo.", :if => :precoi?
  validates_numericality_of :precof, :greater_than => 0,:message => "O preço final não pode ser negativo nem superior ao preço inicial.", :if => :precof?
  validates_numericality_of :desconto, :greater_than => 0, :less_than => 101, :message => "O desconto tem de ser entre 0 e 100.", :if => :desconto?
  

  
end
