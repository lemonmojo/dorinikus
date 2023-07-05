import Foundation

protocol PersonStoreDelegate: AnyObject {
    func personStore(_ personStore: PersonStore,
                     didAddPerson person: Person)
}

class PersonStore {
    private(set) var persons: [Person]
    
    weak var delegate: PersonStoreDelegate?
    
    typealias DidAddPersonHandler = (_ person: Person) -> Void
    private var didAddPersonHandler: DidAddPersonHandler?
    
    func setDidAddPersonHandler(_ handler: DidAddPersonHandler?) {
        didAddPersonHandler = handler
    }
    
    init(persons: [Person]) {
        self.persons = persons
    }
    
    convenience init() {
        self.init(persons: .init())
    }
    
    func resetPersons() {
        persons = .init()
    }
    
    func add(person: Person) {
        persons.append(person)
        
        didAddPersonHandler?(person)
        
        delegate?.personStore(self,
                              didAddPerson: person)
    }
}
