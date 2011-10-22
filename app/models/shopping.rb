class Shopping < ActiveRecord::Base
  
  validates_presence_of :nome, :telefone, :localizacao, :email, :descricao, :coordenadas, :imagem
  validates_numericality_of :telefone, :only_integer => true, :count => 9, :message => "só pode ter dígitos."
  validates :telefone, :length => {:is => 9}
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, :message => "inválido."
  
end
