#require 'terminfo'
require './resources/colorize'
require'./resources/text-adv-methods'
# set variables for stats, inventory, time, etc.
#basic
$name = "NaN"
$chunk = 0
$variation = 0
$inventory = []
# stats
$health = 100
$intelligence = 0
$mana = 100
#other
$time = 'Morning'
$season = 'Spring'

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
      set_options(%w[Easy Medium Hard Hardcore])
      print_options
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
    puts "\n    Welcome, #{$name}."
    newline
    puts "You wake up in the morning, stretching. As you open your eyes, you find yourself on a large beach. You don't remember how you got here, but you feel some items in your pockets."
    set_options(['Look around', 'Look in your pockets', 'Go back to sleep', 'Pinch yourself'])
    eoc
  end
  # chunk 1
  if $chunk == 1
    while $continue != 1
      newline
      print_options
      prompt
      option = gets.chomp.capitalize
      $variation = 0
      if option == 'Look around' && $options.include?(option.to_s) == true
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
      elsif option == 'Look in your pockets' && $options.include?(option.to_s) == true
        foo1 = 0
        newline
        $inventory.join(', ')
        if $difficulty == 'Easy'
          puts 'You search your pockets for anything that might be of use. You find a lighter, a pocketknife, a wad of soggy cash, a worn down wallet with a credit card and a few other things in it, and an envelope. '
          $inventory.insert(0, 'A lighter', 'Pocketknife', 'Wad of soggy cash', ['Worn down wallet', 'contains credit card', 'library card'], ['Wet envelope', 'contains a note'])
          foo1 = 1
        elsif $difficulty == 'Medium'
          puts 'You search your pockets for anything that might be of use. You find a wad of soggy cash, a worn down wallet with a credit card and a few other things in it, and an envelope. '
          $inventory.insert(0, 'Wad of soggy cash', ['Worn down wallet', 'contains credit card', 'library card'], ['Wet envelope', 'contains a note'])
          foo1 = 1
        elsif $difficulty == 'Hard'
          puts 'You search your pockets for anything that might be of use. You find a wad of mushy, soggy cash and an envelope. '
          $inventory.insert(0, 'Wad of soggy cash', ['Wet envelope', 'contains a note'])
        elsif $difficulty == 'Hardcore'
          puts 'You search your pockets for anything that might be of use. You find a wad of soggy cash. It appears to be absolutely destroyed.'
          $inventory.insert(0, 'Destroyed wad of soggy cash')
        end
        $options.delete(option)
        $options.insert(0, 'Open the envelope') if foo1 == 1
      elsif option == 'Go back to sleep' && $options.include?(option.to_s) == true
        newline
        puts "You decide to go back to sleep on the warm beach in the nice, soft, sand, hoping you'll wake up in your bed. \nThe sun shines overhead... \nZzz... \nZzz..."
        $options.delete(option)
        $continue = 1
        $variation = 1
        if $difficulty == 'Easy' || $difficulty == 'Medium'
          $time = 'Evening'
        elsif $difficulty == 'Hard' || $difficulty == 'Hardcore'
          $time = 'Night'
        end
      elsif option == 'Pinch yourself' && $options.include?(option.to_s) == true
        newline
        puts "You pinch yourself, hoping that you're dreaming. It hurts sharply. Well, guess that's ruled out. \n#{"-1 HP".red}"
        $health -= 1
        $options.delete(option)
      elsif option == 'Pinch yourself'
        newline
        puts "You pinch yourself again, still hoping that you're dreaming. It hurts even more. It really dosen't seem like you're dreaming. \n#{"-1 HP".red}"
        $health -= 1
      elsif option == 'Open the envelope' && $options.include?(option.to_s) == true
        newline
        puts 'You open the envelope, being careful not to tear the soggy paper. Inside, you find a holiday card. It has a pretty handmade drawing of a firework bursting on the front but after peeling it open, the ink has bled too much to be readable. You notice a small keychain taped to the side which has managed to stay on even after the card being soaked.'
        $options.insert(0, 'Examine the keychain')
        $options.delete(option)
      elsif option == 'Examine the keychain' && $options.include?(option.to_s) == true
        newline
        puts "You look closer at the keychain and you notice that even after the beating it's been through, it still appears to be brand new. You recognize the emblem on the front even though you don't remember ever seeing it. On the back is a little slot for a watch battery, but it dosen't currently have one in it."
        $options.delete(option)
      elsif option == 'Insert the watch battery' && $options.include?(option.to_s) == true
        puts 'You insert the watch battery into the small slot in the keychain. It lights up with a yellow glow, and you realize that the sun emblem on the front is really 8 different buttons with a central large one.'
        $option.insert(0, 'Press a button', 'Press the center one')
      else
        if $options.include?(option.to_s) == false
          newline
          puts "That's not an option!"
        end
      end
      if $health == 0
        newline
        puts "You've been playing this game far too long. \nYou have earned the Determined Pincher acheivement! \n+1 Watch battery"
        $inventory.insert(0, 'Watch battery')
        $options.insert(0, 'Insert the watch battery')
        $achivements.insert(0, 'Determined Pincher')
      end
      step
    end
    eoc
  end

  if $chunk == 2
    # chunk 2
    if $variation == 0
      set_options
      while $continue != 1
        newline
        print_options
        prompt
        option = gets.chomp.capitalize
        if option == "blah"
        end
      end
    elsif $variation == 1
      set_options
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
