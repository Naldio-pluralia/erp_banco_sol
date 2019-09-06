class Municipality < ApplicationRecord
    belongs_to :province
    has_many :establishments

    validates_presence_of :province_id, :name
    validates_uniqueness_of :name, scope: [:province_id]
end
