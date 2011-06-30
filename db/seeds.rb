#create basic ragam
mayamalavagowlai= Ragam.create(:name => "MayamalavaGowlai", :arohana => "s r1 g2 m1 p t1 n2 s^", :avarohana => "s^ n2 t1 p m1 g2 r1 s", :description => "TBA")
sankarabharnam = Ragam.create(:name => "Sankarabharnam", :arohana => "s r2 g2 m1 p t2 n2 s^", :avarohana => "s^ n2 t2 p m1 g2 r2 s", :description => "TBA")
karaharapriya = Ragam.create(:name => "Karaharapriya", :arohana => "s r2 g1 m1 p t2 n1 s^", :avarohana => "s^ n1 t2 p m1 g1 r2 s", :description => "TBA")
Ragam.create(:name => "Thodi", :arohana => "s r1 g1 m1 p t1 n1 s^", :avarohana => "s^ n1 t1 p m1 g1 r1 s", :description => "TBA")
Ragam.create(:name => "Kalyani", :arohana => "s r2 g2 m2 p t2 n2 s^", :avarohana => "s^ n2 t2 p m2 g2 r2 s", :description => "TBA")
Ragam.create(:name => "Mohanam", :arohana => "s r2 g2 p t2 s^", :avarohana => "s^ t2 p g2 r2 s", :parent => sankarabharnam, :description => "TBA")
Ragam.create(:name => "Shivaranjani", :arohana => "s r2 g1 p t2 s^", :avarohana => "s^ t2 p g1 r2 s", :parent => karaharapriya, :description => "TBA")
Ragam.create(:name => "Boopalam", :arohana => "s r1 g2 p t1 s^", :avarohana => "s^ t1 p g2 r1 s", :parent => mayamalavagowlai, :description => "TBA")

#create basic talam
Talam.create(:name => "Adi", :avartanam => "1 0 0", :laghu_length => "4", :description => "Talam with 8 beat")

#create basic composers
Composer.create(:name => "Thiagarajar", :century => "18th", :info => "Great Composer")

#create song types
SongType.create(:name => "Sarali Varisai", :description => "Beginner Lesson")
SongType.create(:name => "Janda Varisai", :description => "Beginner Lesson")
SongType.create(:name => "Alangaram", :description => "Beginner Lesson")
SongType.create(:name => "Melsthai Varisai", :description => "Beginner Lesson")
SongType.create(:name => "Geetham", :description => "Beginner Lesson")
SongType.create(:name => "Swarajathi", :description => "Beginner Lesson")
SongType.create(:name => "Varnam", :description => "Beginner Lesson")
SongType.create(:name => "Keerthanai", :description => "Beginner Lesson")

#create user
User.create(:name => "Admin", :email => "admin@admin.com", :password => "password")
