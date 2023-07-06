import Foundation

public protocol PersonStoreDelegate: AnyObject {
    func personStore(_ personStore: PersonStore,
                     didAddPerson person: Person)
}

public class PersonStore {
    public private(set) var persons: [Person]
    
    public weak var delegate: PersonStoreDelegate?
    
    public typealias DidAddPersonHandler = (_ person: Person) -> Void
    private var didAddPersonHandler: DidAddPersonHandler?
    
    public init(persons: [Person]) {
        self.persons = persons
    }
}

public extension PersonStore {
    func resetPersons() {
        persons = .init()
    }
    
    func add(person: Person) {
        persons.append(person)
        
        didAddPersonHandler?(person)
        
        delegate?.personStore(self,
                              didAddPerson: person)
    }
    
    convenience init() {
        self.init(persons: .init())
    }
    
    func setDidAddPersonHandler(_ handler: DidAddPersonHandler?) {
        didAddPersonHandler = handler
    }
}
