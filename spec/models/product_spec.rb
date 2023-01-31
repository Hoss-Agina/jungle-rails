require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    # validation tests/examples here
    it "is valid" do
      @category = Category.new
      @category.name = 'categ-name'
      @product = Product.new(name: "myProductName", price: 500, quantity: 5, category: @category)
      @product.save
      expect(@product.valid?).to be true
    end

    it "verifies name must exist and gives error if its nil" do
      @category = Category.new
      @category.name = 'categ-name'
      @product = Product.new(name: nil, price: 500, quantity: 5, category: @category)
      @product.save
      expect(@product.errors[:name]).to  include("can't be blank")
    end

    it "verifies price must exist  and gives error if its nil" do
      @category = Category.new
      @category.name = 'categ-name'
      @product = Product.new(name: "new-prod", price_cents: nil, quantity: 5, category: @category)
      @product.save
      expect(@product.errors[:price]).to  include("can't be blank")
    end

    it "verifies quantity exists  and gives error if its nil " do
      @category = Category.new
      @category.name = 'categ-name'
      @product = Product.new(name: "hoss", price: 500, quantity: nil, category: @category)
      @product.save
      expect(@product.errors[:quantity]).to  include("can't be blank")
    end

    it "verifies category exists  and gives error if its nil" do
      @category = Category.new
      @category.name = 'categ-name'
      @product = Product.new(name: "hoss", price: 600, quantity: 5, category: nil)
      @product.save
      expect(@product.errors[:category]).to  include("can't be blank")
    end

  end
end
