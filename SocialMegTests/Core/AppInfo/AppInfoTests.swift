import XCTest
@testable import SocialMeg

final class AppInfoTests: XCTestCase {
    private var sut: AppInfo!
    private var resourceLoader: StubAppInfoResourceLoader!
    
    
    override func tearDown() {
        super.tearDown()
        resourceLoader = nil
    }
    
    func test_whenHostFound_thenReturnUrl() throws {
        // Given
        let assertUrl = "https://rmenezes.me"
        
        resourceLoader = StubAppInfoResourceLoader(.hostFound)
        sut = AppInfo(resourceLoader: resourceLoader)
        
        // When
        let url = try XCTUnwrap(sut.host)
        
        // Then
        XCTAssertEqual(url, assertUrl)
        XCTAssertEqual(resourceLoader.loadInfoCallsCount, 1)
    }
    
    func test_whenHostNotFound_thenReturnNil() {
        // Given
        resourceLoader = StubAppInfoResourceLoader(.noHostKeyFound)
        sut = AppInfo(resourceLoader: resourceLoader)
        
        // Then
        XCTAssertNil(sut.host)
        XCTAssertEqual(resourceLoader.loadInfoCallsCount, 1)
    }
}
