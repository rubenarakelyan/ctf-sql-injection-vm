ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'db/notes.sqlite3'
)

class Note < ActiveRecord::Base
  validates :title, :body, presence: true
end
