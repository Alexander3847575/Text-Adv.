# Credit to Erik Skoglund, BananaNeil, Ivan Black, and Juanito Fatas on stack overflow for the code (https://stackoverflow.com/questions/1489183/colorized-ruby-output)
# Methods to stylize/colorize text
# Usage: puts 'foo'.red (prints red text)
# puts 'bar'.bg_black (prints text with a black background
# puts 'foobar'.red.bg_black (prints red text with a black background)
# puts 'blah'.bold.red.bg_black (priority)
# puts "\e[31m" # set format (red foreground)
# puts "\e[0m" (clear format)
# puts "green-#{"red".red}-green".green  (will be green-red-normal, because of \e[0)
class String
  # colorization
  def colorize(color_code)
    "\e[#{color_code}m#{self}\e[0m"
  end

  def black
    colorize(30)
  end

  def red
    colorize(31)
  end

  def green
    colorize(32)
  end

  def brown
    colorize(33)
  end

  def blue
    colorize(34)
  end

  def magenta
    colorize(35)
  end

  def cyan
    colorize(36)
  end

  def gray
    colorize(37)
  end
  
  def bg_black
    colorize(40)
  end

  def bg_red
    colorize(41)
  end

  def bg_green
    colorize(42)
  end

  def bg_brown
    colorize(43)
  end

  def bg_blue
    colorize(44)
  end

  def bg_magenta
    colorize(45)
  end

  def bg_cyan
    colorize(46)
  end

  def bg_gray
    colorize(47)
  end

  def bold
    colorize(1)
  end

  def italic
    colorize(3)
  end

  def underline
    colorize(4)
  end

  def blink
    colorize(5)
  end

  def reverse_color
    colorize(7)
  end

  #some of my stuff
  def c
    center(26)
  end

  def initial
    self[0,1]
  end

  #lots of ways to clean up text
  def clean(type="fast")
    if type.downcase == "fast"
      "#{delete!(' ')}"
      "#{strip}"
    elsif type.downcase == "fastall"
      "#{delete!(' ')}"
    elsif type.downcase == "gsub"
      "#{gsub!(/\s+/, " ")}"
    elsif type.downcase == "all"
      "#{gsub!(/[[:space:]]/, " ")}"
    else
      Game::Debug.log("Invalid type for clean function")
      exit
    end
  end
end

