//
//  NSColorTests.swift
//  OutlawAppKit
//
//  Created by Brian Mullen on 12/17/16.
//  Copyright © 2016 Molbie LLC. All rights reserved.
//

#if os(macOS)
import XCTest
import Outlaw
import OutlawCoreGraphics
@testable import OutlawAppKit


class NSColorTests: XCTestCase {
    func testExtractableValue() {
        typealias keys = NSColor.ExtractableKeys
        
        let rawData: [String: CGFloat] = [keys.red: 0.1,
                                          keys.green: 0.2,
                                          keys.blue: 0.3,
                                          keys.alpha: 0.4]
        let data: [String: [String: CGFloat]] = ["color": rawData]
        let color: NSColor = try! data.value(for: "color")
        
        XCTAssertEqual(color.redComponent, rawData[keys.red])
        XCTAssertEqual(color.greenComponent, rawData[keys.green])
        XCTAssertEqual(color.blueComponent, rawData[keys.blue])
        XCTAssertEqual(color.alphaComponent, rawData[keys.alpha])
    }
    
    func testIndexExtractableValue() {
        let rawData: [CGFloat] = [0.1, 0.2, 0.3, 0.4]
        let data: [[CGFloat]] = [rawData]
        let color: NSColor = try! data.value(for: 0)
        
        XCTAssertEqual(color.redComponent, rawData[0])
        XCTAssertEqual(color.greenComponent, rawData[1])
        XCTAssertEqual(color.blueComponent, rawData[2])
        XCTAssertEqual(color.alphaComponent, rawData[3])
    }
    
    func testInvalidValue() {
        let rawData: String = "Hello, Outlaw!"
        let data: [String] = [rawData]
        
        let ex = self.expectation(description: "Invalid data")
        do {
            let _: CGAffineTransform = try data.value(for: 0)
        }
        catch {
            if case OutlawError.typeMismatchWithIndex = error {
                ex.fulfill()
            }
        }
        self.waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testSerializable() {
        typealias keys = NSColor.ExtractableKeys
        
        let color = NSColor(deviceRed: 0.1, green: 0.2, blue: 0.3, alpha: 0.4)
        let data: [String: CGFloat] = color.serialized()
        
        XCTAssertEqual(data[keys.red], color.redComponent)
        XCTAssertEqual(data[keys.green], color.greenComponent)
        XCTAssertEqual(data[keys.blue], color.blueComponent)
        XCTAssertEqual(data[keys.alpha], color.alphaComponent)
    }
}
#endif
