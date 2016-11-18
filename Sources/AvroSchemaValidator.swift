import Foundation

class AvroSchemaValidator: SchemaValidator {
    private var AvroSchema = [String: Any]()
    
    func setSchema(schema: String) {

    }

    func validate(instance: Any) -> (isValid: Bool, message: String) {
        return (false, "Failed to identify type to validate.")
    }
}