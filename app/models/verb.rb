class Verb < ActiveRecord::Base
  has_one :present, dependent: :destroy
  has_one :futur_simple, dependent: :destroy
  has_one :passe_compose, dependent: :destroy
  has_one :imparfait, dependent: :destroy
  has_one :passe_simple, dependent: :destroy
  has_one :subjonctif, dependent: :destroy
  has_one :plus_que_parfait, dependent: :destroy

  accepts_nested_attributes_for :present
  accepts_nested_attributes_for :futur_simple
  accepts_nested_attributes_for :passe_compose
  accepts_nested_attributes_for :imparfait
  accepts_nested_attributes_for :passe_simple
  accepts_nested_attributes_for :subjonctif
  accepts_nested_attributes_for :plus_que_parfait
end
