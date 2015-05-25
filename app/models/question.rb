class Question < ActiveRecord::Base
  belongs_to :category
  has_many :answers, dependent: :destroy

  accepts_nested_attributes_for :answers,
    reject_if: lambda {|ans| ans[:content].blank?},
    allow_destroy: true

  validates :content, presence: true
  validates :category_id, presence: true
  validate :check_correct_answers_num

  scope :alphabet_sort, -> {order content: :asc}

  def check_correct_answers_num
    correct_answers_num = answers.select{|ans| ans.correct}.count

    unless correct_answers_num == 1
      errors.add :base, I18n.t('question.failure.wrong_num_correct_answers',
       content: content)
    end
  end
  scope :random_questions, ->{limit(Settings.default_questions_num).order("RANDOM()")}
end
