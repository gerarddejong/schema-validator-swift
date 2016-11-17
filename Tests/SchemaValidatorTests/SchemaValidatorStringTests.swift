import XCTest
@testable import SchemaValidator

class SchemaValidatorStringTests: XCTestCase {
    private var validator = JSONSchemaValidator()
    
    func testStringValidation()  {
        validator.setSchema(schema: "{\"type\": \"string\"}")
        XCTAssertTrue(validator.validate(instance: "This is a string").isValid)
        XCTAssertTrue(validator.validate(instance: "Déjà vu").isValid)
        XCTAssertTrue(validator.validate(instance: "42").isValid)
        XCTAssertFalse(validator.validate(instance: 42).isValid)
    }

    func testStringLengthValidation() {
        validator.setSchema(schema: "{\"type\": \"string\", \"minLength\": 2, \"maxLength\": 3}")
        XCTAssertFalse(validator.validate(instance: "A").isValid)
        XCTAssertTrue(validator.validate(instance: "AB").isValid)
        XCTAssertTrue(validator.validate(instance: "ABC").isValid)
        XCTAssertFalse(validator.validate(instance: "ABCD").isValid)
    }
    
//    func testStringRegularExpressionValidation () {
//        let pattern = "^(\\([0-9]{3}\\))?[0-9]{3}-[0-9]{4}$"
//        //let pattern = "[A-Z]+"
//        
//        print(pattern)
//        print("{\"type\": \"string\", \"pattern\": \"\(pattern)\"}")
//        
//        validator.setSchema(schema: "{\"type\": \"string\", \"pattern\": \"\(pattern)\"}")
//        XCTAssertTrue(validator.validate(instance: "555-1212").isValid)
//        XCTAssertTrue(validator.validate(instance: "(888)555-1212").isValid)
//        XCTAssertFalse(validator.validate(instance: "(888)555-1212 ext. 532").isValid)
//        XCTAssertFalse(validator.validate(instance: "(800)FLOWERS").isValid)
//    }
    
    static var allTests : [(String, (SchemaValidatorStringTests) -> () throws -> Void)] {
        return [
            ("testStringValidation", testStringValidation),
            ("testStringLengthValidation", testStringLengthValidation)//,
//            ("testStringRegularExpressionValidation", testStringRegularExpressionValidation)
        ]
    }
}
