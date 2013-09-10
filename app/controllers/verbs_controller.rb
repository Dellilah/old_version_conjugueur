class VerbsController < ApplicationController

  def index
    @verbs = Verb.all
  end

  def new
    @verb = Verb.new
    @times = ['Present', 'Imparfait', 'PasseCompose', 'PasseSimple', 'PlusQueParfait', 'FuturSimple', 'Subjonctif']
  end

  def show
    @verb = Verb.find(params[:id])
    @present = @verb.present
    @imparfait = @verb.imparfait
    @passe_compose = @verb.passe_compose
    @passe_simple = @verb.passe_simple
    @plus_que_parfait = @verb.plus_que_parfait
    @futur_simple = @verb.futur_simple
    @subjonctif= @verb.subjonctif
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

end
