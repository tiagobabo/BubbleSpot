class Shopping < ActiveRecord::Base
  
  
  validates_presence_of :nome, :telefone, :localizacao, :email, :descricao, :coordenadas, :imagem
  
end
