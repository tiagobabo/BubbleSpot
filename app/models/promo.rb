 # -*- coding: utf-8 -*-

class Promo < ActiveRecord::Base
  belongs_to :loja  
  
  validates_presence_of :loja
  validates_presence_of :detalhes, :imagem, :dataf, :desconto, :produto, :tags, :message => "O campo tem de ser preenchido"
  validates_format_of :imagem, :with => %r{\.(png|jpg|jpeg|bmp|gif)$}i, :message => "O formato da imagem não é válido"

  scope :ativas, lambda { {:conditions => ["dataf >= '#{Time.now.to_s(:db)}'"]} }

    



end
