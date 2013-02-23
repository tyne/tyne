# Represents the Votes feature
class VotesCell < Cell::Rails
  # Shows the Votes cell
  def show(votable, *args)
    @votable = votable
    @total_votes = votable.total_votes
    @upvote_path = args[0][:upvote_path]
    @downvote_path = args[0][:downvote_path]

    render
  end
end
