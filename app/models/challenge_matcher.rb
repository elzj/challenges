class ChallengeMatcher
  attr_reader :challenge
  def initialize(challenge)
    @challenge = challenge
  end

  # so now for each user, I should have an array of potential matches
  # each with the prompt id, match score, and assignee information
  def generate!
    challenge.signups.find_each do |signup|
      next if signup.potential_matches.exists?
      pm = PotentialMatch.new(
        challenge_signup_id: signup.id,
        challenge_id: signup.challenge_id,
        total_matches: 0
      )
      matches = signup.requests.map { |prompt|
        PromptMatcher.generate_matches(prompt)
      }.flatten.compact
      pm.matches = (pm.matches + matches).uniq.sort { |a,b| b[:score] <=> a[:score] }
      pm.total_matches = pm.matches.length
      pm.save!
    end
  end
end
