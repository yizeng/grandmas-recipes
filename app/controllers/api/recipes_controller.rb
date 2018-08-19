module Api
  class RecipesController < ApiController
    before_action :set_recipe, only: %i[show update destroy]
    skip_before_action :verify_authenticity_token

    def index
      @recipes = Recipe.all
      json_response(@recipes)
    end

    def show
      json_response(@recipe)
    end

    def create
      @recipe = Recipe.create!(recipe_params)
      json_response(@recipe, :created)
    end

    def update
      @recipe.update!(recipe_params)
      head :no_content
    end

    def destroy
      @recipe.destroy
      head :no_content
    end

    private

    def recipe_params
      params.permit(:title, :steps, :ingredients, :description)
    end

    def set_recipe
      @recipe = Recipe.find(params[:id])
    end
  end
end
