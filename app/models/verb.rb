class Verb < ActiveRecord::Base
  has_one :present, dependent: :destroy
  has_one :futur_simple, dependent: :destroy
  has_one :passe_compose, dependent: :destroy
  has_one :imparfait, dependent: :destroy
  has_one :passe_simple, dependent: :destroy
  has_one :subjonctif, dependent: :destroy
  has_one :plus_que_parfait, dependent: :destroy
end
