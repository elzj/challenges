class AssignmentGenerator

  attr_reader :challenge
  def initialize(challenge)
    @challenge = challenge
  end

  def generate!
    assign_requests
    assign_remaining_offers
    send_notifications
  end

  # Sort potential matches by fewest to most hits
  # For each number of hits, randomize the group of signups
  # Then loop through and assign each one, excluding matches
  # which are already assigned and avoiding circular matches
  # where possible. 
  # When they're all assigned, send a notification.

  def assign_requests
    match_counts = challenge.potential_matches.pluck(:total_matches).sort.uniq
    match_counts.each do |count|
      matches = challenge.potential_matches.where(total_matches: count)
      matches = matches.sort_by {rand}
      matches.each do |potential_match|
        assign(potential_match)
      end
    end
  end

  def assign_remaining_offers
    unassigned = ChallengeSignup.where.not(
      id: ChallengeAssignment.where(challenge: challenge.id).pluck(:assignment_id)
    )
    unassigned.each do |signup|
      assignment = ChallengeAssignment.new(
        challenge_id: signup.challenge_id,
        assignment_id: signup.id
      )
      matches = signup.offers.map { |prompt|
        PromptMatcher.generate_matches(prompt, prompt_type: 'request')
      }.flatten.compact.uniq.sort { |a,b| b[:score] <=> a[:score] }
      matches.each do |matching|
        next if request_already_assigned?(matching)
        assignment.user_id = matching[:user_id]
        assignment.signup_id = matching[:match_signup_id]
        break
      end
      assignment.save if assignment.valid?
    end
  end

  def send_notifications
    #UserMailer.potential_match_generation_notification(collection.id).deliver
  end

  def assign(potential_match)
    assignment = ChallengeAssignment.new(
      challenge_id: potential_match.challenge_id,
      signup_id: potential_match.challenge_signup_id
    )
    last_choice = nil
    potential_match.matches.each do |matching|
      next if already_assigned?(matching)
      assignment.user_id = matching[:user_id]
      # if there's a circular match let's save it as our last choice
      if !last_choice && circular?(matching)
        last_choice = potential_match
        next
      end
      # otherwise let's use it
      assignment.assignment_id = matching[:match_signup_id]
      break
    end
    if assignment.assignment_id.blank? && last_choice
      assignment.assignment_id = last_choice[:match_signup_id]
    end
    assignment.save
  end

  def already_assigned?(matching)
    ChallengeAssignment.where(
      assignment_id: matching[:match_signup_id]
    ).exists?
  end

  def request_already_assigned?(matching)
    ChallengeAssignment.where(
      signup_id: matching[:match_signup_id]
    ).exists?
  end  

  # Given a matching hash with a request prompt id and an offer match id
  # Check to see if there's an already an assignment the other way around
  def circular?(matching)
    ChallengeAssignment.where(
      signup_id: matching[:match_signup_id],
      assignment_id: matching[:signup_id]
    ).exists?
  end
end