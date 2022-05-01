//
//  ViewControllerTests.swift
//  CurrencyExchangerTests
//
//  Created by Mohsen Khosravinia on 4/26/22.
//

@testable import TestExamples
import XCTest

class NavigationControllerTests: XCTestCase {
    
    func test_navigationController_exists() {
        let sut = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "NavigationController")
        XCTAssertNotNil(sut)
    }
}
		
class ViewControllerTests: XCTestCase {

    // Given When Then -> GWT
    // Arrange Act Assert -> AAA
    
    var sut: ViewController!
    
    override func setUp() {
        super.setUp()
        
        sut = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ViewController")
    }
    
    override func tearDown() {
        sut = nil
        
        super.tearDown()
    }
    
    func test_backgroundColor_isRed() {
        XCTAssertEqual(sut.view.backgroundColor, .red)
    }
    
    func test_navigationBar_isNotHidden() throws {
        let sut = makeViewControllerEmbeded()
        
        XCTAssertFalse(sut.navigationController!.isNavigationBarHidden)
    }
    
    func test_navigationBarSize_isLarge() {
        let sut = makeViewControllerEmbeded()
        
        XCTAssertTrue(sut.navigationController!.navigationBar.prefersLargeTitles)
    }
    
    func test_navigationBarTitle_renders() {
        let sut = makeViewControllerEmbeded()
        
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(sut.navigationItem.title, "Product")
    }
    
    // MARK: Factory
    
    private func makeViewControllerEmbeded() -> ViewController {
        let navigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "NavigationController") as! UINavigationController
        return navigationController.viewControllers.first as! ViewController
    }

}
