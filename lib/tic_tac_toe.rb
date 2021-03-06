def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, token)
  board[index] = token
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  token = current_player(board)
  if valid_move?(board, index)
    move(board, index, token)
    display_board(board)
  else
    turn(board)
  end
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def turn_count(board)
  counter = 0

  board.each do |char|
    if char == "X" || char == "O"
    counter += 1
    end
  end
  return counter
end

def current_player(board)
  count = turn_count(board)

  if count.even?
    "X"
  elsif count.odd?
    "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if position_1  == "X" && position_2 == "X" && position_3 == "X"
      return win_combination
    elsif position_1  == "O" && position_2 == "O" && position_3 == "O"
      return win_combination
    end
  end
  return false
end

def full?(board)
  board.detect do |space|
    if space == " " || space == ""
      return false
    end
  end
    return true
end

def draw?(board)
  bool = full?(board)
  if !won?(board) && bool
    return true
  elsif !bool && !won?(board)
    return false
  elsif won?(board) != false
    return false
  end
end

def over?(board)
  if won?(board) != false || draw?(board) || full?(board)
    return true
  else
    return false
  end
end

def winner(board)
  win = won?(board)

  if win != false
    place1 = win[0]

    if board[place1] == "X"
      return "X"
    elsif board[place1] == "O"
      return "O"
    end

  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if winner(board) == "X" || winner(board) == "O"
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6]
]
