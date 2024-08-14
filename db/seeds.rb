
# Delete all existing records, users, and tags
Record.delete_all
User.delete_all
Tag.delete_all

# Reset primary keys (optional)
ActiveRecord::Base.connection.reset_pk_sequence!('records')
ActiveRecord::Base.connection.reset_pk_sequence!('users')
ActiveRecord::Base.connection.reset_pk_sequence!('tags')

# Create 3 users
user1 = User.create!(
  email: 'designer1@example.com',
  password: 'password123',
  password_confirmation: 'password123'
)

user2 = User.create!(
  email: 'engineer1@example.com',
  password: 'password123',
  password_confirmation: 'password123'
)

user3 = User.create!(
  email: 'architect1@example.com',
  password: 'password123',
  password_confirmation: 'password123'
)

# Create tags related to CAD
tag1 = Tag.create!(name: '3D Modeling')
tag2 = Tag.create!(name: 'Mechanical Design')
tag3 = Tag.create!(name: 'Architecture')
tag4 = Tag.create!(name: 'Engineering')
tag5 = Tag.create!(name: 'Drafting')

# Create 8 CAD-related records associated with the users and tags
Record.create!([
                 { title: 'Engine Block Design', description: '3D model of an engine block for automotive use.', user: user1, tags: [tag1, tag2] },
                 { title: 'Architectural Floor Plan', description: 'Floor plan for a modern residential building.', user: user3, tags: [tag3, tag5] },
                 { title: 'Mechanical Gear Assembly', description: 'Detailed mechanical design of a gear assembly.', user: user2, tags: [tag2, tag4] },
                 { title: 'Bridge Structure Model', description: 'CAD model of a suspension bridge structure.', user: user2, tags: [tag4] },
                 { title: 'Product Prototype Design', description: '3D model for a consumer product prototype.', user: user1, tags: [tag1] },
                 { title: 'Electrical Layout Design', description: 'Layout for electrical wiring in a commercial building.', user: user3, tags: [tag3, tag4] },
                 { title: 'Urban Planning Model', description: '3D model representing urban planning for a city district.', user: user3, tags: [tag3] },
                 { title: 'HVAC System Draft', description: 'Draft of HVAC system for an industrial facility.', user: user2, tags: [tag5, tag4] }
               ])
