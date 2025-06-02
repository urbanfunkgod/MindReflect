//
//  StringArrayTransformer.swift
//  MindReflect
//
//  Created by Johann Flores on 5/13/25.
//
import Foundation

@objc(StringArrayTransformer)
class StringArrayTransformer: NSSecureUnarchiveFromDataTransformer {
    override class func transformedValueClass() -> AnyClass {
        return NSArray.self
    }
    
    override class func allowsReverseTransformation() -> Bool {
        return true
    }
    
    override func transformedValue(_ value: Any?) -> Any? {
        guard let data = value as? Data else {
            print("StringArrayTransformer: Failed to transform value - data is nil or not Data type")
            return nil
        }
        do {
            let array = try NSKeyedUnarchiver.unarchivedObject(ofClasses: [NSArray.self, NSString.self], from: data)
            return array
        } catch {
            print("StringArrayTransformer: Failed to unarchive string array: \(error)")
            return nil
        }
    }
    
    override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let array = value as? [String] else {
            print("StringArrayTransformer: Failed to reverse transform value - value is nil or not [String]")
            return nil
        }
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: array, requiringSecureCoding: true)
            return data
        } catch {
            print("StringArrayTransformer: Failed to archive string array: \(error)")
            return nil
        }
    }
}

// Register the transformer
extension StringArrayTransformer {
    static func register() {
        let transformer = StringArrayTransformer()
        ValueTransformer.setValueTransformer(transformer, forName: NSValueTransformerName(rawValue: "StringArrayTransformer"))
    }
}
