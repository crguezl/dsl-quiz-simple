#encoding: utf-8
class Answer
  attr_accessor :kind, :order, :answer

  # order:  the position of the answer in the question
  # kind:   either :right or :wrong
  # answer: the text of the answer (for instance "1492")
  def initialize(order, kind, answer)
    @kind, @order, @answer = kind, order, answer
  end

  def to_s
    "#{@order} -  #{answer}"
  end

  # predicate: decides if this a right answer
  def is_right?
    @kind == Quiz::RIGHT
  end

  # Answer objects must be sorted according to their position
  # inside the question
  def <=>(other)
    self.order <=> other.order
  end

end

class Question
  ORDER = 0
  KIND = 1
  attr_accessor :text, :answers

  def initialize(text, answers)
    @text = text

    # The keys "k" are pairs like [3, :right] or [6, :wrong]
    # The first is the answer position, the second the kind of answer
    # The value "v" is the answer, for instance "1942" or "1492"
    @answers = answers.map { |k, v| Answer.new(k[ORDER], k[KIND],  v) }.sort
  end

  def to_s
    output = <<"EOQ"
#{@text}

#{
    out = ""
    @answers.each do |answer|
      out << "  #{answer}\n"
    end
    out
}
EOQ
  end

  # ask the question and returns true if the answer is right
  # false otherwise
  def ask
    begin
      puts self
      print "Su respuesta: " 
      answerno = gets.to_i - 1
    end while (answerno < 0 or answerno >= @answers.length)
    @answers[answerno].is_right? 
  end

end

class Quiz
  RIGHT = :right
  WRONG = :wrong

  attr_accessor :name, :questions 

  def initialize(name = "", &block)
    self.name = name
    self.questions = []

    @counter = 0
    instance_eval &block
  end

  def question(text, answers)
    q = Question.new(text, answers)
    questions << q 
    puts q if $DEBUG
    @counter = 0
  end

  def to_s
    out = <<"EOQUIZ"
#{self.name}

#{self.questions.join("\n")}
EOQUIZ
  end

  def wrong
    @counter += 1
    [@counter, WRONG]
  end

  def right
    @counter+= 1
    [@counter, RIGHT]
  end

  def title(title)
    @name = title
  end

  def run
    counter=0
    puts self.name+"\n\n"
    self.questions.each { |q| counter += 1 if q.ask }
    puts "#{counter} respuestas correctas de un total de #{@questions.size}."
  end
end
if __FILE__ == $0
  quiz = Quiz.new("Cuestionario de PFS 10/12/2011") do
    question '¿En que año Cristobal Colón descubrió América?',
      wrong =>'1942',
      right =>'1492',
      wrong =>'1808',
      wrong =>'1914'
    
    a = rand(10)
    b = rand(10)
    question "#{a}+#{b} = ",
      wrong =>"44",
      wrong =>"#{a + b + 2}",
      right =>"#{a + b}",
      wrong =>"#{a + b - 2}"
  end

  puts quiz
  puts "************************"
  quiz.run
end
