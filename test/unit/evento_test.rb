require 'test_helper'

class EventoTest < ActiveSupport::TestCase
  	fixtures :eventos
  	fixtures :shoppings

	test "evento_valido" do
		evento = Evento.new(:nome => "Teste", :data => "2011-11-30 16:49:35", :local => "Teste", 
		:shopping_id => shoppings(:one).id, :detalhes => "Teste", :imagem => "bla.png")
		assert evento.valid?
		assert evento.save
	end

	test "evento_invalido_nome" do
		evento = Evento.new(:data => "2011-11-30 16:49:35", :local => "Teste", 
		:shopping_id => shoppings(:one).id, :detalhes => "Teste", :imagem => "bla.png")
		assert evento.invalid?
		assert !evento.save
	end

	test "evento_invalido_data" do
		evento = Evento.new(:nome => "Teste",:local => "Teste", 
		:shopping_id => shoppings(:one).id, :detalhes => "Teste", :imagem => "bla.png")
		assert evento.invalid?
		assert !evento.save
	end

	test "evento_invalido_local" do
		evento = Evento.new(:nome => "Teste", :data => "2011-11-30 16:49:35", 
		:shopping_id => shoppings(:one).id, :detalhes => "Teste", :imagem => "bla.png")
		assert evento.invalid?
		assert !evento.save
	end

	test "evento_invalido_shopping_inexistente" do
		evento = Evento.new(:nome => "Teste", :data => "2011-11-30 16:49:35", :local => "Teste", 
		:shopping_id => 50, :detalhes => "Teste", :imagem => "bla.png")
		assert evento.invalid?
		assert !evento.save
	end

	test "evento_invalido_shopping" do
		evento = Evento.new(:nome => "Teste", :data => "2011-11-30 16:49:35", :local => "Teste", 
		:detalhes => "Teste", :imagem => "bla.png")
		assert evento.invalid?
		assert !evento.save
	end

	test "evento_invalido_detalhes" do
		evento = Evento.new(:nome => "Teste", :data => "2011-11-30 16:49:35", :local => "Teste", 
		:shopping_id => shoppings(:one).id, :imagem => "bla.png")
		assert evento.invalid?
		assert !evento.save
	end

	test "evento_invalido_imagem" do
		evento = Evento.new(:nome => "Teste", :data => "2011-11-30 16:49:35", :local => "Teste", 
		:shopping_id => shoppings(:one).id, :detalhes => "Teste")
		assert evento.invalid?
		assert !evento.save
	end

	test "evento_invalido" do
		evento = Evento.new
		assert evento.invalid?
		assert !evento.save
	end

	test "imagem_invalida" do
		evento = Evento.new(:nome => "Teste", :data => "2011-11-30 16:49:35", :local => "Teste", 
		:shopping_id => shoppings(:one).id, :detalhes => "Teste", :imagem => "bla.pdf")
		assert evento.invalid?
		assert !evento.save
	end
end
