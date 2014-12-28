class Ajax::AnswerController < ApplicationController
  def destroy
    params.require :answer

    answer = Answer.find(params[:answer])

    unless (current_user == answer.user) or (privileged? answer.user)
      @status = :nopriv
      @message = "can't delete other people's answers"
      @success = false
      return
    end

    answer.user.decrement! :answered_count
    answer.question.decrement! :answer_count
    if answer.user == current_user
      Inbox.create!(user: answer.user, question: answer.question, new: true)
    end # TODO: decide what happens with the question
    Notification.denotify answer.question.user, answer
    answer.destroy

    @status = :okay
    @message = "Successfully deleted answer."
    @success = true
  end
end
