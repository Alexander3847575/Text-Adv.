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
    save
    Time.step
    $health = if ($health + 10) > 101
                $health + 10
              else
                100
              end
    $chunk += 1
    
  end

  # Save function
  def self.save
    File.open('game.sav', 'w+') do |line|
      save = [$name.to_s, $gender.to_s, $chunk, $inventory, $time.to_s, $variation, $difficulty.to_s]
      line.puts Base64.encode64(save.to_s)
    end
    n
    newline
    puts 'Game saved!'.green
    newline
  end

  # Load function
  def self.load
    File.open('game.sav').each do |line|
      @save = Base64.decode64(line.to_s)
    end
    $name = @save[0]
    $gender = @save[1]
    $chunk = @save[2]
    $inventory = @save[3]
    $time = @save[4]
    $variation = @save[5]
    $difficulty = @save[6]
    print @save
  end

  # creates a new line
  def self.newline
    puts '<========================>'.center(26)
  end

  # creates things for a prompt
  def self.prompt
    print "=>\e[A"
  end

  def self.n
    print "\n"
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
    end

    # Advances the time
    def self.step(unit=60)
      if $clock >= 1440
        $clock = 0
      else
        $clock += unit
      end
      if $clock >= 1260 && $clock <= 1400
        $time = Night
      end
    end
  end
end
