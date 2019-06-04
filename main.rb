require './resources/colorize.rb'
require'./resources/text-adv-methods.rb'
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

# intro
print '   Text Adv. alpha 1.1.0'
newline
print "      By: Alexander \n"
print "   Press enter to start \n"
foo = gets.chomp.capitalize
load if foo == 'Load'
# options
if $chunk == 0
  loop do
    print '  Choose your difficulty'
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
      print "That's not an option!"
      newline
      print "\n"
    end
  end
  loop do
    print "\n    What's your name?"
    newline
    prompt
    $name = gets.chomp.capitalize
    print "\n      Are you sure?"
    newline
    set_options(%w[Yes No])
    print_options
    prompt
    foo = gets.chomp.capitalize
    if foo == 'Yes'
      break
    elsif foo == 'No'
    else
      newline
      print "That's not an option!"
      newline
      print "\n"
    end
  end
  loop do
    print "\n    What's your gender?"
    newline
    prompt
    $gender = gets.chomp.capitalize
    case $gender
    when 'Male'
      break
    when 'Female'
      break
    else
      newline
      print "That's not an option!"
      newline
      print "\n"
    end
    set_gender_specific_words
  end
  print "\n    Welcome, #{$name}."
  newline
  print "You wake up in the morning, stretching. As you open your eyes, you find yourself on a large beach. You don't remember how you got here, but you feel some items in your pockets."
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
    if option == 'Look around'
      newline
      if $difficulty == 'Easy'
        print "You examine your surroundings. You're on the edge of the beach and it's nearly all white sand. There's a small kind of forest closer to the center of the island and what looks like campfire ground."
        $options.insert(0, 'Go to the campfire ground and look around', 'Head into the forest and look around')
      elsif $difficulty == 'Medium'
        print "You examine your surroundings. You're on the edge of the beach and it's nearly all white sand. There's a small kind of forest closer to the center of the island and what looks like campfire ground."
        $options.insert(0, 'Go to the campfire ground and look around', 'Go to the small-ish forest and look around') # "Palm trees, white sand, turquoise tinted water, coral, etc."
      elsif $difficulty == 'Hard'
        print "You examine your surroundings. You're on the edge of the beach and it's nearly all white sand. There's a small kind of forest closer to the center of the island and what looks like campfire ground."
        $options.insert(0, 'Go to the campfire ground and look around', 'Go to the small-ish forest and look around')
      elsif $difficulty == 'Hardcore'
        print "You examine your surroundings. You're on the edge of the beach and it's nearly all white sand. There's a small kind of forest closer to the center of the island and what looks like campfire ground."
        $options.insert(0, 'Go to the campfire ground and look around', 'Go to the small-ish forest and look around')
      end
      $options.delete('Look around')
    elsif option == 'Look in your pockets'
      foo1 = 0
      newline
      $inventory.join(', ')
      if $difficulty == 'Easy'
        print 'You search your pockets for anything that might be of use. You find a lighter, a pocketknife, a wad of soggy cash, a worn down wallet with a credit card and a few other things in it, and an envelope. '
        $inventory.insert(0, 'A lighter', 'Pocketknife', 'Wad of soggy cash', ['Worn down wallet', 'contains credit card', 'library card'], ['Wet envelope', 'contains a note'])
        foo1 = 1
      elsif $difficulty == 'Medium'
        print 'You search your pockets for anything that might be of use. You find a wad of soggy cash, a worn down wallet with a credit card and a few other things in it, and an envelope. '
        $inventory.insert(0, 'Wad of soggy cash', ['Worn down wallet', 'contains credit card', 'library card'], ['Wet envelope', 'contains a note'])
        foo1 = 1
      elsif $difficulty == 'Hard'
        print 'You search your pockets for anything that might be of use. You find a wad of mushy, soggy cash and an envelope. '
        $inventory.insert(0, 'Wad of soggy cash', ['Wet envelope', 'contains a note'])
      elsif $difficulty == 'Hardcore'
        print 'You search your pockets for anything that might be of use. You find a wad of soggy cash. It appears to be absolutely destroyed.'
        $inventory.insert(0, 'Destroyed wad of soggy cash')
      end
      $options.delete('Look in your pockets')
      $options.insert(0, 'Open the envelope') if foo1 == 1
    elsif option == 'Go back to sleep'
      newline
      print "You decide to go back to sleep on the warm beach in the nice, soft, sand, hoping you'll wake up in your bed. \nThe sun shines overhead... \nZzz... \nZzz..."
      $options.delete('Go back to sleep')
      $continue = 1
      $variation = 1
      if $difficulty == 'Easy' || $difficulty == 'Medium'
        $time = 'Evening'
      elsif $difficulty == 'Hard' || $difficulty == 'Hardcore'
        $time = 'Night'
      end
    elsif option == 'Pinch yourself'
      newline
      print "You pinch yourself, hoping that you're dreaming. It hurts sharply. Well, guess that's ruled out. \n-1 HP"
      $health -= 1
      $options.delete('Pinch yourself')
    elsif option == 'Open the envelope'
      newline
      print 'You open the envelope, being careful not to tear the soggy paper. Inside, you find a holiday card. It has a pretty handmade drawing of a firework bursting on the front but after peeling it open, the ink has bled too much to be readable. You notice a small keychain taped to the side which has managed to stay on even after the card being soaked.'
      $options.insert(0, 'Examine the keychain')
      $options.delete(option)
    elsif option == 'Examine the keychain'
      newline
      print "You look closer at the keychain and you notice that even after the beating it's been through, it still appears to be brand new. You recognize the emblem on the front even though you don't remember ever seeing it. On the back is a little slot for a watch battery, but it dosen't currently have one in it."
      $options.delete('Examine the keychain')
    elsif option == 'Insert the watch battery'
      print 'You insert the watch battery into the small slot in the keychain, it lights up with a yellow glow, you realize that the sun emblem on the front is really 8 different buttons with a central large one.'
      $option.insert(0, 'Press a button', 'Press the center one')
    else
      if $options.include?(option.to_s) == false
        newline
        print "That's not an option!"
      end
    end
    if $health == 0
      newline
      print "You've been playing this game far too long. \nYou have earned the Determined Pincher acheivement! \n+1 Watch battery"
      $inventory.insert(0, 'Watch battery')
      $options.insert(0, 'Insert the watch battery')
      $achivements.insert
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
      stuff
    end
  elsif $variation == 1
    set_options
    while continue != 1
      newline
      stuff
    end
  end
end
