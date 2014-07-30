module Dotremap::XmlTree
  def add_child(*objects)
    objects.each do |object|
      childs << object
    end
  end

  def search_childs(klass)
    childs.select { |c| c.is_a?(klass) }
  end

  private

  def childs
    @childs ||= []
  end
end
