class CreateHashtagService
  def initialize(question)
    @question = question
  end

  def call
    @question.hashtags =
      "#{@question.body} #{@question.answer}"
      .downcase
      .scan(Hashtag::REGEXP)
      .uniq
      .map { |hashtag| Hashtag.create_or_find_by(text: hashtag.delete('#')) }
  end
end
