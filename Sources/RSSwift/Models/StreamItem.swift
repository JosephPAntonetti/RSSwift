import Foundation

public struct StreamItem {

    public let id : String
    public let title : String
    public let published : Date?
    public let updated : Date?
    public let summary : String?
    public let author : String?
    public let canonical : URL?
    public let read : Bool
    public let starred : Bool
    public let subscriptionId : String?

}