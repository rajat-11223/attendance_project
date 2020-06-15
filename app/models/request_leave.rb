class RequestLeave < ApplicationRecord


belongs_to :user

 enum status: [ :rejected, :approved ]
end
