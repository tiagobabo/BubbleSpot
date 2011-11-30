class Filme < ActiveRecord::Base
  belongs_to :shopping
  
  validates_presence_of :detalhes, :imagem, :dataf, :produto, :message => "O campo tem de ser preenchido"
end
