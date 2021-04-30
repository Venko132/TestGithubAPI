//
//  GMProtocols.swift
//  GithubMessanger
//
//  Created by Dream Store on 29.04.2021.
//

import Foundation

//MARK:- NSObject
extension NSObject {
    open class var kIdentifier: String  {
        get {
            return String(describing: self)
        }
    }
    
    public var nameOfClass: String {
        return NSStringFromClass(type(of: self)).components(separatedBy: ".").last!
    }
}

//MARK:- String
extension String {
    func notificationName() -> NSNotification.Name {
        return NSNotification.Name.init(self)
    }
}

//MARK: GMError
struct GMError: Error {
    var localizedDescription: String = "Something went wrong."
}

//MARK: GMProtocolActionInCell
protocol GMProtocolActionInCell: class {
    func actionUserPressSender(_ sender: AnyObject)
}

extension GMProtocolActionInCell{
    func actionUserPressSender(_ sender: AnyObject) {}
}

//MARK: GMProtocolFetchContent
protocol GMProtocolFetchContent: class {
    func toLoadNewData()
}

extension GMProtocolFetchContent{
    func toLoadNewData() {}
}

//MARK: GMProtocolProgress
protocol GMProtocolProgress: class {
    func startProgress()
    func endProgress()
}

extension GMProtocolProgress {
    func startProgress() {}
    func endProgress() {}
}
