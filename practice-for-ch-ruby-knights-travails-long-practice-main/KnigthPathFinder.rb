
puts 'hi'

require './PolyTreeNode.rb'

class Knight_Path_Finder

    def self.valid_moves(pos)
      addition_arr = [[1,2],[-1,2],[1,-2],[-1, -2],[2,1],[-2,1],[2,-1],[-2,-1]]
      all_positions = addition_arr.map {|add| [add[0]+pos[0],add[1]+pos[1]]}
      in_bound_positions = all_positions.select do |sub_pos|
        x = sub_pos[0]
        y = sub_pos[1] 
        if x < 0 || x > 7
          false 
        elsif y < 0 || y > 7
          false 
        else   
        [x,y] 
        end
      end 
      in_bound_positions
    end    
  #Ex:- :default =>''
    # [1,2]   [2,1]
    # [-1,2]   [-2,1]
    # [1,-2]   [2,-1]
    # [-1, -2]  [-2,-1]
    
  attr_reader :considered_positions, :root_pos 
  attr_accessor :root_node
  def initialize(initialize_pos)
      @root_pos = initialize_pos
      @considered_positions = [initialize_pos]
      @already_been = []
      self.build_move_tree
  end

  def new_move_positions(pos)
      potential_moves = Knight_Path_Finder.valid_moves(pos)
      potential_moves.select do |pos| 
          if !self.considered_positions.include?(pos)
              considered_positions << pos 
          end    
      end
  end  
  
  def build_move_tree
    self.root_node = PolyTreeNode.new(self.root_pos)
    queue = [self.root_node]
    while !queue.empty?
      current_node = queue.shift 
      children_positions = self.new_move_positions(current_node.value)
      children_positions.each do |pos|
        new_node = PolyTreeNode.new(pos) 
        queue << new_node 
        current_node.add_child(new_node)
      end
    end 
  end  

  def find_path(end_pos)
    end_node = root_node.dfs(end_pos)
    trace_path_back(end_node)
  end  

  def trace_path_back(end_node)
    route = [] 
    #reverse it ^ 
    current_node = end_node 
    while current_node.parent != nil
      route << current_node.value 
      current_node = current_node.parent
    end
    return route.reverse
  end

end    

puts 'bye'