class Lease < ApplicationRecord
    belongs_to :apartments
    belongs_to :tenants
end
