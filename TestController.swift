import Foundation

class TestController {
    let store = PersonStore()
    var isDebugLoggingEnabled = false
    
    init() {
        store.delegate = self
        
        store.setDidAddPersonHandler { [weak self] person in
            guard let self else { return }
            
            self.printPersonWasAdded(person)
        }
    }
    
    func runTest() {
        guard let felix = try? Person(firstName: "Felix",
                                      lastName: "Deimel") else {
            fatalError()
        }
        
        store.add(person: felix)
        
        guard var dorin = try? Person(firstName: "Dorin",
                                      lastName: "Andreica") else {
            fatalError("Person could not be created")
        }
        
        dorin.growUp(byYears: 5)
        dorin.growUp(byMonths: 2)
        dorin.growUp(8)
        
        store.add(person: dorin)
        
        let sortedPerson = store.persons.sorted(by: {
            let options: String.CompareOptions = [
                .caseInsensitive,
                .backwards ]
            
            let firstNameResult = $0.firstName.compare($1.firstName, options: options)
            
            if firstNameResult == .orderedSame {
                let lastNameResult = $0.lastName.compare($1.lastName, options: options)
                
                return lastNameResult == .orderedAscending
            } else {
                return firstNameResult == .orderedAscending
            }
        })
        
        for p in sortedPerson {
            print("Hello \(p.fullName)!")
        }
        
        do {
            let _ = try Person(firstName: "",
                               lastName: "")
        } catch let initError as Person.InitError {
            print("Non-persons are not persons: \(initError.localizedDescription)")
        } catch {
            
        }
    }
    
    deinit {
        print("Deinit TestController")
    }
    
    func testAutoclosure(_ textHandler: @autoclosure () -> String) {
        guard isDebugLoggingEnabled else {
            return
        }
        
        let text = textHandler()
        
        print(text)
    }
}

extension TestController: PersonStoreDelegate {
    func personStore(_ personStore: PersonStore,
                     didAddPerson person: Person) {
        printPersonWasAdded(person)
    }
}

private extension TestController {
    func printPersonWasAdded(_ person: Person) {
        print("\(person.fullName) was added to store")
    }
}
