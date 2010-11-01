class Composer < ActiveRecord::Base
  include Sorter
  has_many :songs
end
