class Recognition
  
  
  #method takes projection of signs and projection of alphabet
  #it compares each sign with each alphabet letter to chose the letter which fits best
  #then returns array of signs and recognized letters with additional information about similarity between them
  def recognizeLetters(sings_prj, alphabet_prj)
    letters = []
    for sing in sings_prj do
      similarity = 0
      similarity_tmp = 0
      best_letter = nil
      for letter in alphabet_prj do
        similarity_tmp = signs_cmp(sing, letter)
        if similarity_tmp > similarity
          similarity = similarity_tmp   
          best_letter = letter
        end
      end
      letters.append( {
        :sign => sign,
        :letter => best_letter,
        :similarity => similarity
      })
    end
    letters
  end
end