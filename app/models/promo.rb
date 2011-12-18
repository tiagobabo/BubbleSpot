 # -*- coding: utf-8 -*-

class Promo < ActiveRecord::Base
  belongs_to :loja  
  # validates_presence_of :loja
  validates_presence_of :detalhes, :imagem, :dataf, :desconto, :produto, :tags, :message => "O campo tem de ser preenchido"
  validates_format_of :imagem, :with => %r{\.(png|jpg|jpeg|bmp|gif)$}i, :message => "O formato da imagem não é válido"
  
  validate :precoi_precof_desconto

  def precoi_precof_desconto

  	if (!precoi.nil? and !precof.nil? and !desconto.nil?)
  	    if (desconto/100.0)*precoi != precof
  		    errors.add(:desconto, "O desconto não coincide com os valores apresentados.")
        end
  	end
  end


end
