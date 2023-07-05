import Foundation

var testController: TestController? = TestController()
testController?.runTest()
testController?.isDebugLoggingEnabled = true
testController?.testAutoclosure("Today is: \(Date())")
testController = nil
