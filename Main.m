clc, clear

k1=0.7;
k2=0.13;

load('data.mat')
real_product = Product(star_rating, polarity, subjectivity);
real_products_in_total = size(real_product.reviews,1);

customers_index = 1:real_products_in_total;

virtual_product = Product(3,0,0.5);
for i = customers_index
    new_customer = Customer(virtual_product, star_rating(i,1), polarity(i,1), subjectivity(i,1), k1, k2);
    new_review = [new_customer.rating,new_customer.polarity,new_customer.subjectivity];
    new_virtual_product = Product([virtual_product.reviews(:,1);new_review(:,1)],[virtual_product.reviews(:,2);new_review(:,2)],[virtual_product.reviews(:,3);new_review(:,3)]);
    virtual_product = new_virtual_product;
end
virtual_ratings = virtual_product.reviews(2:real_products_in_total,1);
% plot(1:real_products_in_total-1, transpose(virtual_ratings),'*')
virtual_ratings_freq = [sum(virtual_ratings(:) <= 1);sum(virtual_ratings(:) == 2);sum(virtual_ratings(:) == 3);sum(virtual_ratings(:) == 4);sum(virtual_ratings(:) >= 5)];
real_ratings_freq = [sum(star_rating(:) <= 1);sum(star_rating(:) == 2);sum(star_rating(:) == 3);sum(star_rating(:) == 4);sum(star_rating(:) >= 5)];
bar([virtual_ratings_freq,real_ratings_freq])
legend('virtual ratings','real ratings')
xlabel('stars')
ylabel('numbers')