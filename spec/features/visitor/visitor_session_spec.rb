feature = <<~HEREDOC
  When visitor login he gets session,
  he have not been active in a specified period of time
  so expires session and employee is logout
HEREDOC

RSpec.feature feature, issues: [111] do
  scenario = <<~HEREDOC
    Given user is logined
    When he have not been active in a 7 days
    Then expires session and user is logout
  HEREDOC

  scenario scenario do
    visitor = create(:user)

    expect(visitor.timedout?(7.days.ago)).to be true
  end
end
