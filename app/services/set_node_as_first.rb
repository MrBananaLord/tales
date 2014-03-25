class SetNodeAsFirst
  def initialize(node)
    @success = true
    @node = node
    @game = node.game
  end
  
  def call
    @success = @node.id.present? ? set_as_first : false
    self
  end
  
  def success?
    !!@success
  end
  
  private
  
  def set_as_first
    @game.update_column(:first_node_id, @node.id)
  end
end
