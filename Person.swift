import Foundation

public struct Person: Animal, Equatable {
    public static let species = "Human"
    
    public let firstName: String
    public let lastName: String
    public private(set) var age: UInt
    
    public init(firstName: String,
                lastName: String) throws {
        guard !firstName.isEmpty,
              !lastName.isEmpty else {
            throw InitError.emptyNames
        }
        
        self.firstName = firstName
        self.lastName = lastName
        self.age = 0
    }
}

public extension Person {
    enum InitError: Error {
        case emptyNames
    }
    
    var fullName: String {
        "\(firstName) \(lastName)"
    }
    
    mutating func growUp(byYears yearsToAdd: UInt) {
        age += yearsToAdd
    }
    
    mutating func growUp(byMonths: UInt) {
        age += byMonths
    }
    
    mutating func growUp(_ byMonths: UInt) {
        age += byMonths
    }
}

// MARK: - Localize that Error!
extension Person.InitError: LocalizedError {
    public var errorDescription: String? {
        switch self {
            case .emptyNames:
                return "Either first or last name was not provided"
        }
    }
}
