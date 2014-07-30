module Dotremap::XmlTree
  def add_child(object)
    childs << object
  end

  def search_childs(klass)
    childs.select { |c| c.is_a?(klass) }
  end

  private

  def childs
    @childs ||= []
  end
end
