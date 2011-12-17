require 'test_helper'

class EventoTest < ActiveSupport::TestCase
  	fixtures :eventos

	test "evento_valido" do
		evento = Evento.new(:nome => "Teste", :data => "2011-11-30 16:49:35", :local => "Teste", 
		:shopping_id => 1, :detalhes => "Teste", :imagem => "bla.png")
		assert evento.save
	end

	test "evento_invalido" do
		evento = Evento.new
		assert evento.invalid?
		assert !evento.save
	end

	test "imagem_invalida" do
		evento = Evento.new(:nome => "Teste", :data => "2011-11-30 16:49:35", :local => "Teste", 
		:shopping_id => 1, :detalhes => "Teste", :imagem => "bla.pdf")
		assert evento.invalid?
		assert !evento.save
	end
end
