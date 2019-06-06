require 'base64'
# defining methods to simplify creating more story

# method to set options as a workaround to not being able to use global variables as method input and also for other purposes
def set_options(options)
  $options = options
end
#thidsnajv

# printing the options set above and checking to see if the story should continue
def print_options
  puts 'Options:'
  $options.each do |option|
    puts "- #{option}" if option != 0
  end
  $continue = 1 if $options.empty? == true
end

# using the correct pronouns for the specified gender
def set_gender_specific_words
  if $gender == 'Male'
    $gsp1 = 'he'
    $gsp2 = 'him'
  elsif $gender == 'Female'
    $gsp1 = 'she'
    $gsp = 'her'
  end
end

# Resets things at the end of a chunk
def eoc
  $continue = 0
  save
  step
  $health = if ($health + 10) > 101
              $health + 10
            else
              100
        end
  $chunk += 1
end

# Save function
def save
  File.open('game.sav', 'w') do |line|
    save = [$name.to_s, $gender.to_s, $chunk, $inventory, $time.to_s, $variation, $difficulty.to_s]
    line.puts Base64.encode64(save.to_s)
  end
  newline
  print 'Game saved!'
end

# Load function
def load
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

# time and stuff
def step; end

# creates a new line
def newline
  puts "<========================> "
end

# creates things for a prompt
def prompt
  print "=>\e[A\e"
end
