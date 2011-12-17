require 'test_helper'

class FilmeTest < ActiveSupport::TestCase
  	fixtures :filmes

	test "filme_valido" do
		filme = Filme.new(:nome => "Teste", :sala => 1, :horarios => "Teste", 
		:shopping_id => 1, :detalhes => "Teste", :imagem => "bla.png", :trailer => "http://www.youtube.com/watch?v=SAIEamakLoY")
		assert filme.save
	end

	test "filme_invalido" do
		filme = Filme.new
		assert filme.invalid?
		assert !filme.save
	end

	test "imagem_invalida" do
		filme = Filme.new(:nome => "Teste", :sala => 1, :horarios => "Teste", 
		:shopping_id => 1, :detalhes => "Teste", :imagem => "bla.pdf", :trailer => "http://www.youtube.com/watch?v=SAIEamakLoY")
		assert filme.invalid?
		assert !filme.save
	end

	test "trailer_invalido" do
		filme = Filme.new(:nome => "Teste", :sala => 1, :horarios => "Teste", 
		:shopping_id => 1, :detalhes => "Teste", :imagem => "bla.png", :trailer => "http://google.com")
		assert filme.invalid?
		assert !filme.save
	end

end
