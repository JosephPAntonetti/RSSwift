import Foundation

public struct Subscription {

    public let id : String
    public let title : String
    public let sortID: String
    public let latestItemTimestamp : Date?
    public let url : URL?
    public let iconUrl : URL?
    public let categories : [Category]

}