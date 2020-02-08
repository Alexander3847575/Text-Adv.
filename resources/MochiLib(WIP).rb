module MochiLib
  require 'base64'
  require "logger"
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

  # Work in progress
  def self.WIP
    Game::Options.set(%w["WIP" "WIP" "WIP" "Exit"])
    Game::Options.print
    Game.prompt
    Game.n
    Game.line
    if $option == "Wip"
      puts "You have reached the end of the content;  please wait for the next update."
    elsif $option == "Exit"
      exit
    else
      Game.n
      Game.line
      puts "That's not an option!"
      Game.line
      Game.n
    end
  end

  # creates a new line
  def self.line
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
    line
  end

  def self.n2
    line
    n
  end

  # Save related methods
  class self::Save

    # Save function
    def self.save(name="")
      File.open("./saves/#{name}.sav", 'w+') do |line|
        line.puts Base64.strict_encode64("#{$name.to_s} #{$gender.to_s} #{$chunk.to_i} #{$inventory} #{$time.to_s} #{$variation} #{$difficulty.to_s} #{$clock.to_s} #{$season.to_s} #{$options}")
      end
      Game.n1
      puts 'Game saved!'.green
      Game.line
    end

    # Load function
    def self.load(name="")
      if is_corrupt? == false
        File.open("./saves/#{name}.sav").each do |line|
          @save = Base64.decode64(line.to_s)
        end
        Game::Debug.log("Save file #{name} has been opened and @save set", "debug")
        @save = @save.split("\\")
        Game::Debug.log("@save has been split", "debug")
        $name = @save[0].to_s
        $gender = @save[1].to_s
        $chunk = @save[2].to_i
        $inventory = @save[3]
        $time = @save[4].to_s
        $variation = @save[5].to_i
        $difficulty = @save[6].to_s
        $clock = @save[7].to_i
        $season = @save[8].to_s
        $options = @save[9]
        $continue = 0
        Game.set_gender_specific_words
        Game::Debug.log("@save is #{@save}", "debug")
        Game::Debug.log("Name has been set to #{$name}", "debug")
        Game::Debug.log("Gender has been set to #{$gender}", "debug")
        Game::Debug.log("Chunk has been set to #{$chunk}", "debug")
        Game::Debug.log("Inventory has been set to #{$inventory}", "debug")
        Game::Debug.log("Time has been set to #{$time}", "debug")
        Game::Debug.log("Variation has been set to #{$variation}", "debug")
        Game::Debug.log("Difficulty has been set to #{$difficulty}", "debug")
      elsif is_corrupt? == true
        Game.n
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
        Game::Debug.log("Corruption checking returned something unexpected", "error")
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
      Game::Debug.log("is_corrupt has been called", "debug") if $extra == true
      begin
        File.open('game.sav').each do |line|
          @save = Base64.decode64(line.to_s)
        end
        @save = @save.split("\\")
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
        if @save.is_a?(Array) && @save.length == 9 && $difficulty == 'Easy' or $difficulty == 'Medium' or $difficulty == 'Hard' or $difficulty == 'Hardcore' && $chunk.is_a?(Integer) && $gender == 'Male' or $gender == 'Female' or $gender == 'Trans' or $gender == 'Transgender' && $inventory.is_a?(Array) && $time.is_a?(String) && $variation.is_a?(Integer) && $clock.is_a?(Integer) && $options.is_a?(Array)
          Game::Debug.log("Game save has been checked and is not corrupt")
          return true
        else
          Game::Debug.log("Game save has been checked and is corrupt", "error")
          return false
        end
      rescue NoMethodError => foo
        Game::Debug.log("Game save is empty (#{foo})", "error")
        return "Empty"
      rescue Exception => bar
        Game::Debug.log("Game save has been checked and is corrupt", "error")
        return false
      end
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

    def self.contains?(item)
      if $inventory.include?(item)
        return true
      else
        return false
      end
    end
  end

  class self::Achievements
    def self.give(achievement)
      $achievements.insert(0, achievement)
    end
  end
  
  # Option related methods
  class self::Options

    # Method to set options as a workaround to not being able to use global variables as method input and also for other purposes
    def self.set(options)
      $options = options
      $options.each do |option|
      end
    end

    # Printing the options set and checking to see if the story should continue
    def self.print
      Game.line
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
    def self.remove(option=$option)
      $options.delete(option)
    end

    # Clears all options
    def self.clear
      $options = []
    end

    # Checks if the input is an avaliable option
    def self.check(option)
      if $option.to_s == option.to_s && $options.include?($option.to_s) == true
        true
      else
        if option.to_s == 
          true
        else
          false
        end
      end
    end

    def self.nao
      Game.n1
      puts "That's not an option!"
      Game.n2
    end

    def self.yn
      loop do
        Game::Options.set(%w[Yes No])
        Game::Options.print
        Game.prompt
        tmp23424534532 = gets.chomp.capitalize.clean
        if tmp23424534532 == "Yes"
          return "Yes"
        elsif tmp23424534532 == "No"
          return "No"
        else
          nao
        end
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
      Debug.log("Time has incremented to #{$clock}.")
    end

    # Prints the current time
    def self.print
      Game.n1
      puts "It is now #{$time}."
      Game.n2
    end

    def self.advance
      tmp1 = $time
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
      if tmp1 != $time
        print
      end
    end
  end

  # Methods dealing with the console
  class self::Console

    # Clears the console
    def self.clear
      print "\e[H\e[2J"
    end
  end

  # Debug methods
  class self::Debug

    @logger = Logger.new File.new('debug.log', 'w')
    @logger.formatter = proc do |severity, datetime, progname, msg|
    "[#{datetime}] #{progname} #{severity}: #{msg}\n"
    end

    @logger.debug "Logger has been started and formatted"

    # logs debug methods
    def self.log(message, tag="info")
      if tag.downcase == "debug"
        @logger.debug message
      elsif tag.downcase == "info"
        @logger.info message
      elsif tag.downcase == "error"
        @logger.error message
      elsif tag.downcase == "fatal"
        @logger.fatal message
      else
        @logger.error "Invalid tag used for logging"
      end
    end
  end
end
