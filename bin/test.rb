def test_user
  ben = User.new
  puts ben
  
  ben.update(:album, 1, 'Thriller')
  puts ben
  
  ben.update(:album, 2, 'White Album')
  puts ben
  
  ben.update(:album, 3, 'Yellow Submarine')
  puts ben
  
  ben.update(:album, 1, 'Godbluff')
  puts ben
  
  ben.update(:book, 2, 'Bible')
  puts ben
  
  ben.update(:album, 2, 'Test')
  puts ben
end
