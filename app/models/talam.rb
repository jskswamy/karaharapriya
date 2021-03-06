class Talam
  include Mongoid::Document
  include Mongoid::Globalize
  include Suggest

  field :name, :type => Hash
  field :avartanam
  field :laghu_length, :type => Integer

  validates_presence_of :name, :avartanam, :laghu_length
  validates_uniqueness_of :name
  validates_uniqueness_of :laghu_length, :through => :avartanam

  validate :validate_avartanam
  translate :name

  def akshram_length_map
    @akshram_length_map ||= {"1" => self.laghu_length, "0" => 2, "U" => 1}
  end

  def validate_avartanam
    return if avartanam.blank?
    errors.add(:avartanam, "has invalid character") unless (avartanam.split(' ') - akshram_length_map.keys).empty?
  end

  def total_aksharam_length
    length = 0;
    avartanam.split(' ').each { |lagu_drutham| length += aksharam_length(lagu_drutham) } unless avartanam.blank?
    return length
  end

  def aksharam_length(key)
    akshram_length_map[key]
  end

  def to_param
    self.name
  end

end
