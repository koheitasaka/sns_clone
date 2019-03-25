class Relationship < ApplicationRecord
	belongs_to :user
    belongs_to :follow, class_name: 'User'
    validates_uniqueness_of :user_id, scope: :follow_id
end
