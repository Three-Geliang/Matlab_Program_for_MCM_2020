classdef Customer
    properties
        reviews_wants_to_see
        polarity
        subjectivity
        rating
        real_rating
        product
        k1
        k2
    end
    methods
        function obj = Customer(product, real_rating, real_polarity, real_subjectivity, k1, k2)
            obj.k1 = k1;
            obj.k2 = k2;
            obj.reviews_wants_to_see = round(max(0,normrnd(5,3)));
            obj.polarity = real_polarity;
            obj.subjectivity = real_subjectivity;
            obj.product = product;
            obj.real_rating = real_rating;
            obj.rating = rate(obj);
        end
        
        function influence_parameter = generateInfluenceParameter(obj)
            influence_parameter = 1;
        end
        
        function rating = rate(obj)
            total_number_of_reviews = size(obj.product.reviews, 1);
            numbers_of_reviews_being_seen = min(total_number_of_reviews, obj.reviews_wants_to_see);
            reviews_being_seen = obj.product.reviews(total_number_of_reviews - numbers_of_reviews_being_seen + 1:total_number_of_reviews,:);
            if size(reviews_being_seen,1) == 0
                reviews_being_seen = 0;
            end
            influence = (obj.k1*(obj.real_rating - obj.product.quality) + obj.k2 * numbers_of_reviews_being_seen * (obj.real_rating - mean(reviews_being_seen(:,1))));
            rating = round(influence + obj.product.quality);
        end  
    end
end