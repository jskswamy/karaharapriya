class Ragam < ActiveRecord::Base
  has_many :song_content_info, :as => :info
end
