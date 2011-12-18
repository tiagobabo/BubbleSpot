require 'test_helper'

class PromoTest < ActiveSupport::TestCase
  fixtures :shoppings
  fixtures :lojas

  test "promo_valida" do
		promo = Promo.new(:detalhes => "Teste", 
		:loja_id => 1, :precoi => 10.0, :precof => 5.0, :desconto => 50.0, 
		:imagem => "teste.png", :dataf => "2011-11-25 15:11:52", :produto => "Teste", :tags => "teste")
		assert promo.save
	end

	test "promo_invalida_valores" do
		promo = Promo.new(:detalhes => "Teste", 
		:loja_id => 1, :precoi => 10.0, :precof => 5.0, :desconto => 30.0, 
		:imagem => "teste.png", :dataf => "2011-11-25 15:11:52", :produto => "Teste", :tags => "teste")
		assert !promo.save
	end

	test "promo_invalida_detalhes" do
		promo = Promo.new(
		:loja_id => 1, :precoi => 10.0, :precof => 5.0, :desconto => 30.0, 
		:imagem => "teste.png", :dataf => "2011-11-25 15:11:52", :produto => "Teste", :tags => "teste")
		assert !promo.save
	end

	test "promo_invalida_desconto" do
		promo = Promo.new(:detalhes => "Teste", 
		:loja_id => 1, :precoi => 10.0, :precof => 5.0, 
		:imagem => "teste.png", :dataf => "2011-11-25 15:11:52", :produto => "Teste", :tags => "teste")
		assert !promo.save
	end

	test "promo_invalida_imagem" do
		promo = Promo.new(:detalhes => "Teste", 
		:loja_id => 1, :precoi => 10.0, :precof => 5.0, :desconto => 30.0, 
		:dataf => "2011-11-25 15:11:52", :produto => "Teste", :tags => "teste")
		assert !promo.save
	end

	test "promo_invalida_dataf" do
		promo = Promo.new(:detalhes => "Teste", 
		:loja_id => 1, :precoi => 10.0, :precof => 5.0, :desconto => 30.0, 
		:imagem => "teste.png", :produto => "Teste", :tags => "teste")
		assert !promo.save
	end

	test "promo_invalida_produto" do
		promo = Promo.new(:detalhes => "Teste", 
		:loja_id => 1, :precoi => 10.0, :precof => 5.0, :desconto => 30.0, 
		:imagem => "teste.png", :dataf => "2011-11-25 15:11:52",  :tags => "teste")
		assert !promo.save
	end

	test "imagem_invalida" do
		promo = Promo.new(:detalhes => "Teste", 
		:loja_id => 1, :precoi => 10.0, :precof => 5.0, :desconto => 50.0, 
		:imagem => "teste.pdf", :dataf => "2011-11-25 15:11:52", :produto => "Teste", :tags => "teste")
		assert !promo.save
	end

end