# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

# hashed from 'adam_pass'
# password_digest: $2a$10$MuZ/FSYjDkIim0zFodiV1OjpgDRzKSpnHQtykmm.JQSVGq3JE7BJS
mark = Person.create(name: 'mark', email: 'mark@raceweb.ca', address: '456 fake st', city: 'victoria', postal: 'v9a 7b8', phone_home: '250-555-1234', phone_cell: '250-555-1234', authority: 3, born_on: 35.years.ago)
# hashed from 'adam_pass'
# password_digest: $2a$10$MuZ/FSYjDkIim0zFodiV1OjpgDRzKSpnHQtykmm.JQSVGq3JE7BJS
adam = Person.create(name: 'adam', email: 'adam@raceweb.ca', address: '123 fake st', city: 'victoria', postal: 'v9a 1l1', phone_home: '250-555-1234', phone_cell: '250-555-1234', authority: 1, born_on: 45.years.ago)

if ENV["full"]
  # hashed from 'adam_pass'
  # password_digest: $2a$10$MuZ/FSYjDkIim0zFodiV1OjpgDRzKSpnHQtykmm.JQSVGq3JE7BJS
  cate = Person.create(name: 'cate', email: 'cate@raceweb.ca', address: '321 fake st', city: 'victoria', postal: 'v0b 2l0', phone_home: '250-555-4321', phone_cell: '250-555-6666', authority: 1, born_on: 40.years.ago)

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

  testimonial_1 = Testimonial.create(from: 'Nancy Giurici (Charley)', body: 'test one body')
  testimonial_1 = Testimonial.create(from: 'Bruce and Sylvia Pultz (Mugs)', body: 'test two body')


  course_1 = Course.create(name: 'course one', description: 'course one description')
  course_2 = Course.create(name: 'course two', description: 'course two description')


end