import XCTest

final class discover_recipesUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Verify the presence of the "Discover Recipes" navigation title
        XCTAssertTrue(app.navigationBars["Discover Recipes"].exists)

        // Optionally, you can add additional assertions to verify the initial state of the UI
        // For example, you can check if the list is empty initially or if specific UI elements exist

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }

    func testFetchMeals() throws {
        let app = XCUIApplication()
        app.launch()

        // Wait for the API request to complete
        sleep(2)

        // Verify that the list contains cells after fetching meals
        XCTAssert(app.cells.count > 0)

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Fetched Meals"
        attachment.lifetime = .keepAlways
        add(attachment)
    }

    func testNavigateToRecipeDetail() throws {
        let app = XCUIApplication()
        app.launch()

        // Replace sleep with a more robust waiting mechanism
        let recipeCell = app.cells.firstMatch
        // Wait for the first recipe cell to become hittable
        XCTAssertTrue(recipeCell.waitForExistence(timeout: 5))
        
        // Tap the first recipe cell
        recipeCell.tap()

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Recipe Detail Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }


    func testRecipeDetailContent() throws {
        let app = XCUIApplication()
        app.launch()

        // Replace sleep with a more robust waiting mechanism
        let recipeCell = app.cells.firstMatch
        // Wait for the first recipe cell to become hittable
        XCTAssertTrue(recipeCell.waitForExistence(timeout: 5))

        // Tap the first recipe cell
        recipeCell.tap()

        // Add additional assertions as needed to verify the content of the recipe detail view

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Recipe Detail Content"
        attachment.lifetime = .keepAlways
        add(attachment)
    }

}
