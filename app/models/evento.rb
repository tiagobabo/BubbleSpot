 # -*- coding: utf-8 -*-

class Evento < ActiveRecord::Base
  belongs_to :shopping
  validates_presence_of :shopping
  validates_presence_of :nome, :detalhes, :data, :imagem, :local, :message => "O campo tem de ser preenchido"
  validates_format_of :imagem, :with => %r{\.(png|jpg|jpeg|bmp|gif)$}i, :message => "O formato da imagem não é válido"
end
