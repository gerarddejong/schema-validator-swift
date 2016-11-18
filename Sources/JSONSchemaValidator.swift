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
            if type == "integer" {
                return validateInteger(instance: instance)
            }
            if type == "number" {
                return validateDouble(instance: instance)
            }
        }
        
        return (false, "Failed to identify type to validate.")
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

    func validateInteger(instance: Any) -> (isValid: Bool, message: String) {
        if let integerInstance = instance as? Int {
            if let multiple = JSONSchema["multipleOf"] as? Int {
                if integerInstance % multiple != 0 {
                    return (false, "Not multiple of \(multiple).")
                }
            }

            if let minimum = JSONSchema["minimum"] as? Int {
                if let exclusiveMinimum = JSONSchema["exclusiveMinimum"] as? Bool {
                    if exclusiveMinimum {
                        if integerInstance <= minimum {
                            return (false, "Must be more than \(minimum).")
                        }
                    }
                }
                else {
                    if integerInstance < minimum {
                        return (false, "Must be more than \(minimum).")
                    }   
                }
            }
            
            if let maximum = JSONSchema["maximum"] as? Int {
                if let exclusiveMaximum = JSONSchema["exclusiveMaximum"] as? Bool {
                    if exclusiveMaximum {
                        if integerInstance >= maximum {
                            return (false, "Must be more than \(maximum).")
                        }
                    }
                }
                else {
                    if integerInstance > maximum {
                        return (false, "Must be less than \(maximum).")
                    }
                }
            }

            return (true, "Okay \(integerInstance).")
        }
        
        return (false, "Not of type integer.")
    }

    func validateDouble(instance: Any) -> (isValid: Bool, message: String) {
        if let integerInstance = instance as? Int {
            if let multiple = JSONSchema["multipleOf"] as? Int {
                if integerInstance % multiple != 0 {
                    return (false, "Not multiple of \(multiple).")
                }
            }

            if let minimum = JSONSchema["minimum"] as? Int {
                if let exclusiveMinimum = JSONSchema["exclusiveMinimum"] as? Bool {
                    if exclusiveMinimum {
                        if integerInstance <= minimum {
                            return (false, "Must be more than \(minimum).")
                        }
                    }
                }
                else {
                    if integerInstance < minimum {
                        return (false, "Must be more than \(minimum).")
                    }   
                }
            }
            
            if let maximum = JSONSchema["maximum"] as? Int {
                if let exclusiveMaximum = JSONSchema["exclusiveMaximum"] as? Bool {
                    if exclusiveMaximum {
                        if integerInstance >= maximum {
                            return (false, "Must be more than \(maximum).")
                        }
                    }
                }
                else {
                    if integerInstance > maximum {
                        return (false, "Must be less than \(maximum).")
                    }
                }
            }

            return (true, "Okay \(integerInstance).")
        }
        
        if let doubleInstance = instance as? Double {
            return (true, "Okay \(doubleInstance).")
        }
        
        return (false, "Not of type number.")
    }
    
}
