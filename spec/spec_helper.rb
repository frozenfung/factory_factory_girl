require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require "factory_factory_girl"
require "generator_spec"
require "pry"
require "active_record"

ActiveRecord::Base.default_timezone = "Taipei"
ActiveRecord::Base.time_zone_aware_attributes = true

# migrations
ActiveRecord::Base.establish_connection adapter: "sqlite3", database: "tmp/:factory_factory_girl:"

ActiveRecord::Base.raise_in_transactional_callbacks = true if ActiveRecord::Base.respond_to?(:raise_in_transactional_callbacks=)

unless ActiveRecord::Base.connection.table_exists?("posts") ||
    ActiveRecord::Base.connection.table_exists?("users")
  ActiveRecord::Migration.create_table :posts do |t|
    t.string :title
    t.integer :user_id
    t.boolean :is_published
    t.integer :view_count
    t.text :description
    t.text :content
    t.timestamps null: true
  end

  ActiveRecord::Migration.create_table :users do |t|
    t.string :name
    t.string :email
  end
end
class Post < ActiveRecord::Base
end

class User < ActiveRecord::Base
end


