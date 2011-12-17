require 'test_helper'

class FilmeTest < ActiveSupport::TestCase
  	fixtures :filmes
  	fixtures :shoppings

	test "filme_valido" do
		filme = Filme.new(:nome => "Teste", :sala => 1, :horarios => "Teste", 
		:shopping_id => 1, :detalhes => "Teste", :imagem => "bla.png", :trailer => "http://www.youtube.com/watch?v=SAIEamakLoY")
		assert filme.save
	end

	test "filme_invalido_nome" do
		filme = Filme.new(:sala => 1, :horarios => "Teste", 
		:shopping_id => 1, :detalhes => "Teste", :imagem => "bla.png", :trailer => "http://www.youtube.com/watch?v=SAIEamakLoY")
		assert !filme.save
	end

	test "filme_invalido_sala" do
		filme = Filme.new(:nome => "Teste",:horarios => "Teste", 
		:shopping_id => 1, :detalhes => "Teste", :imagem => "bla.png", :trailer => "http://www.youtube.com/watch?v=SAIEamakLoY")
		assert !filme.save
	end

	test "filme_invalido_ horarios" do
		filme = Filme.new(:nome => "Teste", :sala => 1, 
		:shopping_id => 1, :detalhes => "Teste", :imagem => "bla.png", :trailer => "http://www.youtube.com/watch?v=SAIEamakLoY")
		assert !filme.save
	end

	test "filme_invalido_detalhes" do
		filme = Filme.new(:nome => "Teste", :sala => 1, :horarios => "Teste", 
		:shopping_id => 1, :imagem => "bla.png", :trailer => "http://www.youtube.com/watch?v=SAIEamakLoY")
		assert !filme.save
	end

	test "filme_invalido_imagem" do
		filme = Filme.new(:nome => "Teste", :sala => 1, :horarios => "Teste", 
		:shopping_id => 1, :detalhes => "Teste", :trailer => "http://www.youtube.com/watch?v=SAIEamakLoY")
		assert !filme.save
	end

	test "filme_invalido_trailer" do
		filme = Filme.new(:nome => "Teste", :sala => 1, :horarios => "Teste", 
		:shopping_id => 1, :detalhes => "Teste", :imagem => "bla.png")
		assert !filme.save
	end

=begin
	test "filme_invalido_shopping" do
		filme = Filme.new(:nome => "Teste", :sala => 1, :horarios => "Teste", 
		:detalhes => "Teste", :imagem => "bla.png", :trailer => "http://www.youtube.com/watch?v=SAIEamakLoY")
		assert !filme.save
	end

	test "filme_invalido_shopping_inexistente" do
		filme = Filme.new(:nome => "Teste", :sala => 1, :horarios => "Teste", 
		:shopping_id => 50, :detalhes => "Teste", :imagem => "bla.png", :trailer => "http://www.youtube.com/watch?v=SAIEamakLoY")
		assert !filme.save
	end
=end

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
