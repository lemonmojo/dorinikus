import Foundation

struct Person {
    let firstName: String
    let lastName: String
    private(set) var age: UInt
    
    init(firstName: String,
         lastName: String) throws {
        guard !firstName.isEmpty ||
              !lastName.isEmpty else {
            throw InitError.emptyNames
        }
        
        self.firstName = firstName
        self.lastName = lastName
        self.age = 0
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

extension Person {
    enum InitError: Error {
        case emptyNames
    }
}

// MARK: - Localize that Error!
extension Person.InitError: LocalizedError {
    var errorDescription: String? {
        switch self {
            case .emptyNames:
                return "Either first or last name was not provided"
        }
    }
}
