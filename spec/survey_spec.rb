require('spec_helper')

describe(Survey) do
  it('validates the presence of a survey name') do
    survey = Survey.create({:name => "", :num_questions => 0})
    expect(survey.save()).to(eq(false))
  end

  it('capitalizes the first letter of a survey name') do
    survey = Survey.create({:name => "favorite animals", :num_questions => 0})
    expect(survey.name).to(eq("Favorite Animals"))
  end
end
