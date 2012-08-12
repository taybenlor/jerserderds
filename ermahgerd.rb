
module Ermahgerd
  def self.ternslert_terkst perergref
    werds = perergref.split ' '
    werds = werds.collect do |werd|
      if werd.match /[A-z]/
        #hacky special case treatment
        if werd.match /-/
          mer_werds = werd.split '-'
          mer_werds = mer_werds.collect {|werd| ternslert_terkst werd}
          next mer_werds.join('-')
        end

        if werd.upcase.match /FRANCISCO$/
          next 'Sern Frernsersker'
        end

        if werd.match /http:\/\/[A-z0-9.\/-]*/
          next werd
        end

        ternslerted = ternslert(werd.upcase).downcase

        if werd[0].match /[^A-z]/
          ternslerted = werd[0] + ternslerted
        end

        if werd[-1].match /[^A-z]/
          ternslerted += werd[-1]
        end

        if werd.match(/^[^a-z]*$/) && werd.length != 1
          ternslerted = ternslerted.upcase
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
      return 'UER/UERX'
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
    when 'SQUARE'
      return 'SKWER'
    when 'BASED'
      return 'BERSED'
    when 'UI'
      return 'UER'
    when 'USING'
      return 'URSERN'
    when 'FACEBOOK'
      return 'FERCEBERK'
    when 'ALONG'
      return 'ERLERNG'
    when 'TUNES'
      return 'TURNES'
    when 'LIMITED'
      return 'LERMERTERD'
    when 'MAPLE'
      return 'MERPERL'
    when 'JESSEDODDS'
      return 'JERSERDERDS'
    when '@JESSEDODDS'
      return '@JERSERDERDS'
    when 'CC/'
      return 'CC/'
    when 'METICULOUS'
      return 'MERTERCERLERS'
    when "I'M"
      return "ERM"
    end
    
    if werd.match /[Mm]+\.*/
      return werd
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

    # A -> ER
    werd = werd.gsub /A/, 'ER'

    # MY -> MAH
    #werd = werd.gsub /MER/, 'MAH'

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

    werd = werd.gsub /^DA$/, 'DER'

    # YELLOW -> YERLER -> YERLO
    if erginerl.match(/LOW$/) && werd.match(/LOW$/)
      werd = werd.gsub /LOW$/, 'LO'
    end

    if erginerl.match(/CE$/) && werd.match(/C$/)
      werd = werd.gsub /C$/, 'S'
    end

    werd
  end
end