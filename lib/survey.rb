require('pry')
class Survey < ActiveRecord::Base
  has_many(:questions)
  validates(:name, :presence => true)
  validates(:num_questions, :presence => true)
  before_save(:capitalize_name)

  private

  define_method(:capitalize_name) do
    words = []
    self.name.split(" ").each() do |word|
      words.push(word.capitalize())
    end
    self.name = words.join(" ")
  end
end
