classdef Product
    properties
        quality
        reviews
    end
    
    methods
        function obj = Product(star_rating, polarity, subjectivity)
            obj.quality = mean(star_rating);
            obj.reviews = [star_rating polarity subjectivity];
        end
    end
end
