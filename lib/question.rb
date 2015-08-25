require('pry')

class Question < ActiveRecord::Base
  belongs_to(:surveys)
  validates(:question, :presence => true)
  before_save(:capitalize_letter)

  private

  define_method(:capitalize_letter) do
    self.question=question().capitalize()
  end
end
