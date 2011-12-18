 # -*- coding: utf-8 -*-

class Loja < ActiveRecord::Base
  belongs_to :shopping
  has_many :promos, :dependent => :destroy
  validates_presence_of :shopping
  
  validates_presence_of :nome, :piso, :telefone, :detalhes, :tags, :imagem, :message => "O campo tem de ser preenchido"
  validates_numericality_of :telefone, :only_integer => true, :count => 9, :message => "O telefone só pode ter dígitos."
  validates_numericality_of :piso, :only_integer => true,  :message => "O piso só pode ter dígitos."  
  validates :telefone, :length => {:is => 9, :message => "O telefone tem de ter 9 dígitos"} 

  validates_format_of :imagem, :with => %r{\.(png|jpg|jpeg|bmp|gif)$}i, :message => "O formato da imagem não é válido"
  
end
