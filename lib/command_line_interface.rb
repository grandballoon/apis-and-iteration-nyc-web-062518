def welcome
  puts "Welcome to the Star Wars API lab!"
end

def get_character_from_user
  puts "please enter a character"
  input = gets.chomp
  input
  # use gets to capture the user's input. This method should return that input, downcased.
end
