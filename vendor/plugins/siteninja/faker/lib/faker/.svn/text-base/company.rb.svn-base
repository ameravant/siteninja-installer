module Faker
  class Company
    class << self
      def name
        Formats.rand.call
      end
    
      def suffix
        %w(Inc. \&\ Sons LLC Group Studio).rand
      end
      
      # Generate a buzzword-laden catch phrase.
      # Wordlist from http://www.1728.com/buzzword.htm
      def catch_phrase
        [
          ["ninja","master","student"].rand, 
          ["", "", "", "", "", "", "weapons", "s' 3rd annual","s' 5th annual","s' 10th annual", "s' secret"].rand,
          ["gathering","celebration","meeting","tournament","competition","party","training camp","sparring event"].rand,
          ["", "", "", "", "", "", "", "", "", "", "with Leonardo", "with Raphael", "with Michaelangelo", "with Donatello"].rand
        ].join(' ').gsub(/ s\'/,'s\'').gsub(/\s\s/,' ').strip
      end
      
      # When a straight answer won't do, BS to the rescue!
      # Wordlist from http://dack.com/web/bullshit.html
      def bs
        [
          ['how to','learning to','ways to','methods to','new mission:','tonight\'s mission:','','','','','','','','','','','','','','','',''].rand,
          ['follow and investigate','assault','slash','carve','karate chop','gash','hack','attack','destroy','defeat','punch','kick','strike','infiltrate','sabotage','duel','assassinate','kidnap','spy on','pummel'].rand,
          ['selfish','unpure','evil','self-serving','treacherous','bad','vile','corrupt','subversive','wicked','hateful','vicious','nefarious','notorious','foul','villanous'].rand,
          ['pirates','thugs','enemies','double-crossers','hypocrites','imposters','two-timers','swindlers','warlords','traitors','raiders','bandits','looters','pillagers','bigots','politicians','maniacs','extremists'].rand
        ].join(' ').strip
      end
    end
    
    Formats = [
      Proc.new { [ Name.last_name, suffix ].join(' ') },
      Proc.new { [ Name.last_name, Name.last_name ].join('-') },
      Proc.new { "%s, %s and %s" % [ Name.last_name, Name.last_name, Name.last_name ] }
      ]
  end
end