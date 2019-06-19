module Text_Adv
  require 'base64'
  # defining methods to simplify creating more story

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
  $clock = 480
  $season = 'Spring'

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
    Save.save
    Time.step
    $health = if ($health + 10) > 101
                $health + 10
              else
                100
    $chunk += 1
  end

  # Save related methods
  class self::Save

    # Save function
    def self.save
      File.open('game.sav', 'w+') do |line|
        line.puts Base64.encode64("#{$name.to_s},#{$gender.to_s},#{$chunk},#{$inventory},#{$time.to_s},#{$variation},#{$difficulty.to_s},#{$clock.to_s},#{$season.to_s}")
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
        save = @save.split(",")
        $name = @save[0].to_s
        $gender = @save[1].to_s
        $chunk = @save[2].to_i
        $inventory = @save[3].to_s
        $time = @save[4].to_s
        $variation = @save[5].to_i
        $difficulty = @save[6].to_s
        $clock = @save[7].to_i
        $season = @save[8].to_s
        Game.set_gender_specific_words
        if $debug == true
          print save
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
        Game.n
        Game.newline
        puts "Your save data is empty!"
        Game.newline
        Game.n
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
        @save = ""
        File.open('game.sav').each do |line|
          @save = @save + Base64.decode64(line.to_s)
        end
        $name = @save[0].to_s
        $gender = @save[1].to_s
        $chunk = @save[2].to_i
        $inventory = @save[3].to_s
        $time = @save[4].to_s
        $variation = @save[5].to_i
        $difficulty = @save[6].to_s
        $clock = @save[7].to_i
        $season = @save[8].to_s
        if @save.is_a?(Array) && $difficulty == 'Easy' or $difficulty == 'Medium' or $difficulty == 'Hard' or $difficulty == 'Hardcore' && $chunk.is_a?(Integer) && $gender == 'Male' or $gender == 'Female' or $gender == 'Trans' or $gender == 'Transgender' && $inventory.is_a?(Array) && $time.is_a?(String) && $variation.is_a?(Integer) && $clock.is_a?(Integer)
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
    def self.remove(options)
      $options.delete(options)
    end
    
    # Checks if the input is an avaliable option
    def self.check(option, input)
      if input.to_s == option.to_s && $options.include?(input.to_s) == true
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
        Game.n
        Game.newline
        puts "Invalid input!"
        Game.newline
        Game.n
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
      Game.n
      Game.newline
      puts "It is now #{$time}."
      Game.newline
      Game.n
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
end
