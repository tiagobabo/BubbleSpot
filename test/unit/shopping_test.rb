require 'test_helper'

class ShoppingTest < ActiveSupport::TestCase
 fixtures :shoppings

	test "shopping_valido" do
		shopping = Shopping.new(:nome => "Teste", :telefone => 123456789, 
		:localizacao => "teste", :descricao => "teste", :imagem => "teste.png", :link_mapa => "teste.png", 
		:email => "teste@teste.com")
		assert shopping.save
	end

	test "shopping_invalido" do
		shopping = Shopping.new
		assert shopping.invalid?
		assert !shopping.save
	end

	test "imagem_invalida" do
		shopping = Shopping.new(:nome => "Teste", :telefone => 123456789, 
		:localizacao => "teste", :descricao => "teste", :imagem => "teste.pdf", :link_mapa => "teste.png",
		:email => "teste@teste.com")
		assert shopping.invalid?
		assert !shopping.save
	end

	test "telefone_invalido_9digitos" do
		shopping = Shopping.new(:nome => "Teste", :telefone => 12345678, 
		:localizacao => "teste", :descricao => "teste", :imagem => "teste.png", :link_mapa => "teste.png",
		:email => "teste@teste.com")
		assert shopping.invalid?
		assert !shopping.save
	end

	test "mapa_invalido" do
		shopping = Shopping.new(:nome => "Teste", :telefone => 123456789, 
		:localizacao => "teste", :descricao => "teste", :imagem => "teste.png", :link_mapa => "teste.pdf",
		:email => "teste@teste.com")
		assert shopping.invalid?
		assert !shopping.save
	end

	test "email_invalido" do
		shopping = Shopping.new(:nome => "Teste", :telefone => 123456789, 
		:localizacao => "teste", :descricao => "teste", :imagem => "teste.png", :link_mapa => "teste.png",
		:email => "teste")
		assert shopping.invalid?
		assert !shopping.save
	end

	test "calculo_coordenadas" do
		shopping = Shopping.new(:nome => "Teste", :telefone => 123456789, 
		:localizacao => "Porto", :descricao => "teste", :imagem => "teste.png", :link_mapa => "teste.png",
		:email => "teste@teste.com")
		assert shopping.save

		assert_equal shopping.latitude, 41.149968
		assert_equal shopping.longitude, -8.6102426
	end
end
