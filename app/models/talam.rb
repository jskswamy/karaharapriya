class Talam < ActiveRecord::Base
  has_many :song_content_info, :as => :info
  validate :validate_avartanam

  def akshram_length_map
    @akshram_length_map ||= {"1" => self.laghu_length, "0" => 2, "U" => 1}
  end

  def validate_avartanam
    errors.add(:base, "Please enter valid combination in avartanam") unless (avartanam.split(' ') - akshram_length_map.keys).empty?
  end

  def total_aksharam_length
    length = 0;
    avartanam.split(' ').each do |lagu_drutham|
      length += aksharam_length(lagu_drutham)
    end
    return length
  end

  def aksharam_length(key)
    akshram_length_map[key]
  end

end
