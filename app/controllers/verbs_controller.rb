class VerbsController < ApplicationController
  def index
    @verbs = Verb.all
  end

  def new
    @verb = Verb.new
  end

  def create
    @verb = Verb.new(params[:verb].permit(:infinitive, :group))
    respond_to do |format|
      if @verb.save
        format.html
        format.json{render action: 'show', status: :created, location: @verb}
      else
        format.html{render action: 'new'}
        format.json{render json:@verb.errors, status: :unprocessable_entity}
      end
    end
  end

end
