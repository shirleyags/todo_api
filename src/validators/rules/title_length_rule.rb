class TitleLengthRule
  def self.validate(payload)
    title = payload[:title]&.strip
    return [] unless title

    return [] if title.length.between?(3, 100)

    ['title must be between 3 and 100 characters']
  end
end