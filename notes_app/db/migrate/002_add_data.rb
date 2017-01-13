class AddData < ActiveRecord::Migration[5.0]
  def up
    execute "insert into notes values (null, 'Test note', 'This is a test note to show you the features of this app.', 1, datetime(), datetime())"
    execute "insert into notes values (null, 'To Do', '1. Report issue with Notes app regarding separation of notes between users.', 1, datetime(), datetime())"
    execute "insert into notes values (null, 'What you''re looking for', 'flag_E6GQPvPYrqX64As9B8RNTcQwOgBjRbdRvhgQjT5UqSTYcHxQdMw8ykgoy9lcqwA', 2, datetime(), datetime())"
    execute "insert into users values (null, 'Administrator', datetime(), datetime())"
    execute "insert into users values (null, 'Michael Brunton-Spall', datetime(), datetime())"
    execute "insert into users values (null, 'Ruben Arakelyan', datetime(), datetime())"
  end

  def down
    execute 'truncate table notes'
    execute 'truncate table users'
  end
end
