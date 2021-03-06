require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products

  test "product attributes must not be empty" do 
  	product = Product.new
  	assert product.invalid?
  	assert product.errors[:name].any?
  	assert product.errors[:description].any?
  	assert product.errors[:price].any?
  end

  test "product price must be positive" do 
  	product = Product.new(name: "Sawz-all",
  						  description: "an electrical saw",
  						  image_url: "szall.jpg")
  	product.price = -1
  	assert product.invalid?
  	assert_equal ["must be greater than or equal to 0.01"],
  		product.errors[:price]

  	product.price = 0
  	assert product.invalid?
  	assert_equal ["must be greater than or equal to 0.01"],
  		product.errors[:price]

  	product.price = 1
  	assert product.valid?
  end

  def new_product(image_url)
  	Product.new(name: 	"sawz-all",
  				description:  "electrical saw",
  				price: 	  100.00,
  				image_url: image_url)
  end

  test "image url" do 
  	ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.jpg
  			  http://a.b.c/x/y/z/fred.gif }
  	bad = %w{ fred.doc fred.gif/more fred.gif.more }

  	ok.each do |name|
  		assert new_product(name).valid?, "#{name} shouldn't be invalid"
  	end

  	bad.each do |name| 
  		assert new_product(name).invalid?, "#{name} shouldn't be valid"
  	end
  end

  test "product is not valid without a unique title" do 
  	product = Product.new(name:  products(:hammer).name,
  						  description: "yyy",
  						  price:  1,
  						  image_url: "hammer.gif")
  	assert product.invalid?
  	assert_equal ["has already been taken"], product.errors[:name]
  end

end
