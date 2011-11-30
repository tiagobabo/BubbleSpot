 # -*- coding: utf-8 -*-

class Filme < ActiveRecord::Base
  belongs_to :shopping
  validates_presence_of :nome, :detalhes, :horarios, :imagem, :trailer, :message => "O campo tem de ser preenchido"
  
end
