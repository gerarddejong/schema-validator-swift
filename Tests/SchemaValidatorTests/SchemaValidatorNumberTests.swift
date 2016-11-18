import XCTest
@testable import SchemaValidator

class SchemaValidatorNumberTests: XCTestCase {
    private var validator = JSONSchemaValidator()

    func testNumberValidation()  {
        validator.setSchema(schema: "{ \"type\": \"number\", \"multipleOf\": 1.0 }")
        XCTAssertTrue(validator.validate(instance: 42).isValid)
        XCTAssertTrue(validator.validate(instance: -1).isValid)
        XCTAssertTrue(validator.validate(instance: 5.0).isValid)
        XCTAssertTrue(validator.validate(instance: 2.99792458e8).isValid)
        XCTAssertFalse(validator.validate(instance: "42").isValid)
    }

    func testNumberIntegerValidation()  {
        validator.setSchema(schema: "{\"type\": \"integer\"}")
        XCTAssertTrue(validator.validate(instance: 42).isValid)
        XCTAssertTrue(validator.validate(instance: -1).isValid)
        XCTAssertFalse(validator.validate(instance: 3.1415926).isValid)
        XCTAssertFalse(validator.validate(instance: "42").isValid)
    }

    func testNumberMultiplesValidation()  {
        validator.setSchema(schema: "{\"type\": \"number\", \"multipleOf\": 10 }")
        XCTAssertTrue(validator.validate(instance: 0).isValid)
        XCTAssertTrue(validator.validate(instance: 10).isValid)
        XCTAssertTrue(validator.validate(instance: 20).isValid)
        XCTAssertFalse(validator.validate(instance: 23).isValid)
    }

    func testNumberRangeValidation()  {
        validator.setSchema(schema: "{\"type\": \"number\", \"minimum\": 0, \"maximum\": 100, \"exclusiveMaximum\": true}")
        XCTAssertFalse(validator.validate(instance: -1).isValid)
        XCTAssertTrue(validator.validate(instance: 0).isValid)
        XCTAssertTrue(validator.validate(instance: 10).isValid)
        XCTAssertTrue(validator.validate(instance: 99).isValid)
        XCTAssertFalse(validator.validate(instance: 100).isValid)
        XCTAssertFalse(validator.validate(instance: 101).isValid)
    }

    static var allTests : [(String, (SchemaValidatorNumberTests) -> () throws -> Void)] {
        return [
            ("testNumberValidation", testNumberValidation),
            ("testNumberMultiplesValidation", testNumberMultiplesValidation),
            ("testNumberRangeValidation", testNumberRangeValidation)
        ]
    }
}
