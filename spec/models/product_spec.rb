require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do 
    it 'should create a valid product when all fields are filled in properly' do
      @category = Category.new(name: "Tests")
      @product = Product.new(name: "Lighthouse Guide", price_cents: 9999, quantity: 99, :category => @category)
      expect(@product.valid?).to be true
    end 

    it 'should prevent a product from being made if the name field is empty' do
      @category = Category.new(name: "Tests")
      @product = Product.new(price_cents: 9999, quantity: 99, :category => @category)
      @product.valid?
    expect(@product.errors[:name]).to include("can\'t be blank")
    end

    it 'should prevent a product from being made if the price field is empty' do
      @category = Category.new(name: "Tests")
      @product = Product.new(name: "Lighthouse Guide", quantity: 99, :category => @category)
      @product.valid?
      expect(@product.errors[:price]).to include("is not a number")
    end 

    it 'should prevent a product from being made if the quantity is blank' do
      @category = Category.new(name: "Tests")
      @product = Product.new(name: "Lighthouse Guide", price_cents: 9999, :category => @category)
      @product.valid?
      expect(@product.errors[:quantity]).to include("can\'t be blank")
    end 

    it 'should prevent a product from being made if the category field is empty' do
      @category = Category.new(name: "Tests")
      @product = Product.new(name: "Lighthouse Guide", price_cents: 9999, quantity: 99)
      @product.valid?
      expect(@product.errors[:category]).to include("can\'t be blank")
    end 
  end 
end
