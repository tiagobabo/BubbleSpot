class Promo < ActiveRecord::Base
  belongs_to :loja
  
  
  validates_presence_of :nome, :detalhes, :horarios, :imagem, :trailer, :message => "O campo tem de ser preenchido"
    
  
end
