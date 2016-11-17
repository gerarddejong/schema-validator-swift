import Foundation

class JSONSchemaValidator: SchemaValidator {
    private var JSONSchema =  [String: Any]()
    
    func setSchema(schema: String) {
        JSONSchema = try! JSONSerialization.jsonObject(with: schema.data(using: .utf8)!) as! [String: Any]
        
        // resolve links to subschemas here... "$ref": "#definitions/schema"
    }
    
    func validate(instance: Any) -> (isValid: Bool, message: String) {
        if let type = JSONSchema["type"] as? String {
            if type == "string" {
                return validateString(instance: instance)
            }
            if type == "number" {
                return validateString(instance: instance)
            }
        }
        
        return (false, "Foo")
    }
    
    func validateString(instance: Any) -> (isValid: Bool, message: String) {
        if let stringInstance = instance as? String {
            if let minimumLength = JSONSchema["minLength"] as? Int {
                if(stringInstance.characters.count < minimumLength) {
                    return (false, "Must be more than \(minimumLength) characters in length.")
                }
            }
            
            if let maximumLength = JSONSchema["maxLength"] as? Int {
                if(stringInstance.characters.count > maximumLength) {
                    return (false, "Must be less than \(maximumLength) characters in length.")
                }
            }
            
            return (true, "Okay.")
        }
        return (false, "Not of type string.")
    }
}
