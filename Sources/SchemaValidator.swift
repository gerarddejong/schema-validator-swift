
protocol SchemaValidator {
    func validate(instance: Any) -> (isValid: Bool, message: String)
}
