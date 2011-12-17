require 'test_helper'

class LojaTest < ActiveSupport::TestCase
  fixtures :lojas
  fixtures :shoppings

	test "loja_valida" do
		loja = Loja.new(:nome => "Teste", 
		:shopping_id => 1, :telefone => 123456789, :piso => 1, :detalhes => "teste", :tags => "teste", :imagem => "teste.png")
		assert loja.save
	end

	test "loja_invalida_nome" do
		loja = Loja.new(:shopping_id => 1, :telefone => 123456789, 
		:piso => 1, :detalhes => "teste", :tags => "teste", :imagem => "teste.png")
		assert !loja.save
	end

	test "loja_invalida_telefone" do
		loja = Loja.new(:nome => "Teste", 
		:shopping_id => 1, :piso => 1, :detalhes => "teste", :tags => "teste", :imagem => "teste.png")
		assert !loja.save
	end

	test "loja_invalida_piso" do
		loja = Loja.new(:nome => "Teste", 
		:shopping_id => 1, :telefone => 123456789, :detalhes => "teste", :tags => "teste", :imagem => "teste.png")
		assert !loja.save
	end

	test "loja_invalida_detalhes" do
		loja = Loja.new(:nome => "Teste", 
		:shopping_id => 1, :telefone => 123456789, :piso => 1, :tags => "teste", :imagem => "teste.png")
		assert !loja.save
	end

	test "loja_invalida_imagem" do
		loja = Loja.new(:nome => "Teste", 
		:shopping_id => 1, :telefone => 123456789, :piso => 1, :detalhes => "teste", :tags => "teste")
		assert !loja.save
	end
=begin
	test "loja_invalida_shopping" do
		loja = Loja.new(:nome => "Teste", 
		:telefone => 123456789, :piso => 1, :detalhes => "teste", :tags => "teste", :imagem => "teste.png")
		assert !loja.save
	end

	test "loja_invalida_shopping_inexistente" do
		loja = Loja.new(:nome => "Teste", 
		:shopping_id => 50, :telefone => 123456789, :piso => 1, :detalhes => "teste", :tags => "teste", :imagem => "teste.png")
		assert !loja.save
	end
=end
	test "loja_invalida" do
		loja = Loja.new
		assert loja.invalid?
		assert !loja.save
	end

	test "imagem_invalida" do
		loja = Loja.new(:nome => "Teste", 
		:shopping_id => 1, :telefone => 123456789, :piso => 1, 
		:detalhes => "teste", :tags => "teste", :imagem => "teste.pdf")
		assert loja.invalid?
		assert !loja.save
	end

	test "telefone_invalido_9digitos" do
		loja = Loja.new(:nome => "Teste", 
		:shopping_id => 1, :telefone => 12345678, :piso => 1, 
		:detalhes => "teste", :tags => "teste", :imagem => "teste.pdf")
		assert loja.invalid?
		assert !loja.save
	end
end
