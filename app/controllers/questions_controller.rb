class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  before_action :set_challenge
  before_action :authenticate_user!, only: [:new, :create]
  before_action :require_admin, only: [:edit, :update, :destroy]

  # GET /questions
  # GET /questions.json


  # GET /questions/1
  # GET /questions/1.json
  def show
    @comments = @question.root_comments.order('created_at DESC')
    @new_comment = Comment.build_from(@question, current_user, "")
  end
#class WeaponsController < ApplicationController
 # def toggle_condition
  #  @weapon = Weapon.find(params[:id]) 
   # @weapon.toggle_condition 
    #respond_to do |format|
     # format.html { redirect_to @weapon, notice: 'Changed condition' }
      #format.js 
    #end
  #end
#end

  # GET /questions/new
  def new
    @question = Question.new
#JQ - per video when we created a payment with new challenge, we also gave it a challenge ID in the sql column
    @challenge = Challenge.find(params[:challenge_id])
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)
    @question.user_id = current_user.id
    @question.user_name = current_user.user_name
    @question.challenge_id = @challenge.id
    @challenge = Challenge.find(params[:challenge_id])
#JQ - per video when we created a payment with new challenge, we also gave it a challenge ID in the sql column



    respond_to do |format|
      if @question.save
        #UserMailer.question_notification(current_user.name, @question.subject, @question.details).deliver
        format.html { redirect_to root_path, notice: 'Question was successfully created.' }
        format.json { render action: 'show', status: :created, location: @question }
      else
        format.html { render action: 'new' }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    def set_challenge
      @challenge = Challenge.find(params[:challenge_id])
    end
    
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:subject, :details)
    end
end
