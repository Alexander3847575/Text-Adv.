module Text_Adv
  require 'base64'
  # defining methods to simplify creating more story

  # set variables for stats, inventory, time, etc.
  #basic
  # using the correct pronouns for the specified gender
  def self.set_gender_specific_words
    if $gender == 'Male'
      $gsp1 = 'he'
      $gsp2 = 'him'
    elsif $gender == 'Female'
      $gsp1 = 'she'
      $gsp = 'her'
    end
  end

  # Resets things at the end of a chunk
  def self.eoc
    $continue = 0
    Time.step
    $health = if ($health + 10) > 101
                $health + 10
              else
                100
              end
    $chunk += 1
    Save.save
  end

  # Save related methods
  class self::Save

    # Save function
    def self.save
      File.open('game.sav', 'w+') do |line|
        line.puts Base64.strict_encode64("#{$name.to_s}|#{$gender.to_s}|#{$chunk.to_i}|#{$inventory}|#{$time.to_s}|#{$variation}|#{$difficulty.to_s}|#{$clock.to_s}|#{$season.to_s}|#{$options}")
      end
      Game.n
      Game.newline
      puts 'Game saved!'.green
      Game.newline
    end

    # Load function
    def self.load
      if is_corrupt? == true
        File.open('game.sav').each do |line|
          @save = Base64.decode64(line.to_s)
        end
        @save = @save.split("|")
        $name = @save[0]
        $gender = @save[1]
        $chunk = @save[2]
        $inventory = @save[3]
        $time = @save[4]
        $variation = @save[5]
        $difficulty = @save[6]
        $clock = @save[7]
        $season = @save[8]
        $options = @save[9]
        Game.set_gender_specific_words
        $debug = true
        if $debug == true
          print @save
          Game.n
          print $name
          Game.n
          print $gender
          Game.n
          print $chunk
          Game.n
          print $inventory
          Game.n
          print $time
          Game.n
          print $variation
          Game.n
          print $difficulty
          Game.n
        end
      elsif is_corrupt? != "Empty"
        puts 'Your save data has been corrupted. Would you like to wipe it or attempt to fix it?'
        Options.set(["Wipe the save data", "I'll fix it myself!"])
        Options.print
        foo = gets.chomp.capitalize
        if foo == "Wipe the save data"
          wipe
        end
      elsif is_corrupt? == "Empty"
        Game.n1
        puts "Your save data is empty!"
        Game.n2
      else
        Game.n1
        puts "Something went wrong while making sure the file wasn't corrupt. Please contact the developers at Github to let them know about this issue."
        Game.n2
      end
    end

    # Wipes the save
    def self.wipe
      File.open("game.sav", 'w+').each do |line|
        line = nil
      end
    end

    # Checks if the save file is corrupt
    def self.is_corrupt?
      begin
        File.open('game.sav').each do |line|
          @save = Base64.decode64(line.to_s)
        end
        @save = @save.split("|")
        $name = @save[0].to_s
        $gender = @save[1].to_s
        $chunk = @save[2]
        $inventory = @save[3]
        $time = @save[4]
        $variation = @save[5]
        $difficulty = @save[6].to_s
        $clock = @save[7]
        $season = @save[8]
        $options = @save[9]
        if $difficulty == 'Easy' or $difficulty == 'Medium' or $difficulty == 'Hard' or $difficulty == 'Hardcore' && $chunk.is_a?(Integer) && $gender == 'Male' or $gender == 'Female' or $gender == 'Trans' or $gender == 'Transgender' && $inventory.is_a?(Array) && $time.is_a?(String) && $variation.is_a?(Integer) && $clock.is_a?(Integer) && $options.is_a?(Array)
          return false
        else
          return true
        end
      rescue NoMethodError => foo
        puts foo if $debug == true
        return "Empty"
      end
    end
  end


  # creates a new line
  def self.newline
    puts '<========================>'.center(26)
  end

  # creates things for a prompt
  def self.prompt
    print "=> "
  end

  def self.n(times = 1)
    times.times do
      print "\n"
    end
  end

  def self.n1
    n
    newline
  end

  def self.n2
    newline
    n
  end

  # Inventory related methods
  class self::Inventory

    # Add an item to the inventory
    def self.add(item)
      $inventory.insert(0, item)
    end

    # Remove an item from the inventory
    def self.remove(item)
      $inventory.delete(item)
    end

    def self.contains?(item)
      if $inventory.include?(item)
        return true
      else
        return false
      end
    end
  end

  # Option related methods
  class self::Options

    # Method to set options as a workaround to not being able to use global variables as method input and also for other purposes
    def self.set(options)
      $options = options
    end

    # Printing the options set and checking to see if the story should continue
    def self.print
      Game.newline
      puts 'Options:'
      $options.each do |option|
        puts "- #{option}" if option != 0
      end
      $continue = 1 if $options.empty? == true
    end

    # Adds (an) option(s)
    def self.add(options)
      $options.insert(0, options)
    end

    # Deletes (an) option(s)
    def self.remove
      $options.delete($option)
    end

    # Clears all options
    def self.clear
      $options = []
    end

    # Checks if the input is an avaliable option
    def self.check(option)
      if $option.to_s == option.to_s && $options.include?(input.to_s) == true
        true
      else
        false
      end
    end
  end

  # Time related methods
  class self::Time

    # Sets the time
    def self.set(time)
      if time.is_a?(String)
        $time = time
      elsif time.is_a?(Integer)
        $clock = time
      else
        Game.n1
        puts "Invalid input!"
        Game.n2
      end
      advance
    end

    # Advances the time
    def self.step(unit=1)
      foo = $time
      if $clock > 1440
        $clock += unit
        $clock -= 1440
      else
        $clock += unit
      end
      advance
      if $time != foo
        print
      end
    end

    # Prints the current time
    def self.print
      Game.n1
      puts "It is now #{$time}."
      Game.n2
    end

    def self.advance
      if $clock >= 1260 && $clock <= 1399
        $time = "Night"
      elsif $clock == 1440
        $time = "Midnight"
      elsif $clock >= 0 && $clock <= 329
        $time = "Early morning"
      elsif $clock >= 360 && $clock <= 719
        $time = "Morning"
      elsif $clock == 720
        $time = "Noon"
      elsif $clock >= 721 && $clock <= 1259
        $time = "Evening"
      end
    end
  end

  class self::Console

    # Clears the console
    def self.clear
      print "\e[H\e[2J"
    end
  end
end
