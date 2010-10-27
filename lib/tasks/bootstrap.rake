namespace :bootstrap do

  desc "runs all default bootstrap tasks"
  task :run_all => [:create_basic_ragam, :create_basic_talam, :create_song_type, :create_song_content_type, :create_song_composition, :create_composers]

  desc "Create basic ragam"
  task :create_basic_ragam => :environment do
    Ragam.delete_all
    mayamalavagowlai= Ragam.create(:name => "MayamalavaGowlai", :arohana => "s r1 g2 m1 p t1 n2 s^", :avarohana => "s^ n2 t1 p m1 g2 r1 s", :major => true)
    sankarabharnam = Ragam.create(:name => "Sankarabharnam", :arohana => "s r2 g2 m1 p t2 n2 s^", :avarohana => "s^ n2 t2 p m1 g2 r2 s", :major => true)
    karaharapriya = Ragam.create(:name => "Karaharapriya", :arohana => "s r2 g1 m1 p t2 n1 s^", :avarohana => "s^ n1 t2 p m1 g1 r2 s", :major => true)
    Ragam.create(:name => "Thodi", :arohana => "s r1 g1 m1 p t1 n1 s^", :avarohana => "s^ n1 t1 p m1 g1 r1 s", :major => true)
    Ragam.create(:name => "Kalyani", :arohana => "s r2 g2 m2 p t2 n2 s^", :avarohana => "s^ n2 t2 p m2 g2 r2 s", :major => true)
    Ragam.create(:name => "Mohanam", :arohana => "s r2 g2 p t2 s^", :avarohana => "s^ t2 p g2 r2 s", :major => false, :parent_id => sankarabharnam)
    Ragam.create(:name => "Shivaranjani", :arohana => "s r2 g1 p t2 s^", :avarohana => "s^ t2 p g1 r2 s", :major => false, :parent_id => karaharapriya)
    Ragam.create(:name => "Boopalam", :arohana => "s r1 g2 p t1 s^", :avarohana => "s^ t1 p g2 r1 s", :major => false, :parent_id => mayamalavagowlai)
  end

  desc "Create basic talam"
  task :create_basic_talam => :environment do
    Talam.delete_all
    Talam.create(:name => "Adi", :avartanam => "1 0 0", :laghu_length => "4")
  end

  desc "Create song types"
  task :create_song_type => :environment do
    SongType.delete_all
    ["Sarali", "Jandai", "Alangaram", "MelSthayi", "Keerthanai", "Geetham", "Varnam", "Swarajathi"].each do |type|
      SongType.create(:name => type)
    end
  end

  desc "Create song content types"
  task :create_song_content_type => :environment do
    SongContentType.delete_all
    ["Basic", "Pallavi", "Anupallavi", "MuthayiSwaram", "Charanam"].each do |type|
      SongContentType.create(:name => type)
    end
  end

  desc "Create song composition"
  task :create_song_composition => :environment do
    SongComposition.delete_all
    basic_content_type = SongContentType.find_by_name("Basic")
    SongComposition.create(:song_type => SongType.find_by_name("Sarali"), :song_content_type => basic_content_type)
    SongComposition.create(:song_type => SongType.find_by_name("Jandai"), :song_content_type => basic_content_type)
    SongComposition.create(:song_type => SongType.find_by_name("Alangaram"), :song_content_type => basic_content_type)
    SongComposition.create(:song_type => SongType.find_by_name("MelSthayi"), :song_content_type => basic_content_type)
    keerthanai_song_type = SongType.find_by_name("Keerthanai")
    SongComposition.create(:song_type => keerthanai_song_type, :song_content_type => SongContentType.find_by_name("Pallavi"))
    SongComposition.create(:song_type => keerthanai_song_type, :song_content_type => SongContentType.find_by_name("Anupallavi"))
    SongComposition.create(:song_type => keerthanai_song_type, :song_content_type => SongContentType.find_by_name("Charanam"))
  end

  desc "Create composers"
  task :create_composers => :environment do
    Composer.delete_all
    Composer.create(:name => "Thiagarajar", :century => "18th", :info => "Great Composer")
  end

end
