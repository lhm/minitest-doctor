class String
  def indent(count = 2, char = " ")
    (char * count) + gsub(/(\n+)/) { $1 + (char * count) }
  end
end
