module MochiLib
  require 'base64'
  require "logger"
  $name = nil
  $gender = nil
  $chunk = 0
  $inventory = []
  $achievements = []
  $time = "Morning"
  $variation = 0
  $difficulty = nil
  $clock = 480
  $season = "Spring"
  $health = 100
  $continue = false
  $currentsave = ""
  # defining methods to simplify creating more story
  # set variables for stats, inventory, time, etc.
  #basic
  # using the correct pronouns for the specified gender
  def self.sgsw
    if $gender == 'Male'
      $gsp1 = 'he'
      $gsp2 = 'him'
    elsif $gender == 'Female'
      $gsp1 = 'she'
      $gsp2 = 'her'
    end
  end

  # Resets things at the end of a chunk
  def self.eoc
    $continue = false
    Time.step
    $health = if ($health + 10) > 101
                $health + 10
              else
                100
              end
    $chunk += 1
    Save.save($currentsave)
  end

  # Work in progress
  def self.WIP
    MochiLib::Options.set(%w["WIP" "WIP" "WIP" "Exit"])
    MochiLib::Options.print
    MochiLib.prompt
    MochiLib.n1
    if $option == "Wip"
      puts "You have reached the end of the content;  please wait for the next update."
    elsif $option == "Exit"
      exit
    else
      MochiLib.n1
      puts "That's not an option!"
      MochiLib.n2
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
        line.puts Base64.strict_encode64("#{$name.to_s}|#{$gender.to_s}|#{$chunk.to_i}|#{$inventory}|#{$time.to_s}|#{$variation}|#{$difficulty.to_s}|#{$clock.to_s}|#{$season.to_s}|#{$options}|#{$achievements}")
      end
      MochiLib::Debug.log("Game saved!")
      MochiLib.n1
      puts 'Game saved!'.green
      MochiLib.line
    end

    # Load function
    def self.load(name="")
      cs = is_corrupt?(name)
      if cs == false
        File.open("./saves/#{name}.sav").each do |line|
          @save = Base64.decode64(line.to_s)
        end
        MochiLib::Debug.log("Save file #{name} has been opened and @save set", "debug")
        @save = @save.split("|")
        MochiLib::Debug.log("@save has been split", "debug")
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
        $achievements = @save[10]
        $continue = false
        MochiLib.sgsw
        MochiLib::Debug.log("@save is #{@save}", "debug")
        MochiLib::Debug.log("Name has been set to #{$name}", "debug")
        MochiLib::Debug.log("Gender has been set to #{$gender}", "debug")
        MochiLib::Debug.log("Chunk has been set to #{$chunk}", "debug")
        MochiLib::Debug.log("Inventory has been set to #{$inventory}", "debug")
        MochiLib::Debug.log("Time has been set to #{$time}", "debug")
        MochiLib::Debug.log("Variation has been set to #{$variation}", "debug")
        MochiLib::Debug.log("Difficulty has been set to #{$difficulty}", "debug")
        return "ok"
      elsif cs == true
        MochiLib.n
        puts 'Your save data has been corrupted. Would you like to wipe it or attempt to fix it?'
        Options.set(["Wipe the save data", "I'll fix it myself!"])
        Options.print
        foo = gets.chomp.capitalize
        wipe($currentsave) if foo == "Wipe the save data"
        return "corrupt"
      elsif cs == "Empty"
        MochiLib.n1
        puts "Your save data is empty!"
        MochiLib.n2
        return "empty"
      else
        MochiLib.n1
        puts "Something went wrong while making sure the file wasn't corrupt. Please contact the developers at Github to let them know about this issue."
        MochiLib.n2
        MochiLib::Debug.log("Corruption checking returned something unexpected", "error")
        return "???"
      end
    end

    # Wipes the save
    def self.wipe(save)
      File.open("#{save}.sav", 'w+').each do |line|
        line = nil
      end
    end

    # Checks if the save file is corrupt
    def self.is_corrupt?(name)
      MochiLib::Debug.log("is_corrupt has been called", "debug") if $extra == true
      begin
        File.open("./saves/#{name}.sav").each do |line|
          @save = Base64.decode64(line.to_s)
        end
        MochiLib::Debug.log("Save file #{name} has been opened and @save set in save checker", "debug") if $extra == true
        @save = @save.split("|")
        MochiLib::Debug.log("@save has been split in save checker", "debug") if $extra == true
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
        $achievements = @save[10]
        $continue = false
        MochiLib::Debug.log("iouh", "debug")
        if @save.is_a?(Array) && @save.length == 9 && $difficulty == 'Easy' or $difficulty == 'Medium' or $difficulty == 'Hard' or $difficulty == 'Hardcore' && $chunk.is_a?(Integer) && $gender == 'Male' or $gender == 'Female' or $gender == 'Trans' or $gender == 'Transgender' && $inventory.is_a?(Array) && $time.is_a?(String) && $variation.is_a?(Integer) && $clock.is_a?(Integer) && $options.is_a?(Array)
          MochiLib::Debug.log("Game save has been checked and is not corrupt")
          return false
        else
          MochiLib::Debug.log("Game save has been checked and is corrupt (non-matching variables)", "error")
          return true
        end
      rescue NoMethodError => foo
        MochiLib::Debug.log("Game save is empty (#{foo})", "error")
        return "Empty"
      rescue Exception => bar
        MochiLib::Debug.log("Game save has been checked and is corrupt (#{bar})", "error")
        return true
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

    # Printing a list of all items in inventory
    def self.print
      #parser for each item
      $inventory.each do |item|
        item.length do |a|
          str = ""
          b = 0
          #detecting special character
          if a == "|"
            #printing out in appropriate formatting
            case b
            when 0
              puts str
            when 1
              puts str.italic
            when 2
              puts str.bold
            else
              MochiLib::Debug.log("Invalid item #{item}!")
              puts "Error: Invalid item!"
            end
            b += 1
          else
            str = str + a
          end
        end
      end
    end
  end

  class self::Achievements
    def self.give(achievement, description)
      $achievements.insert(0, [achievement,description])
      MochiLib.n1
      puts "<========================>\nAchivement get!\n#{achievement}\n#{description}\n<========================>".center(26).yellow
      MochiLib.n2
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
      MochiLib.line
      puts 'Options:'
      $options.each do |option|
        puts "- #{option}" if option != 0
      end
      $continue = true if $options.empty? == true
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
        if option.to_s.downcase == "exit"
          exit
        else
          false
        end
      end
    end

    def self.nao
      MochiLib.n1
      puts "That's not an option!"
      MochiLib.n2
    end

    def self.yn
      loop do
        MochiLib::Options.set(%w[Yes No])
        MochiLib::Options.print
        MochiLib.prompt
        tmp23424534532 = gets.chomp.capitalize.clean
        if tmp23424534532 == "Yes"
          return "Yes"
        elsif tmp23424534532 == "No"
          return "No"
        else
          MochiLib::Options.nao
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
        MochiLib.n1
        puts "Invalid input!"
        MochiLib.n2
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
      MochiLib.n1
      puts "It is now #{$time}."
      MochiLib.n2
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