require 'bundler'
Bundler.require

require 'open-uri'

get '*' do
  f = open "http://jessedodds.com#{params[:splat].first}"
  type = f.content_type
  body = f.read

  if type == 'text/html'
    doc = Nokogiri::HTML(body)
    doc.traverse do |node|
      if node.text?
        node.content = Ermahgerd.ternslert_terkst node.content
      end
    end
    body = doc.to_html
  end

  [
    200,
    {
      "Content-Type" => type
    }, 
    body
  ]
end

module Ermahgerd
  def self.ternslert_terkst perergref
    werds = perergref.split ' '
    werds = werds.collect do |werd|
      if werd.match /[A-z]/
        ternslerted = ternslert(werd.upcase).downcase

        if werd[0].match /[^A-z]/
          ternslerted = werd[0] + ternslerted
        end

        if werd[-1].match /[^A-z]/
          ternslerted += werd[-1]
        end

        if werd[0].match /[A-Z]/
          ternslerted[0] = ternslerted[0].upcase
        end

        ternslerted
      else
        werd
      end
    end

    werds = werds.join ' '

    if perergref[0] == ' '
      werds = ' ' + werds
    end

    if perergref[-1] == ' '
      werds += ' '
    end
    werds
  end

  def self.ternslert werd
    case werd
    when 'UI/UX'
      return 'ER/ERKS'
    when 'AWESOME'      
      return 'ERSUM'
    when 'BANANA'       
      return 'BERNERNER'
    when 'BAYOU'        
      return 'BERU'
    when 'FAVORITE'
      return 'FRAVRIT'   
    when 'FAVOURITE'    
      return 'FRAVRIT'
    when 'GOOSEBUMPS'   
      return 'GERSBERMS'
    when 'LONG'         
      return 'LERNG'
    when 'MY'           
      return 'MAH'
    when 'THE'          
      return 'DA'
    when 'THEY'         
      return 'DEY'
    when 'WE\'RE'       
      return 'WER'
    when 'YOU'          
      return 'U'
    when 'YOU\'RE'      
      return 'YER'
    when 'JESSE'
      return 'JERSER'
    when 'DODDS'
      return 'DERDS'
    end
    
    erginerl = werd
    
    #drop vowels at end of werd
    werd = werd.sub /[AEIOU]$/, '' unless erginerl.length <= 2

    #reduce duplicate letters
    werd = werd.gsub /[^\w\s]|(.)(?=\1)/i, ''

    #reduce adjacent vowels to one
    werd = werd.gsub /[AEIOUY]{2,}/, 'E'

    # DOWN -> DERN
    werd = werd.gsub /OW/, 'ER'

    # PANCAKES -> PERNKERKS
    werd = werd.gsub /AKES/, 'ERKS'

    # The mean and potatoes: gsub vowels with ER
    werd = werd.gsub /[AEIOUY]/, 'ER'

    # OH -> ER
    werd = werd.gsub /ERH/, 'ER'

    # MY -> MAH
    werd = werd.gsub /MER/, 'MAH'

    # FALLING -> FERLIN
    werd = werd.gsub /ERNG/, 'IN'

    # POOPED -> PERPERD -> PERPED
    werd = werd.gsub /ERPERD/, 'ERPED'

    # MEME -> MAHM -> MERM
    werd = werd.gsub /MAHM/, 'MERM'

    # Keep Y as first character
    # YES -> ERS -> YERS
    werd = 'Y' + werd if erginerl[0] == 'Y'

    # Reduce duplicate letters
    werd = werd.gsub /[^\w\s]|(.)(?=\1)/i, ''

    # YELLOW -> YERLER -> YERLO
    if erginerl.match(/LOW$/) && werd.match(/LOW$/)
      werd = werd.gsub /LOW$/, 'LO'
    end

    if erginerl.match(/CE$/) && werd.match /C$/
      werd = werd.gsub /C$/, 'S'
    end

    werd
  end
end