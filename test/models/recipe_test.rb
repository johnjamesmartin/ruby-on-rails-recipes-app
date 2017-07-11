require 'test_helper'

class RecipeTest < ActiveSupport::TestCase

    def setup
        @chef = Chef.create!(chefname: "mashrur", email: "mashrur@example.com", password: "password", password_confirmation: "password")
        @recipe = @chef.recipes.build(name: "vegetable", description: "great vegetable recipe")
    end


    # 0. Our newly implemented one-to-many relationship means a recipe must have a chef!

    test "recipe without chef should be invalid" do
        @recipe.chef_id = nil
        assert_not @recipe.valid?
    end


    # 1. Use ActiveRecord assertion to check that the recipe is valid:

    test "recipe should be valid" do
        assert @recipe.valid?
    end


    # 2. " " check that the recipe has a name:

    test "name should be present" do
        @recipe.name = " "
        assert_not @recipe.valid?
    end


    # 3. " " check that the recipe has a description:

    test "description should be present" do
        @recipe.description = " "
        assert_not @recipe.valid?
    end


    # 4. " " check that the description has less than 5 characters:

    test "description shouldn't be less than 5 characters" do
        @recipe.description = "a" * 3
        assert_not @recipe.valid?
    end


    # 5. " " check that the description does not exceed 500 characters:

    test "description shouldn't be more than 500 characters" do
        @recipe.description = "a" * 501
        assert_not @recipe.valid?
    end

end