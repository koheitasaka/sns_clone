class AccountSuspension < ApplicationRecord
	belongs_to :user
    belongs_to :report, class_name: 'User'
	validates :user_id, presence: true
	#一意の組み合わせ↓
    validates :user_id, :uniqueness => {:scope => :report_id}
end


