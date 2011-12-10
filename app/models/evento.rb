class Evento < ActiveRecord::Base
  belongs_to :shopping
   validates_presence_of :nome, :detalhes, :data, :imagem, :message => "O campo tem de ser preenchido"
end
