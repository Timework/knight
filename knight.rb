class Knight
    attr_accessor :position_x, :position_y, :parent

    def initialize(position_x, position_y, parent=nil)
        @position_x = position_x
        @position_y = position_y
        @parent = parent
        @children = nil
    end
end

class Aval
    attr_accessor :parent, :value

    def initialize(x, parent=nil)
        @value = x
        @parent = parent
    end
end

class Board
    attr_accessor :board

    def initialize
        arr = (0..7).to_a
        @board = []
        arr.each do |x|
            arr.each do |y|
                @board.push([x, y])
            end
        end
    end

    def knight(x, y)
        @knight = Knight.new(x, y)
    end

    def possible_move(move)
        if move.is_a? Aval
        princess = move
        values = move.value
        knight = [values[0], values[1]]  
        else
        knight = [move[0], move[1]]
        princess = [move[0], move[1]]
        end
        possible_move = []
        knights_move = [
                        [knight[0] + 1, knight[1] + 2],
                        [knight[0] - 1, knight[1] + 2],
                        [knight[0] - 2, knight[1] + 1],
                        [knight[0] + 2, knight[1] + 1],
                        [knight[0] + 1, knight[1] - 2],
                        [knight[0] - 1, knight[1] - 2],
                        [knight[0] - 2, knight[1] - 1],
                        [knight[0] + 2, knight[1] - 1]                                       
                    ]
        knights_move.each do |x|
            if @board.include?(x)
                possible = Aval.new(x)
                possible.parent = princess
                possible_move.push(possible)
            end
        end
        return possible_move
    end

    def knights_move(source, dest)
        @dest = dest
        answer = false
        sources = source
        knight(sources[0], sources[1])
        possible = possible_move([@knight.position_x, @knight.position_y])
        possible.each do |move|
            if @dest == move.value
                return recall(move)
            end
        end
        do_again(possible)
    end
    
    def do_again(move)
        superpossible = []
    move.each do |parent|
        possible = possible_move(parent)
        possible.each do |move|
            superpossible.push(move)
            if @dest == move.value
                return recall(move)
            end
        end
    end
    superpossible.uniq!
        do_again(superpossible)
    end

    def recall(move)
        move_list = []
        while move.is_a? Aval
            move_list.unshift(move.value)
            move = move.parent
        end
        move_list.unshift(move)
        puts "You made it in #{move_list.size - 1}! Heres your path:"
        move_list.each do |nah|
            print nah
            puts
        end
        return move_list
    end
end
board = Board.new
board.knights_move([0,0],[7,6])