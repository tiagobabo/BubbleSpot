 # -*- coding: utf-8 -*-

class Promo < ActiveRecord::Base
  belongs_to :loja  
  validates_presence_of :detalhes, :imagem, :dataf, :produto, :desconto, :message => "O campo tem de ser preenchido"
 
  
end
