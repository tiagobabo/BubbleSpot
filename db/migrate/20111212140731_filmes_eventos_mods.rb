class FilmesEventosMods < ActiveRecord::Migration
  def up
    add_column :filmes, :sala, :integer
    add_column :eventos, :local, :string
  end

  def down
  end
end
