class Movie < ActiveRecord::Base
  def self.all_ratings
   # ['G','PG','PG-13','R']
    %w(G PG PG-13 R)
   end
  
  def self.filter_and_sort(selected,sort)
   Movie.where('rating':selected).order(sort) 
  end
end
