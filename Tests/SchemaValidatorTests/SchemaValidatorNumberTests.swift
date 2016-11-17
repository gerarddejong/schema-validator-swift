import XCTest
@testable import SchemaValidator

class SchemaValidatorNumberTests: XCTestCase {
    private var validator = JSONSchemaValidator()
    
    func testNumberValidation()  {
        XCTAssertTrue(true)
    }

    static var allTests : [(String, (SchemaValidatorNumberTests) -> () throws -> Void)] {
        return [
            ("testNumberValidation", testNumberValidation)
        ]
    }
}
