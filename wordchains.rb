require 'set'

class WordChainer
  attr_accessor :dictionary

  LETTERS = ('a'..'z').to_a.join('')


  def initialize(dict_file_name = './dictionary.txt')
    @dictionary = Set.new(File.new(dict_file_name).readlines.map(&:chomp))
  end

  def adjacent_words(word)
    words = []
    (0...word.length).each do |pos|
      LETTERS.delete(word[pos]).chars.each do |new_char|
        words << word.dup.tap{ |wrd| wrd[pos] = new_char }
      end
    end
    words.select{ |wrd| self.dictionary.include?(wrd)}
  end


end