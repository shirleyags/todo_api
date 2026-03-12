class TitleRequiredRule
  def self.validate(payload)
    title = payload[:title]&.strip

    return [] if title && !title.empty?

    ['title is required']
  end
end