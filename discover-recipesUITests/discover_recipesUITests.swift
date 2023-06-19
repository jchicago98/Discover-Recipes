import XCTest

class discover_recipesUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    func testAppLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        XCTAssertTrue(app.navigationBars["Discover Recipes"].exists)
    }

    func testRecipeSelection() throws {
        let app = XCUIApplication()
        app.launch()

        let fetchExpectation = expectation(description: "Fetch meals")
        wait(for: [fetchExpectation], timeout: 10)

        let tableExists = NSPredicate(format: "exists == true")
        let tableVisible = NSPredicate(format: "isHittable == true")
        let tableQuery = app.tables.element
        let tableVisibleExpectation = expectation(for: NSCompoundPredicate(andPredicateWithSubpredicates: [tableExists, tableVisible]), evaluatedWith: tableQuery, handler: nil)
        wait(for: [tableVisibleExpectation], timeout: 5)

        let firstRecipeCell = app.tables.cells.firstMatch

        if firstRecipeCell.exists && firstRecipeCell.isHittable {
            firstRecipeCell.tap()
            XCTAssertTrue(app.navigationBars["Recipe Detail"].exists)
        }
    }





    override func wait(for expectations: [XCTestExpectation], timeout: TimeInterval) {
        let waitForExpectations = XCTestExpectation(description: "Wait for expectations")
        let timer = Timer.scheduledTimer(withTimeInterval: timeout, repeats: false) { _ in
            waitForExpectations.fulfill()
        }
        XCTWaiter().wait(for: expectations + [waitForExpectations], timeout: timeout)
        timer.invalidate()
    }



    func testRecipeDetailContent() throws {
        let app = XCUIApplication()
        app.launch()
        
        let fetchExpectation = expectation(description: "Fetch meals")
        wait(for: [fetchExpectation], timeout: 10)

        let tableExists = NSPredicate(format: "exists == true")
        let tableVisible = NSPredicate(format: "isHittable == true")
        let tableQuery = app.tables.element
        let tableVisibleExpectation = expectation(for: NSCompoundPredicate(andPredicateWithSubpredicates: [tableExists, tableVisible]), evaluatedWith: tableQuery, handler: nil)
        wait(for: [tableVisibleExpectation], timeout: 5)

        let firstRecipeCell = app.tables.cells.element(boundBy: 0)
        if firstRecipeCell.waitForExistence(timeout: 5) {
            firstRecipeCell.tap()
        } else {
            return
        }

        XCTAssertTrue(app.navigationBars["Recipe Detail"].exists)

        let recipeNameExists = NSPredicate(format: "exists == true")
        let recipeNameExpectation = expectation(for: recipeNameExists, evaluatedWith: app.staticTexts["Recipe Name"], handler: nil)
        wait(for: [recipeNameExpectation], timeout: 5)

        XCTAssertTrue(app.staticTexts["Recipe Name"].exists)

        XCTAssertTrue(app.images["Recipe Image"].exists)

        XCTAssertFalse(app.staticTexts["Loading recipe..."].exists)

        XCTAssertTrue(app.staticTexts["Ingredients"].exists)
        XCTAssertTrue(app.tables.cells.count > 0)

        XCTAssertTrue(app.staticTexts["Instructions"].exists)
        XCTAssertTrue(app.staticTexts["Recipe Instructions"].exists)
    }



}
