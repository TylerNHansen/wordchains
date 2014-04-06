require 'set'

class WordChainer
  attr_accessor :dictionary

  LETTERS = ('a'..'z').to_a.join('')


  def initialize(dict_file_name = './dictionary.txt')
    @dictionary = Set.new(File.new(dict_file_name).readlines.map(&:chomp))
  end

  def run(source, target)
    words_to_check = [source]
    found_words = { source => nil}
    self.dictionary.delete(source)


    until words_to_check.empty?
      current = words_to_check.shift
      adjacent_words(current).each do |word|
        self.dictionary.delete(word)
        words_to_check << word.dup
        found_words[word.dup] = current
        return found_words if word == target
      end
    end

    found_words
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