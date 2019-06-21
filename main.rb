#require 'terminfo'
require './resources/colorize'
require './resources/text-adv-methods'
Game = Text_Adv
# if dead
catch :dead do
  # intro
  Game.n(2)
  puts 'Text Adv. alpha 1.2.0'.center(26)
  Game.newline
  puts "      By: Alexander\n   Press enter to start".center(26)
  foo = gets.chomp.capitalize
  Game::Save.load if foo == 'Load'
  # options
  if $chunk == 0
    loop do
      puts '  Choose your difficulty'
      Game::Options.set(%w[Easy Medium Hard Hardcore])
      Game::Options.print
      Game.prompt
      $difficulty = gets.chomp.capitalize
      case $difficulty
      when 'Easy'
        break
      when 'Medium'
        break
      when 'Hard'
        break
      when 'Hardcore'
        break
      else
        Game.n
        Game.newline
        puts "That's not an option!"
        Game.newline
        Game.n
      end
    end
    catch :foo do
      loop do
        puts "\n    What's your name?"
        Game.newline
        Game.prompt
        $name = gets.chomp.capitalize
        loop do
          Game.n
          puts "      Are you sure?"
          Game.newline
          Game.prompt
          foo = gets.chomp.capitalize
          if foo == 'Yes'
            throw :foo
          elsif foo == 'No'
            break
          else
            Game.newline
            Game.n
            puts "  That's not an option!"
            Game.newline
            Game.n
          end
        end
      end
    end
    loop do
      Game.n
      puts "    What's your gender?"
      Game.newline
      Game.prompt
      $gender = gets.chomp.capitalize
      case $gender
      when 'Male'
        break
      when 'Female'
        break
      when 'Asexual'
        break
      when 'Trans'
        break
      when 'Transgender'
        break
      else
        Game.newline
        puts "That's not an option!"
        Game.newline
        Game.n
      end
      Game.set_gender_specific_words
    end
    Game.eoc
  end
  # chunk 1
  if $chunk == 1
    puts "\n    Welcome, #{$name}."
    Game.newline
    puts "You wake up in the morning, stretching. As you open your eyes, you find yourself on a large beach. It's hot, maybe 80 degrees despite the salty ocean breeze, and exceptionally humid. You can hear the gentle sound of the ocean lapping at your feet, and some birds flying overhead. You don't remember how you got here, but you feel some items in your pockets."
    Game::Options.set(['Look around', 'Look in your pockets', 'Go back to sleep', 'Pinch yourself'])
    while $continue != 1
      Game::Options.print
      Game.prompt
      option = gets.chomp.capitalize
      Game.n
      $variation = 0
      bar = 1
      if Game::Options.check('Look around', option) == true
        Game.newline
        if $difficulty == 'Easy'
          puts "You examine your surroundings. You're on the edge of a beach with fine, white sand inside a shallow lagoon with crystal clear turquoise water and the edges of the bay stretching around. There's plenty of fish and other sea creatures living among the barnacle adorned rocks, and coral peeking out in between. Behind you, you can see the edge of a tropical forest closer to the center of the island with mountains looming in the background and what seems to be an decently sized plain running alongside the beach. It seems like a perfect tropical island that you have no idea how to survive on."
        elsif $difficulty == 'Medium'
          puts "You examine your surroundings. You're on the edge of a beach with fine, white sand inside a shallow lagoon with clear turquoise water and the edges of the bay stretching around. You spot some fish and other sea creatures living among the barnacle adorned rocks. Behind you, you can see the edge of a tropical forest closer to the center of the island with huge mountains looming in the background and what seems to be an endless plain running alongside the beach. It seems like a perfect tropical island that you have no idea how to survive on."
        elsif $difficulty == 'Hard'
          puts "You examine your surroundings. You're on the edge of a beach with fine, white sand inside a lagoon with turquoise water and the edges of the bay stretching around. There's a few fish and other sea creatures living among the barnacle adorned rocks. Behind you, you can see the edge of a dark tropical forest closer to the center of the island with huge, misty mountains looming in the background and what seems to be an endless plain running alongside the beach. It seems like a tropical island that you have no idea how to survive on."
        elsif $difficulty == 'Hardcore'
          puts "You examine your surroundings. You're on the edge of a beach with fine, white sand inside a lagoon with a little dirty looking turquoise water and the edges of the bay curving around. You barely manage to spot some fish and other sea creatures living among the algae covered rocks. Behind you, you can see the edge of a dark tropical forest closer to the center of the island with massive, misty mountains looming in the background and what seems to be an endless plain running alongside the beach. It seems like a tropical island that you have no idea how to survive on."
        end
        Game::Options.add('Go to the plain and see how far it goes')
        Game::Options.add('Head into the tropical forest')
        Game::Options.remove(option)
        Game::Options.remove('Go back to sleep')
      elsif Game::Options.check('Head into the tropical forest', option) == true
        $variation = 1
        $continue = 1
      elsif Game::Options.check('Go to the plain and see how far it goes', option) == true
        Game.newline
        if $difficulty == 'Easy'
          puts "You hike over to the plain, and once you crest the ridge of the hill, you find that it widens quickly, stretching out of sight into a massive plain. You don't see anything notable, but as you start to decide what you're going to do, you notice something streaking up into the sky that's definetly not a bird, coming from the other side of the forest."
        elsif $difficulty == 'Medium'
          puts "You hike over to the plain, and once you crest the ridge of the hill, you see it stretching along for another while, wrapping around the island beyond your sight; widening into an enormous field near the end."
        elsif $difficulty == 'Hard'
          puts "You hike over to the plain, and once you crest the ridge of the hill, you see it continues along the edge of the beach for a little while, bordered by the dark woods, stopping abruptly at the end."
        elsif $difficulty == 'Hardcore'
          puts "You hike over to the edge"
        end
        Game::Options.remove(option)
        bar = 5
      elsif Game::Options.check('Look in your pockets', option) == true
        foo1 = 0
        Game.newline
        $inventory.join(', ')
        if $difficulty == 'Easy'
          puts 'You search your pockets for anything that might be of use. You find a lighter, a pocketknife, a wad of soggy cash, a worn down wallet with a credit card and a few other things in it, and an envelope. '
          Game::Inventory.add(['A lighter', 'Pocketknife', 'Wad of soggy cash', ['Worn down wallet', 'contains credit card', 'library card'], ['Wet envelope', 'contains a note']])
          foo1 = 1
        elsif $difficulty == 'Medium'
          puts 'You search your pockets for anything that might be of use. You find a wad of soggy cash, a worn down wallet with a credit card and a few other things in it, and an envelope. '
          Game::Inventory.add(['Wad of soggy cash', ['Worn down wallet', 'contains credit card', 'library card'], ['Wet envelope', 'contains a note']])
          foo1 = 1
        elsif $difficulty == 'Hard'
          puts 'You search your pockets for anything that might be of use. You find a wad of mushy, soggy cash and an envelope. '
          Game::Inventory.add(['Wad of soggy cash', ['Wet envelope', 'contains a note']])
        elsif $difficulty == 'Hardcore'
          puts 'You search your pockets for anything that might be of use. You find a wad of soggy cash. It appears to be absolutely destroyed.'
          Game::Inventory.add(['Destroyed wad of soggy cash'])
        end
        Game::Options.remove(option)
        Game::Options.add('Open the envelope') if foo1 == 1
      elsif Game::Options.check('Go back to sleep', option) == true
        Game.newline
        puts "You decide to go back to sleep on the warm beach in the nice, soft, sand, hoping you'll wake up in your bed. \nThe sun shines overhead... \nZzz... \nZzz..."
        Game::Options.remove(option)
        $continue = 1
        $variation = 0
        if $difficulty == 'Easy' || $difficulty == 'Medium'
          Game::Time.set('Evening')
        elsif $difficulty == 'Hard' || $difficulty == 'Hardcore'
          Game::Time.set('Night')
        end
      elsif Game::Options.check('Pinch yourself', option) == true
        Game.newline
        puts "You pinch yourself, hoping that you're dreaming. It hurts sharply. Well, guess that's ruled out. \n#{"-1 HP".red}"
        $health -= 1
        Game::Options.remove(option)
      elsif option == 'Pinch yourself'
        Game.newline
        puts "You pinch yourself again, still hoping that you're dreaming. It hurts even more. It really dosen't seem like you're dreaming. \n#{"-1 HP".red}"
        $health -= 1
      elsif Game::Options.check('Open the envelope', option) == true
        Game.newline
        puts 'You open the envelope, being careful not to tear the soggy paper. Inside, you find a holiday card. It has a pretty handmade drawing of a firework bursting on the front but after peeling it open, the ink has bled too much to be readable. You notice a small keychain taped to the side which has managed to stay on even after the card being soaked.'
        Game::Options.add('Examine the keychain')
        Game::Options.remove(option)
      elsif Game::Options.check('Examine the keychain', option) == true
        Game.newline
        puts "You look closer at the keychain and you notice that even after the beating it's been through, it still appears to be brand new. You recognize the emblem on the front even though you don't remember ever seeing it. On the back is a little slot for a watch battery, but it dosen't currently have one in it."
        Game::Options.remove(option)
      elsif Game::Options.check('Insert the watch battery', option) == true && Game.Inventory.contains?(Watch battery)
        Game.newline
        puts 'You insert the watch battery into the small slot in the keychain. It lights up with a yellow glow, and you realize that the sun emblem on the front is really 8 different buttons with a central large one.'
        Game::Options.add('Press a button', 'Press the center one')
      else
        if $options.include?(option.to_s) == false
          Game.newline
          puts "That's not an option!"
        end
      end
      if $health == 0
        Game.n
        Game.newline
        puts "You've been playing this game far too long. \nYou have earned the Determined Pincher acheivement! \n+1 Watch battery #{"\nYou magically regenerate all of your HP by the will of the game developers.".green}"
        Game::Inventory.add('Watch battery')
        Game::Options.add('Insert the watch battery')
        Game::Achivements.add('Determined Pincher')
        $health = 100
      end
      Game::Time.step(bar)
    end
    Game.eoc
  end
  if $chunk == 2
    # chunk 2
    if $variation == 0
      Game::Options.set([dgf])
      while $continue != 1
        Game.newline
        Game.print_options
        Game.prompt
        option = gets.chomp.capitalize
        if option == "blah"
        end
      end
    elsif $variation == 1
      $variation = 0
      Game::Options.set([dsf])
      while continue != 1
        Game.newline
        Game.print_options
        Game.prompt
        option = gets.chomp.capitalize
        if option == "blah"
        end
      end
    end
  end
end
puts "You Died!".red
if $difficulty == "Hardcore"
  Game::Save.wipe
end
#Improved formatting, better descriptions, hardcore now deletes your gamesave if you die, fixed bugs, finished chunk 1, implemented new methods, reorganized classes, fixed save function
