require 'test_helper'

class EventoTest < ActiveSupport::TestCase
  	fixtures :eventos
  	fixtures :shoppings

	test "evento_valido" do
		evento = Evento.new(:nome => "Teste", :data => "2011-11-30 16:49:35", :local => "Teste", 
		:shopping_id => 1, :detalhes => "Teste", :imagem => "bla.png")
		assert evento.save
	end

	test "evento_invalido_nome" do
		evento = Evento.new(:data => "2011-11-30 16:49:35", :local => "Teste", 
		:shopping_id => 1, :detalhes => "Teste", :imagem => "bla.png")
		assert !evento.save
	end

	test "evento_invalido_data" do
		evento = Evento.new(:nome => "Teste",:local => "Teste", 
		:shopping_id => 1, :detalhes => "Teste", :imagem => "bla.png")
		assert !evento.save
	end

	test "evento_invalido_local" do
		evento = Evento.new(:nome => "Teste", :data => "2011-11-30 16:49:35", 
		:shopping_id => 1, :detalhes => "Teste", :imagem => "bla.png")
		assert !evento.save
	end

=begin
	test "evento_invalido_shopping_inexistente" do
		evento = Evento.new(:nome => "Teste", :data => "2011-11-30 16:49:35", :local => "Teste", 
		:shopping_id => 50, :detalhes => "Teste", :imagem => "bla.png")
		assert !evento.save
	end

	test "evento_invalido_shopping" do
		evento = Evento.new(:nome => "Teste", :data => "2011-11-30 16:49:35", :local => "Teste", 
		:detalhes => "Teste", :imagem => "bla.png")
		assert !evento.save
	end
=end
	test "evento_invalido_detalhes" do
		evento = Evento.new(:nome => "Teste", :data => "2011-11-30 16:49:35", :local => "Teste", 
		:shopping_id => 1, :imagem => "bla.png")
		assert !evento.save
	end

	test "evento_invalido_imagem" do
		evento = Evento.new(:nome => "Teste", :data => "2011-11-30 16:49:35", :local => "Teste", 
		:shopping_id => 1, :detalhes => "Teste")
		assert !evento.save
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
