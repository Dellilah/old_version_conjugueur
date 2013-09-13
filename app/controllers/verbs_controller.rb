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
    @tenses = Hash.new
    @verb = Verb.new(params.permit(:infinitive, :group))
    respond_to do |format|
      if @verb.save

        params.each do |index, el|
          name = index.split("__");
          if name.length > 1
            if @tenses[name[0]]
              @tenses[name[0]][name[1]] = el
              @tenses[name[0]]['verb_id'] = @verb.id
            else
              @tenses[name[0]] = {name[1] => el}
            end
          end
        end

        # Nie działa String => Object?
        # @tenses.each do |key, value|
        #   a = key.new(value)
        #   a.save
        # end

        tense = Present.new(@tenses['Present'])
        tense.save
        tense = Imparfait.new(@tenses['Imparfait'])
        tense.save
        tense = PasseCompose.new(@tenses['PasseCompose'])
        tense.save
        tense = PasseSimple.new(@tenses['PasseSimple'])
        tense.save
        tense = PlusQueParfait.new(@tenses['PlusQueParfait'])
        tense.save
        tense = FuturSimple.new(@tenses['FuturSimple'])
        tense.save
        tense = Subjonctif.new(@tenses['Subjonctif'])
        tense.save

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

  private

    def set_verb
      @verb = Verb.find(params[:id])
    end

    def set_tenses
      @tenses = [:present, :imparfait, :passe_compose, :passe_simple, :plus_que_parfait, :futur_simple, :subjonctif]
      @forms = [:je, :tu, :il, :nous, :vous, :ils]
    end

end
