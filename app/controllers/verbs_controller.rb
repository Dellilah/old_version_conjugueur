class VerbsController < ApplicationController
  respond_to :json
  before_action :set_verb, only: [:show, :edit, :update]
  before_action :set_tenses, only: [:show, :edit, :update, :new, :create, :practice, :by_infinitive]
  ActionController::Parameters.permit_all_parameters = true

  def index
    @verbs = Verb.all.order('infinitive')
    respond_to do |format|
      format.html
      format.json {render json: @verbs}
    end
  end

  def by_infinitive
    @verb = Verb.where(infinitive: params['infinitive']).take
    respond_to do |format|
      format.html {render action: 'show', location: @verb}
      format.json {render json: @verb}
    end
  end

  def by_group
    @verbs = Verb.where(group: params['group'])
    respond_to do |format|
      format.json {render json: @verbs}
    end
  end

  def check_form
    conj = Module.const_get(params['tense']).where(verb_id: params['verb_id']).take
    @form = {f: conj.send(params['form'])}
    respond_to do |format|
      format.json {render json: @form}
    end
  end

  def new
    @verb = Verb.new
    @verb.present = Present.new
    @verb.imparfait = Imparfait.new
    @verb.passe_compose = PasseCompose.new
    @verb.passe_simple = PasseSimple.new
    @verb.plus_que_parfait = PlusQueParfait.new
    @verb.futur_simple = FuturSimple.new
    @verb.subjonctif = Subjonctif.new
  end

  def edit
  end

  def show
  end

  def create
    @verb = Verb.new(params['verb'])
    respond_to do |format|
      if @verb.save
        format.html{redirect_to @verb, notice: 'Verb added'}
        format.json{render action: 'show', status: :created, location: @verb}
      else
        format.html{render action: 'new'}
        format.json{render json:@verb.errors, status: :unprocessable_entity}
      end
    end
  end

  def update
    respond_to do |format|
      if @verb.update(params['verb'])
        format.html { redirect_to @verb, notice: 'Verb was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @verb.errors, status: :unprocessable_entity }
      end
    end
  end

  def download
    a = download_conjugation(params[:page])
    @verbs_conj.each do |verb|
      v = Verb.new(verb)
      v.save
    end
    @verbs = Verb.all.order('infinitive')
    respond_to do |format|
      format.html{ render action: 'index'}
      format.json { head :no_content }
    end
  end

  def practice
  end

  private

    def set_verb
      @verb = Verb.find(params[:id])
    end

    def set_tenses
      @tenses_new = [:Present, :Imparfait, :PasseCompose, :PasseSimple, :PlusQueParfait, :FuturSimple, :Subjonctif]
      @tenses = [:present, :imparfait, :passe_compose, :passe_simple, :plus_que_parfait, :futur_simple, :subjonctif]
      @forms = [:je, :tu, :il, :nous, :vous, :ils]
    end

end
