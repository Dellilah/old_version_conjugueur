class VerbsController < ApplicationController
  before_action :set_verb, only: [:show, :edit, :update]
  before_action :set_tenses, only: [:show, :edit, :update, :new, :create]
  ActionController::Parameters.permit_all_parameters = true

  def index
    @verbs = Verb.all.order('infinitive')
  end

  def new
    @verb = Verb.new
  end

  def edit
  end

  def show
  end

  def create
    @tenses_form = Hash.new
    @verb = Verb.new(params.permit(:infinitive, :group))
    respond_to do |format|
      if @verb.save

        params.each do |index, el|
          name = index.split("__");
          if name.length > 1
            if @tenses_form[name[0]]
              @tenses_form[name[0]][name[1]] = el
              @tenses_form[name[0]]['verb_id'] = @verb.id
            else
              @tenses_form[name[0]] = {name[1] => el}
            end
          end
        end

        @tenses_form.each do |key, value|
          a = Module.const_get(key).new(value)
          a.save
        end

        format.html{redirect_to @verb, notice: 'Verb added'}
        format.json{render action: 'show', status: :created, location: @verb}
      else
        format.html{render action: 'new'}
        format.json{render json:@verb.errors, status: :unprocessable_entity}
      end
    end
  end

  def update
    puts params['verb']
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
