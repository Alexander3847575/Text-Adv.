#require 'terminfo'
require './resources/colorize'
require'./resources/text-adv-methods'

# if dead
loop do
  # intro
  puts 'Text Adv. alpha 1.1.0'.center(26)
  newline
  puts "      By: Alexander\n   Press enter to start".center(26)
  foo = gets.chomp.capitalize
  load if foo == 'Load'
  # options
  if $chunk == 0
    loop do
      puts '  Choose your difficulty'
      newline
      Options.set(%w[Easy Medium Hard Hardcore])
      Options.print
      prompt
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
        newline
        puts "That's not an option!"
        newline
      end
    end
    loop do
      puts "\n    What's your name?"
      newline
      prompt
      $name = gets.chomp.capitalize
      puts "\n      Are you sure?"
      newline
      prompt
      foo = gets.chomp.capitalize
      if foo == 'Yes'
        break
      elsif foo == 'No'
      else
        newline
        puts "That's not an option!"
        newline
        puts "\n"
      end
    end
    loop do
      puts "\n    What's your gender?"
      newline
      prompt
      $gender = gets.chomp.capitalize
      case $gender
      when 'Male'||'Female'||'Asexual'||'Trans'||'Transgender'
        break
      else
        newline
        puts "That's not an option!"
        newline
        puts "\n"
      end
      set_gender_specific_words
    end
    eoc
  end
  # chunk 1
  if $chunk == 1
    puts "\n    Welcome, #{$name}."
    newline
    puts "You wake up in the morning, stretching. As you open your eyes, you find yourself on a large beach. You don't remember how you got here, but you feel some items in your pockets."
    Options.set(['Look around', 'Look in your pockets', 'Go back to sleep', 'Pinch yourself'])
    while $continue != 1
      newline
      Options.print
      prompt
      option = gets.chomp.capitalize
      n
      $variation = 0
      if Options.check('Look around', option) == true
        newline
        if $difficulty == 'Easy'
          puts "You examine your surroundings. You're on the edge of the beach and it's nearly all white sand. There's a small kind of forest closer to the center of the island and what looks like campfire ground."
          $options.insert(0, 'Go to the campfire ground and look around', 'Head into the forest and look around')
        elsif $difficulty == 'Medium'
          puts "You examine your surroundings. You're on the edge of the beach and it's nearly all white sand. There's a small kind of forest closer to the center of the island and what looks like campfire ground."
          $options.insert(0, 'Go to the campfire ground and look around', 'Go to the small-ish forest and look around') # "Palm trees, white sand, turquoise tinted water, coral, etc."
        elsif $difficulty == 'Hard'
          puts "You examine your surroundings. You're on the edge of the beach and it's nearly all white sand. There's a small kind of forest closer to the center of the island and what looks like campfire ground."
          $options.insert(0, 'Go to the campfire ground and look around', 'Go to the small-ish forest and look around')
        elsif $difficulty == 'Hardcore'
          puts "You examine your surroundings. You're on the edge of the beach and it's nearly all white sand. There's a small kind of forest closer to the center of the island and what looks like campfire ground."
          $options.insert(0, 'Go to the campfire ground and look around', 'Go to the small-ish forest and look around')
        end
        $options.delete(option)
      elsif Options.check('Look in your pockets', option) == true
        foo1 = 0
        newline
        $inventory.join(', ')
        if $difficulty == 'Easy'
          puts 'You search your pockets for anything that might be of use. You find a lighter, a pocketknife, a wad of soggy cash, a worn down wallet with a credit card and a few other things in it, and an envelope. '
          Inventory.add(['A lighter', 'Pocketknife', 'Wad of soggy cash', ['Worn down wallet', 'contains credit card', 'library card'], ['Wet envelope', 'contains a note']])
          foo1 = 1
        elsif $difficulty == 'Medium'
          puts 'You search your pockets for anything that might be of use. You find a wad of soggy cash, a worn down wallet with a credit card and a few other things in it, and an envelope. '
          Inventory.add(['Wad of soggy cash', ['Worn down wallet', 'contains credit card', 'library card'], ['Wet envelope', 'contains a note']])
          foo1 = 1
        elsif $difficulty == 'Hard'
          puts 'You search your pockets for anything that might be of use. You find a wad of mushy, soggy cash and an envelope. '
          Inventory.add(['Wad of soggy cash', ['Wet envelope', 'contains a note']])
        elsif $difficulty == 'Hardcore'
          puts 'You search your pockets for anything that might be of use. You find a wad of soggy cash. It appears to be absolutely destroyed.'
          Inventory.add(['Destroyed wad of soggy cash'])
        end
        Options.remove(option)
        Options.add('Open the envelope') if foo1 == 1
      elsif Options.check('Go back to sleep', option) == true
        newline
        puts "You decide to go back to sleep on the warm beach in the nice, soft, sand, hoping you'll wake up in your bed. \nThe sun shines overhead... \nZzz... \nZzz..."
        Options.remove(option)
        $continue = 1
        $variation = 1
        if $difficulty == 'Easy' || $difficulty == 'Medium'
          $time = 'Evening'
        elsif $difficulty == 'Hard' || $difficulty == 'Hardcore'
          $time = 'Night'
        end
      elsif Options.check('Pinch yourself', option) == true
        newline
        puts "You pinch yourself, hoping that you're dreaming. It hurts sharply. Well, guess that's ruled out. \n#{"-1 HP".red}"
        $health -= 1
        Options.remove(option)
      elsif Options.check('Pinch yourself', option)
        newline
        puts "You pinch yourself again, still hoping that you're dreaming. It hurts even more. It really dosen't seem like you're dreaming. \n#{"-1 HP".red}"
        $health -= 1
      elsif Options.check('Open the envelope', option) == true
        newline
        puts 'You open the envelope, being careful not to tear the soggy paper. Inside, you find a holiday card. It has a pretty handmade drawing of a firework bursting on the front but after peeling it open, the ink has bled too much to be readable. You notice a small keychain taped to the side which has managed to stay on even after the card being soaked.'
        Options.add('Examine the keychain')
        Options.remove(option)
      elsif Options.check('Examine the keychain', option) == true
        newline
        puts "You look closer at the keychain and you notice that even after the beating it's been through, it still appears to be brand new. You recognize the emblem on the front even though you don't remember ever seeing it. On the back is a little slot for a watch battery, but it dosen't currently have one in it."
        Options.remove(option)
      elsif Options.check('Insert the watch battery', option) == true
        newline
        puts 'You insert the watch battery into the small slot in the keychain. It lights up with a yellow glow, and you realize that the sun emblem on the front is really 8 different buttons with a central large one.'
        Options.add('Press a button', 'Press the center one')
      else
        if $options.include?(option.to_s) == false
          newline
          puts "That's not an option!"
        end
      end
      if $health == 0
        n
        newline
        puts "You've been playing this game far too long. \nYou have earned the Determined Pincher acheivement! \n+1 Watch battery"
        Inventory.add('Watch battery')
        Options.add('Insert the watch battery')
        Achivements.add('Determined Pincher')
      end
      Time.step
    end
    eoc
  end

  if $chunk == 2
    # chunk 2
    if $variation == 0
      Options.set
      while $continue != 1
        newline
        print_options
        prompt
        option = gets.chomp.capitalize
        if option == "blah"
        end
      end
    elsif $variation == 1
      Options.set
      while continue != 1
        newline
        print_options
        prompt
        option = gets.chomp.capitalize
        if option == "blah"
        end
      end
    end
  end
end
