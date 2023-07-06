import XCTest
import DorinikusSDK

final class PersonStoreTests: XCTestCase {
    func testReset() {
        let store = PersonStore(persons: [
            try! .init(firstName: "Felix", lastName: "Deimel")
        ])
        
        XCTAssertEqual(store.persons.count, 1)
        
        store.resetPersons()
        
        XCTAssertEqual(store.persons.count, 0)
        
        XCTAssertThrowsError(try Person(firstName: "",
                                        lastName: ""))
        
        let person: Person
        
        do {
            try person = .init(firstName: "a",
                               lastName: "b")
        } catch {
            XCTFail()
            
            return
        }
        
        let exp = expectation(description: "Handler was called")
        
        store.setDidAddPersonHandler { innerPerson in
            XCTAssertEqual(person, innerPerson)
            
            exp.fulfill()
        }
        
        let expDelegate = expectation(description: "Delegate was called")
        
        var del: TestPersonStoreDelegate? = TestPersonStoreDelegate(expectation: expDelegate)
        defer { del = nil }
        
        store.delegate = del
        
        store.add(person: person)
        
        wait(for: [ exp, expDelegate ], timeout: 0.5)
    }
}

extension PersonStoreTests {
    class TestPersonStoreDelegate: PersonStoreDelegate {
        private let ex: XCTestExpectation
        
        init(expectation: XCTestExpectation) {
            self.ex = expectation
        }
        
        func personStore(_ personStore: PersonStore,
                         didAddPerson person: Person) {
            ex.fulfill()
        }
    }
}
