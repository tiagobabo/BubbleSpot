require 'test_helper'

class LojaTest < ActiveSupport::TestCase
  fixtures :lojas

	test "loja_valida" do
		loja = Loja.new(:nome => "Teste", 
		:shopping_id => 1, :telefone => 123456789, :piso => 1, :detalhes => "teste", :tags => "teste", :imagem => "teste.png")
		assert loja.save
	end

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
