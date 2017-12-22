class Admin < ApplicationRecord
  before_create do
    logger.debug 'c'
  end

  after_save do
    logger.debug 's'
  end

  validates_presence_of :name
end

a = Admin.new
a.save
logger.debug 'j'

a.name = 'Joe'
a.save
a.update_attributes name:'Juan'

