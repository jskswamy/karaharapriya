# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

#create basic ragam
mayamalavagowlai= Ragam.create(:name => "MayamalavaGowlai", :arohana => "s r1 g2 m1 p t1 n2 s^", :avarohana => "s^ n2 t1 p m1 g2 r1 s")
sankarabharnam = Ragam.create(:name => "Sankarabharnam", :arohana => "s r2 g2 m1 p t2 n2 s^", :avarohana => "s^ n2 t2 p m1 g2 r2 s")
karaharapriya = Ragam.create(:name => "Karaharapriya", :arohana => "s r2 g1 m1 p t2 n1 s^", :avarohana => "s^ n1 t2 p m1 g1 r2 s")
Ragam.create(:name => "Thodi", :arohana => "s r1 g1 m1 p t1 n1 s^", :avarohana => "s^ n1 t1 p m1 g1 r1 s")
Ragam.create(:name => "Kalyani", :arohana => "s r2 g2 m2 p t2 n2 s^", :avarohana => "s^ n2 t2 p m2 g2 r2 s")
Ragam.create(:name => "Mohanam", :arohana => "s r2 g2 p t2 s^", :avarohana => "s^ t2 p g2 r2 s", :parent => sankarabharnam)
Ragam.create(:name => "Shivaranjani", :arohana => "s r2 g1 p t2 s^", :avarohana => "s^ t2 p g1 r2 s", :parent => karaharapriya)
Ragam.create(:name => "Boopalam", :arohana => "s r1 g2 p t1 s^", :avarohana => "s^ t1 p g2 r1 s", :parent => mayamalavagowlai)

#create basic talam
Talam.create(:name => "Adi", :avartanam => "1 0 0", :laghu_length => "4")

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
