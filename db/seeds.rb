# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

mark = Person.create(
  name: 'mark',
  email: 'mark@raceweb.ca',
  password: 'pass',
  password_confirmation: 'pass',
  address: '456 fake st',
  city: 'victoria',
  postal: 'v9a 7b8',
  phone_home: '250-555-1234',
  phone_cell: '250-555-1234',
  # admin, owner, user
  authority: 7,
  born_on: 35.years.ago)

adam = Person.create(
  name: 'adam',
  email: 'adam@raceweb.ca',
  password: 'pass',
  password_confirmation: 'pass',
  address: '123 fake st',
  city: 'victoria',
  postal: 'v9a 1l1',
  phone_home: '250-555-1234',
  phone_cell: '250-555-1234',
  # owner, user
  authority: 6,
  born_on: 45.years.ago)

#
# Codes
#
sets = Code.create({id: 1, set_id: 1, code: 'root', description: 'root'})
lesson_status = Code.create({id: 2, set: sets, code: 'venue_status', description: 'venue status'})
lesson_status_active = Code.create({id: 3, set: lesson_status, code: '1', description: 'active'})
lesson_status_cancelled = Code.create({id: 4, set: lesson_status, code: '2', description: 'cancelled'})
enrollment_status = Code.create({id: 10, set: sets, code: 'enrollment_status', description: 'enrollment status'})
enrollment_status_pending = Code.create({id: 11, set: enrollment_status, code: '1', description: 'pending'})
enrollment_status_active = Code.create({id: 12, set: enrollment_status, code: '2', description: 'active'})
enrollment_status_declined = Code.create({id: 13, set: enrollment_status, code: '3', description: 'declined'})
enrollment_status_expired = Code.create({id: 14, set: enrollment_status, code: '4', description: 'expired'})

unless ENV["minimal"]

  cate = Person.create(
    name: 'cate',
    email: 'cate@raceweb.ca',
    password: 'pass',
    password_confirmation: 'pass',
    address: '321 fake st',
    city: 'victoria',
    postal: 'v0b 2l0',
    phone_home: '250-555-4321',
    phone_cell: '250-555-6666',
    # user
    authority: 4,
    born_on: 40.years.ago)

  eva = Person.create(
    name: 'eva',
    email: 'eva@raceweb.ca',
    password: 'pass',
    password_confirmation: 'pass',
    address: '456 fake st',
    city: 'victoria',
    postal: 'v9a 7b8',
    phone_home: '250-555-1234',
    phone_cell: '250-555-7777',
    # user
    authority: 4,
    born_on: 41.years.ago)

  mugs   = Dog.create(name: 'mugs',   breed: 'boxer', colour: 'brown', born_on: 3.years.ago, person: mark)
  mugs_note_1 = Note.create(dog: mugs, note: 'very stinky wierdo who likes to choke himself')
  mugs_note_2 = Note.create(dog: mugs, note: 'likes to eat grass')

  bullit = Dog.create(name: 'bullit', breed: 'sheperd/lab', colour: 'white', born_on: 4.years.ago, person: mark)
  bullit_note_1 = Note.create(dog: bullit, note: 'very calm no problems')
  bullit_note_2 = Note.create(dog: bullit, note: 'sheds like a bitch')

  darby  = Dog.create(name: 'darby',  breed: 'puggle', colour: 'brown', born_on: 5.years.ago, person: adam)
  darby_note_1 = Note.create(dog: darby, note: 'poops too much')

  chloe  = Dog.create(name: 'chloe',  breed: 'jackshit', colour: 'brown/white', born_on: 6.years.ago, person: cate)
  chloe_note_1 = Note.create(dog: chloe, note: 'chloe whines too much')

  test_body_1 = <<-eos
It is very comforting to know that while we are at work, someone as trustworthy and pet-loving as Mark, is taking care of our lab, Finley. He is reliable, responsive and trustworthy and we would definitely recommend him to anyone looking for pet care or walks. He will truly be impossible to replace and Finn will very much miss the time he spends with Mark and all his dog-buddies.

Mandy & Cameron

Also, if anyone wants to talk to us they can call me at 403-831-3542
eos

  test_body_2 = <<-eos
I have had the good fortune to have Mark walk my dogs, a golden retriever and a German shepherd for the past year. Mark leads his canine pack with a quiet confidence that is impressive. He is attentive to each dogs personality and to the interactions within the pack creating a harmonious and well behaved group of happy dogs. I have complete trust in Marks ability to care for my dogs and I can unreservedly recommend him.
eos

  test_body_3 = <<-eos
Dear Dog Owner,

It is my pleasure to provide this letter of reference for Mark Johnson of Zen Dogz.

Mark has been indispensable for me and my family in caring for and training my border terrier Zeus. From the very first day that Zeus spent with Mark, I noticed a big improvement in Zeus’ behaviour; he was and continues to be more obedient and able to focus on my commands. Mark’s calm but assertive demeanour instils tremendous confidence in dog owners and dogs alike – he is able to handle a large pack of dogs with ease. Even though Zeus is a high energy dog, I never was concerned that Mark could not deal with Zeus appropriately and I did not worry when Zeus was in Mark’s care.

Mark has done one-on-one training with me and my family, has provided day care, sleepovers and longer term care and I have absolutely no hesitation in recommending him for any of those services.

I am saddened by the fact that Mark is moving and will not be available to care for Zeus but I feel very fortunate to have been able to experience the excellent care that Mark has provided to Zeus over the past year. I am sure Zeus will miss Mark and the “pack” too.

If you would like to speak to me directly about my comments above, please call me at 403-287-7637.

Sincerely,
Siobhan Goguen
eos

  test_body_4 = <<-eos
