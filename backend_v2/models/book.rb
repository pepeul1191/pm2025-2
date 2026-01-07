require_relative 'base_model'

class Book < BaseModel
  set_dataset :books
  
  many_to_one :publisher, key: :publisher_id
  one_to_many :reviews, key: :book_id
  many_to_many :authors, left_key: :book_id, right_key: :author_id, join_table: :books_authors
  many_to_many :genres, left_key: :book_id, right_key: :genre_id, join_table: :books_genres
  
  # Método de clase para obtener libros con todas las relaciones
  def self.with_all_associations
    eager(:publisher, :authors, :genres, :reviews)
  end
  
  def to_custom_json
    {
      id: id,
      title: title,
      isbn: isbn,
      pages: pages,
      publication_year: publication_year,
      edition_year: edition_year,
      synopsis: synopsis,
      cover_image: cover_image,
      pdf: pdf,
      publisher: publisher_values,
      authors: authors_values,
      genres: genres_values,
      reviews: reviews_summary
    }
  end
  
  private
  
  def publisher_values
    return nil unless publisher
    {
      id: publisher.id,
      name: publisher.name,
      logo: publisher.logo
    }
  end
  
  def authors_values
    authors.map do |author|
      {
        id: author.id,
        full_name: author.full_name,
        birth_date: author.birth_date&.strftime('%Y-%m-%d'),
        image: author.image
      }
    end
  end
  
  def genres_values
    genres.map do |genre|
      {
        id: genre.id,
        name: genre.name
      }
    end
  end
  
  def reviews_summary
    ratings = reviews.map(&:rating).compact
    average = ratings.empty? ? 0.0 : (ratings.sum.to_f / ratings.size).round(1)
    
    {
      average: average,
      count: ratings.size
    }
  end
end