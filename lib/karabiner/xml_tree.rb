module Karabiner::XmlTree
  attr_reader :parent

  def add_child(*objects)
    objects.each do |object|
      children << object
    end

    children.each do |child|
      child.parent = self
    end
  end

  def search_children(klass)
    children.select { |c| c.is_a?(klass) }
  end

  def to_xml(distance_between_children = 0)
    tag_name = self.class.to_s.split("::").last.downcase
    newline_count = distance_between_children + 1

    [
      "<#{tag_name}>",
      children.map(&:to_xml).join("\n" * newline_count).gsub(/^/, "  "),
      "</#{tag_name}>",
    ].join("\n")
  end

  protected

  attr_writer :parent

  private

  def children
    @children ||= []
  end

  def parent
    @parent
  end
end