Dear Mark,

I would like to take this opportunity to thank you for taking care of Charley over the past year. The daily walks for Charley were fantastic as he was such a good dog when I got home from work, it gave me time to make dinner and spend time with my family before our evening walk together. You have been very dependable and so calm, such a great leader for my energetic lab. The dog sitting service was exceptional as I never worried about Charley when he was in your care. He always came home well behaved and tired. He even loved the camping trip you took him on when he was just a pup. I know both Charley and I will miss you immensely. You have been a fantastic pack leader and we wish you and your family all the best!
eos

  test_body_5 = <<-eos
Dear Mark,

Mister Mugs is a changed dog since spending each weekday walking with Mark from Zen Dogz and his "pack". With Marks help he is learning every day as we are. Thank you for all your help!

Sylvia, Bruce & Mister Mugs
eos

  test_body_6 = <<-eos
Mark Johnson has worked with and walked my dogs since January 2012.

I have two dogs, both rescues. My older one is 12 years old; the younger one is now 17 months old. The younger dog is very gentle, but large (80lbs) and strong. He was not quite a year old when Mark began working with him. The older dog is high energy and has never learned to walk without pulling on the leash.

At the time I met Mark I was looking for a trainer/walker as I was feeling frustrated in trying to walk both dogs. Neither of them walked properly on leash, and no matter what I tried I could not teach them. It was too difficult walking them together, so I ended up walking them one at a time. (Good exercise for me, but very time consuming). It was also very frustrating in finding a dog walker who I trusted and who had similar expectations in terms of training and disciplining my dogs.

How I met Mark and decided to hire him is an interesting story. I have a job that offers me some flexibility in terms of my work day. One morning, I worked from home until late morning. When I was leaving my home I witnessed something that IMMEDIATLEY made me decide to hire Mark.

As I was backing my vehicle out of my driveway, I saw the most amazing thing: Mark was loading up his pack in my neighborhood after their daily walk. But here is what I almost could not believe. That day, I think he had ten (10) dogs (various sizes, breeds, and colors). All ten were leashed and sitting on the sidewalk. Mark was loading them into his van. All of the dogs were quite, sitting, and well-behaved. I could not believe my eyes. I remained in my vehicle and watched Mark load the dogs. None misbehaved. Mark was calm, and the dogs responded on cue. Just as Mark loaded the last dog, I drove up to where his van was parked and began to chat about what I just witnessed. Mark smiled as he modestly explained his business and his obvious skill in handling dogs. I asked Mark if he had time to work with my dogs, and luckily for me, he did.

During a consultation with Mark, he had both my dogs walking properly on the leash in less than one hour. Mark also shared some tips on how I could work with my dogs. I saw results within a couple of weeks.

Because I have a demanding job, I hired Mark to walk my dogs three times a week. My dogs responded very well to him and are much better behaved. I can now walk both my dogs by myself (without having my arms yanked from their sockets).

Mark is a skilled dog handler. He is calm and confident. He manages his business very professionally. He communicates any concerns he has or changes to his schedule well in advance of the change. He is punctual. He is willing to answer questions and to accommodate requests. Mark is a very personable individual, and he is genuine and trustworthy.

I highly recommend Mark to handle, work with, and walk your dogs.

Sincerely,
Kim Lambrecht
eos

  testimonial_1 = Testimonial.create(from: 'Mandy and Cam Dinning (Finn)', body: test_body_1, created_at: 1.hours.ago)
  testimonial_2 = Testimonial.create(from: 'Kim Nixon (Echo and Nova)', body: test_body_2, created_at: 1.days.ago)
  testimonial_3 = Testimonial.create(from: 'Siobhan Goguen (Zeus)', body: test_body_3, created_at: 1.weeks.ago)
  testimonial_4 = Testimonial.create(from: 'Nancy Giurici (Charley)', body: test_body_4, created_at: 1.months.ago)
  testimonial_5 = Testimonial.create(from: 'Bruce and Sylvia Pultz (Mugs)', body: test_body_5, created_at: 3.months.ago)
  testimonial_6 = Testimonial.create(from: 'Kim Lambrecht (Tuk and Barley)', body: test_body_6, created_at: 1.years.ago)

  # create a schedule for course_1
  course_1_schedule = IceCube::Schedule.new
  course_1_schedule.add_recurrence_rule(IceCube::Rule.weekly.day(:tuesday, :thursday).hour_of_day(18).minute_of_hour(30).until(Date.today + 2.months))
  course_1_schedule.add_recurrence_rule(IceCube::Rule.weekly.day(:saturday).hour_of_day(10).minute_of_hour(30).until(Date.today + 2.months))

  course_1 = Course.create(name: 'Take the Lead', description: '$650, includes required training equipment, schedule: course_1_schedule.to_yaml())
  lesson_1 = Lesson.create(name: 'sit stay', description: 'teach your dog to sit and stay', handout: 'sit_stay', course: course_1, status: lesson_status_active)
  lesson_2 = Lesson.create(name: 'lay down', description: 'teach your dog to lay down', handout: 'down', course: course_1, status: lesson_status_active)
  lesson_3 = Lesson.create(name: 'off leash', description: 'teach your dog to not run away', handout: 'off_leash', course: course_1, status: lesson_status_active)

  enrollment_1 = Enrollment.create(person: cate, course: course_1, status: enrollment_status_active, enrolled_on: 1.days.ago)
  enrollment_2 = Enrollment.create(person: adam, course: course_1, status: enrollment_status_active, enrolled_on: 9.days.ago)
  enrollment_3 = Enrollment.create(person: eva,  course: course_1, status: enrollment_status_expired, enrolled_on: 6.months.ago)

end
