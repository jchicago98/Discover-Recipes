import XCTest
@testable import discover_recipes

final class discover_recipesTests: XCTestCase {

    func testFetchMeals() {
        let expectation = XCTestExpectation(description: "Fetch meals")
        
        let contentView = ContentView()

        contentView.onAppear()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertTrue(contentView.meals.isEmpty, "Meals array should be empty after fetching")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }


    func testFetchRecipeInfo() {
        let expectation = XCTestExpectation(description: "Fetch recipe info")
        
        let meal = Meal(idMeal: "your_test_meal_id", strMeal: "Test Meal", strMealThumb: "test_image_url")
        let recipeDetailView = RecipeDetailView(recipe: meal)
        
        recipeDetailView.fetchRecipeInfo()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertNil(recipeDetailView.recipeInfo, "Recipe info should be nil after fetching")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }

    func testFilteredRecipeInfo() {
        let recipeInfo = RecipeInfo(
            idMeal: "1",
            strInstructions: "Test instructions",
            strIngredient1: "Ingredient 1",
            strIngredient2: "Ingredient 2",
            strIngredient3: "",
            strIngredient4: "Ingredient 4",
            strIngredient5: "",
            strIngredient6: nil,
            strIngredient7: nil,
            strIngredient8: nil,
            strIngredient9: nil,
            strIngredient10: nil,
            strIngredient11: nil,
            strIngredient12: nil,
            strIngredient13: nil,
            strIngredient14: nil,
            strIngredient15: nil,
            strIngredient16: nil,
            strIngredient17: nil,
            strIngredient18: nil,
            strIngredient19: nil,
            strIngredient20: nil,
            strMeasure1: "Measurement 1",
            strMeasure2: "Measurement 2",
            strMeasure3: "",
            strMeasure4: "Measurement 4",
            strMeasure5: "",
            strMeasure6: nil,
            strMeasure7: nil,
            strMeasure8: nil,
            strMeasure9: nil,
            strMeasure10: nil,
            strMeasure11: nil,
            strMeasure12: nil,
            strMeasure13: nil,
            strMeasure14: nil,
            strMeasure15: nil,
            strMeasure16: nil,
            strMeasure17: nil,
            strMeasure18: nil,
            strMeasure19: nil,
            strMeasure20: nil
        )
        
        let filteredRecipeInfo = recipeInfo.filteredRecipeInfo()
        
        XCTAssertEqual(filteredRecipeInfo.ingredients.count, 3, "Filtered ingredients count should be 3")
        XCTAssertEqual(filteredRecipeInfo.measurements.count, 3, "Filtered measurements count should be 3")
        XCTAssertEqual(filteredRecipeInfo.ingredients[0], "Ingredient 1", "Filtered ingredient 0 should be 'Ingredient 1'")
        XCTAssertEqual(filteredRecipeInfo.measurements[0], "Measurement 1", "Filtered measurement 0 should be 'Measurement 1'")
        XCTAssertEqual(filteredRecipeInfo.ingredients[1], "Ingredient 2", "Filtered ingredient 1 should be 'Ingredient 2'")
        XCTAssertEqual(filteredRecipeInfo.measurements[1], "Measurement 2", "Filtered measurement 1 should be 'Measurement 2'")
        XCTAssertEqual(filteredRecipeInfo.ingredients[2], "Ingredient 4", "Filtered ingredient 2 should be 'Ingredient 4'")
        XCTAssertEqual(filteredRecipeInfo.measurements[2], "Measurement 4", "Filtered measurement 2 should be 'Measurement 4'")
    }

    static var allTests = [
        ("testFetchMeals", testFetchMeals),
        ("testFetchRecipeInfo", testFetchRecipeInfo),
        ("testFilteredRecipeInfo", testFilteredRecipeInfo),
    ]
}
