require('spec_helper')

describe(Question) do
  it("validates the presence of a description") do
    question = Question.create({:question => ""})
    expect(question.save()).to(eq(false))

  end

  it("capitalizes the first letter of the question") do
    question = Question.create({:question => "can we guess your sign by your favorite chip?"})
    expect(question.question).to(eq("Can we guess your sign by your favorite chip?"))
  end
end
