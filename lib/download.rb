module Download
  require 'net/http'

  def download_conjugation(page)
    verbs = Array.new
    @verbs_conj = Array.new
    tenses = {present_attributes: 6, imparfait_attributes: 8, passe_compose_attributes: 7, passe_simple_attributes: 10, plus_que_parfait_attributes: 9, futur_simple_attributes: 12, subjonctif_attributes: 15}
    forms = {je: 3, tu: 6, il: 9, nous: 12, vous: 15, ils: 18}
    flag = 1
    i = 53

    url = URI.parse("http://leconjugueur.lefigaro.fr/frlistedeverbe.php")
    @verbs_list = Nokogiri::HTML(open(url))
    while flag == 1 do
      a = @verbs_list.css('li a')[i]
      if a
        verbs.push(a.text)
        i += 1
      else
        flag = 0
      end

    end

    verbs.each_with_index do |verb, i|
      @verbs_conj[i] = Hash.
      verb = verbs[((page.to_i - 1)*10)+i]
      @verbs_conj[i][:infinitive] = verb
      tenses.each do |key, tense|
        @verbs_conj[i][key] = Hash.new
      end
      v = verb.gsub(/[âäàéèêëîïôöûç]/, 'é' =>'e', 'è' =>'e', 'ë' =>'e', 'ê' =>'e','ä' => 'a','â' => 'a','à' => 'a',
        'ô' =>'o','ö' =>'o','û' =>'u','ç' =>'c', 'î' =>'i','ï' =>'i')
      url = "http://leconjugueur.lefigaro.fr/conjugaison/verbe/#{v}.html"
      url_trans = "http://pl.pons.eu/francuski-polski/#{v}"
      @translation = Nokogiri::HTML(open(url_trans))
      @verbs_conj[i][:translation] = @translation.css('td.target a').children[0].text

      @conjugation = Nokogiri::HTML(open(url))
      groupe = @conjugation.css('td b').to_a
      groupe = groupe[1].children[0].text

      a = case groupe
        when "premier groupe" then 1
        when "deuxième groupe" then 2
        when "troisième groupe" then 3
      end

      @verbs_conj[i][:group] = a

      t = @conjugation.css('td').to_a
      tenses.each do |key, tense|
        forms.each do |key2, form|
          if t[tense].children.length < 18
           temp = "-"
          else
            # Usuwanie form "je, j', tu..." oraz "que, qu'il"
            temp = t[tense].children[form-1].text + t[tense].children[form].text
            temp.gsub!("que ", "")
            temp.gsub!("qu'", "")
            if temp.include? "'"
              temp = temp.split("'").pop
            else
              temp = temp.split(" ")
              temp.shift
              temp = temp.join(" ")
            end
          end

          @verbs_conj[i][key][key2] = temp
        end
      end
      if i > page.to_i*10
        break
      end
    end
  end
end


