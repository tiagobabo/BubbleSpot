class Promo < ActiveRecord::Base
  belongs_to :loja
  
  
  validates_presence_of :detalhes, :imagem, :dataf, :produto, :message => "O campo tem de ser preenchido"
  
  
  
end
