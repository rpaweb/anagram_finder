#!/usr/bin/env ruby

module Enumerable
  ## Establish frecuency.
  def frequency
    each_with_object(Hash.new(0)) { |item, counter| counter[item] += 1 }
  end
end

## Function to determine if words are anagrams.
def are_anagrams?(word1, word2)
  freq = proc { |word| word.gsub(/\s+/, "").downcase.chars.frequency }   # Invoke frecuency to determine comparison.
  freq.(word1) == freq.(word2)
end

## Main.
anagram_list = []
words = File.foreach('words.txt').map { |line| line.split(/\n/).join }   # Read file and convert its text into array.
words.each_with_index do |word1, index|
  words.drop(index).each do |word2|                                      # Loop words array droping previous indexes.
    unless word1 == word2
      if are_anagrams?(word1, word2)                                     # Invoke are_anagrams? function.
        anagram_list.push(word1, word2)                                  # Subscribe the anagram values to compare later.
        puts "Anagram found: #{word1} and #{word2}."
      end
    end
  end
end
puts "Ananagrams found: #{(words - anagram_list).join(", ")}."           # Ananagrams found by compare the 2 arrays.
