class ModelCourse < ApplicationRecord
    include RankedModel
    ranks :row_order
    
end
