require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest
  
  def setup
    # Exploring different ways of creating:
    @chef = Chef.create!(chefname: "mashrur", email: "mashrur@example.com")
    @recipe = Recipe.create(name: "vegetable saute", description: "great vegetable sautee, add vegetable and oil", chef: @chef)
    @recipe2 = @chef.recipes.build(name: "chicken saute", description: "great chicken dish")
    @recipe2.save
  end

  # 1. Issue GET request to ~/recipes/ and assert response request:

  test "should get recipes index" do
    get recipes_path
    assert_response :success
  end


  # 2. GET recipes listing:

  test "should get recipes listing" do
    get recipes_path
    assert_template 'recipes/index'
    assert_match @recipe.name, response.body
    assert_match @recipe2.name, response.body
  end

end
