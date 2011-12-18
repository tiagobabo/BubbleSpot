 # -*- coding: utf-8 -*-

class Filme < ActiveRecord::Base
  belongs_to :shopping

  validates_presence_of :shopping
  validates_presence_of :nome, :detalhes, :horarios, :imagem, :trailer, :sala, :message => "O campo tem de ser preenchido"
  validates_format_of :imagem, :with => %r{\.(png|jpg|jpeg|bmp|gif)$}i, :message => "O formato da imagem não é válido"
  

validates_format_of :trailer, :with => %r(^.*((youtu.be\/)|(v\/)|(embed\/)|(watch\?))\??v?=?([^#\&\?]*).*), :message => "O formato do video não é válido"
end

