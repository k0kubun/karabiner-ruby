module Dotremap::XmlTree
  def add_child(*objects)
    objects.each do |object|
      childs << object
    end
  end

  def search_childs(klass)
    childs.select { |c| c.is_a?(klass) }
  end

  def to_xml(distance_between_childs = 0)
    tag_name = self.class.to_s.split("::").last.downcase
    newline_count = distance_between_childs + 1

    [
      "<#{tag_name}>",
      childs.map(&:to_xml).join("\n" * newline_count).gsub(/^/, "  "),
      "</#{tag_name}>",
    ].join("\n")
  end

  private

  def childs
    @childs ||= []
  end
end
