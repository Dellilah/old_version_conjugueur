class VerbsController < ApplicationController
  def index
    @verbs = Verb.all
  end

  def new
    @verb = Verb.new
    @times = ['present', 'imparfait', 'passe_compose', 'passe_simple', 'plus_que_parfait', 'futur_simple', 'subjonctif']
  end

  def create
    @verb = Verb.new(params.permit(:infinitive, :group))
    respond_to do |format|
      if @verb.save
        @params = @verb.id
        format.html
        format.json{render action: 'show', status: :created, location: @verb}
      else
        format.html{render action: 'new'}
        format.json{render json:@verb.errors, status: :unprocessable_entity}
      end
    end
  end

end
