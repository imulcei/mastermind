#computer randomly selects the secret colors
#the human player must guess them
#give the proper feedback
#human player : the creator of the secret code or the guesser

COLORS = ['R', 'Y', 'B', 'O', 'G', 'P']

def player_input
    puts "Enter your proposal (4 letters between R, Y, B, O, G and P)."
    input = gets.chomp.upcase.split('')

    until input.length == 4 && input.all? { |letter| COLORS.include?(letter) }
        puts "Please, enter a valid proposal."
        input = gets.chomp.upcase.split('')
    end

    input
end

def display_rules
    puts "-- WELCOME TO MASTERMIND --"
    puts "What is it ? Just a code breaking game between your computer and you."
    puts "You can choose to be the code marker or the code breaker."
    puts "The code maker have to create a combination of 4 letters."
    puts "The code breaker have to guess the combination under 10 turns."
    puts "The different letters are : R, Y, B, O, G, P."
    puts "R for red, Y for yellow, B for blue, O for orange, G for green, P for purple."
    puts "Duplicates are allowed."
    puts "OK : correct letter and position. ALMOST : correct letter, incorrect position."
    puts "Have fun!"
    puts "\r\n"
end

def computer_code
    Array.new(4) { COLORS.sample }
end

def ok_almost(secret_code, player_proposal)
    check_ok = 0
    check_almost = 0
    secret_code_left = []

    player_proposal.each_with_index do |color, index|
        if secret_code[index] == color
            check_ok += 1
        else secret_code_left << secret_code[index]
        end
    end

    player_proposal.each do |color|
        if secret_code_left.include?(color)
            check_almost += 1
            secret_code_left.delete_at(secret_code_left.index(color) || secret_code_left.length)
        end
    end

    [check_ok, check_almost]
end

def whos_who
    puts "If you want to be the code breaker: press 1." 
    puts "If you want to be the code maker: press 2."
    player_choice = gets.chomp
    if player_choice == "1"
        computer_maker
    else player_maker
    end
end

def computer_maker
    secret_code = computer_code
    rounds = 0

    while rounds < 10
      puts "Round #{rounds + 1}"
      player_proposal = player_input

      check_ok, check_almost = ok_almost(secret_code, player_proposal)
      puts "OK : #{check_ok}."
      puts "ALMOST : #{check_almost}."
      puts "\r\n"

      if check_ok == 4
        puts "You win! The code was: #{secret_code.join(', ')}."
        play_again
      end

      rounds += 1
    end

    if rounds == 10
        puts "Sorry, you loose. The secret code was: #{secret_code.join(', ')}."
        play_again
    end
end

def player_maker
    puts "Entrer the combination you want the computer to guess."
    secret_code = gets.chomp.upcase
    rounds = 0

    while rounds < 10
        puts "Round #{rounds + 1}"
        computer_proposal = computer_code

        puts "#{computer_proposal}"

        check_ok, check_almost = ok_almost(secret_code, computer_proposal)
        puts "OK : #{check_ok}."
        puts "ALMOST : #{check_almost}."
        puts "\r\n"

        if check_ok == 4
            puts "You loose! The computer wins."
            play_again
        end

        rounds += 1
    end

    if rounds == 10
        puts "You win. The computer didn't break the code."
        play_again
    end
end

def play_again
    puts "Do you want to play again? Enter Y for yes, N for no."
    player_choice = gets.chomp.upcase

    if player_choice == "Y"
        start_game
    end

    puts "Thanks for playing!"
end

def start_game
    display_rules
    whos_who
end

start_game