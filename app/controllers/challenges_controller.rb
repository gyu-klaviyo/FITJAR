class ChallengesController < ApplicationController
  before_action :set_challenge, only: [:show, :edit, :update, :destroy, :get_questions]
  before_filter :authenticate_user!, only: [:host, :new, :create, :edit, :update, :destroy]
  before_filter :check_user, only: [:edit, :update, :destroy]
  

#JQ I need to re-define this host not just as a current user signed in by higher authority than a regular user

  def host
    @challenges = Challenge.where(user: current_user).order("created_at DESC")
  end

  def player
    @challenges = Challenge.where(user: current_user).order("created_at DESC")
  end

  #def get_questions
    #@questions = Questions.find(params[:questions_id])
    #@challenge = @question.challenge.find(params[:id])
  #end

  # GET /challenges
  # GET /challenges.json
  def index
    @challenges = Challenge.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 8 )
    @comments = Comment.where(commentable_type: "Challenge").find(:all, limit: 15, order: 'created_at DESC')
  end

  # GET /challenges/1
  # GET /challenges/1.json
  def show
    @challenges = Challenge.all
    
    #try this one:
    #@challenge=Challenge.all.find(params[:challenge_id])
    #@question = @challenge.question.find(params[:id])

    #@root_comments = @questions.root_comments
    #@comments = @question.root_comments.order('created_at DESC')
    #@new_comment = Comment.build_from(@question, current_user, "")

    #@comments = @question.root_comments.order('created_at DESC')
    #@new_comment = Comment.build_from(@question, current_user, "")
    
    #VERSION FROM GITHUB, THEY USE ARTICLE AS EXAMPLE
    #@challenge = Challenge.find(params[:id])
    #@user_who_commented = @current_user
    #@comment = Comment.build_from( @challenge, @user_who_commented.id, "Hey guys this is my comment!" )
    
    #@questions = @challenge.root_comments
    
    #ALEX chap
    #@challenge = Challenge.all
    #@comments = @challenge.root_comments.order('created_at DESC')
    #@new_comment = Comment.build_from(@challenge, current_user, "")

    #ALEX QUES CONTROL
    
  end

  # GET /challenges/new
  def new
    @challenge = Challenge.new
  end

  # GET /challenges/1/edit
  def edit
  end

  # POST /challenges
  # POST /challenges.json
  def create
    @challenge = Challenge.new(challenge_params)
    #set user id for challenge to current user
    #set this to HOST ID
    #take user id and assign to host if user created=HOST...else user END
    @challenge.user_id = current_user.id


    Stripe.api_key = ENV["STRIPE_API_KEY"]
    token = params[:stripeToken]

    recipient = Stripe::Recipient.create(
      :name => current_user.full_name,
      :type => "individual",
      :bank_account => token
      )

    current_user.recipient = recipient.id
    current_user.save


#move this to DEVISE edit user profile.  You don't want users to put in their bank info in the begining of creating a challenge

  
    respond_to do |format|
      if @challenge.save
        format.html { redirect_to @challenge, notice: 'Challenge was successfully created.' }
        format.json { render action: 'show', status: :created, location: @challenge }
      else
        format.html { render action: 'new' }
        format.json { render json: @challenge.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /challenges/1
  # PATCH/PUT /challenges/1.json
  def update
    respond_to do |format|
      if @challenge.update(challenge_params)
        format.html { redirect_to @challenge, notice: 'Challenge was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @challenge.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /challenges/1
  # DELETE /challenges/1.json
  def destroy
    @challenge.destroy
    respond_to do |format|
      format.html { redirect_to challenges_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_challenge
      @challenge = Challenge.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.  ADD WEARABLE TECH HERE
    def challenge_params
      params.require(:challenge).permit(:name, :duration, :start, :image, :stake)
    end

    #DELETE THIS AFTER, MAKES NO SENSE FOR FITJAR>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    def check_user
      if current_user != @challenge.user
        redirect_to root_url, alert: "Sorry, only the host may edit this challenges"
      end
    end
end
