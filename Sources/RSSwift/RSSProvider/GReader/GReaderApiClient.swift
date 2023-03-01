import Foundation

public class GReaderApiClient {

  typealias ApiResponse<T: Decodable> = Result<T, HttpError>

  private let baseURL: String
  private let headers: [String: String]

  public init(
    baseURL: String,
    headers: [String: String]
  ) {
    self.baseURL = baseURL
    self.headers = headers
  }

  public func getItemsForStream(
    id: String,
    count: Int? = nil,
    order: String? = nil,
    startTime: Int? = nil,
    excludeTarget: String? = nil,
    includeTarget: String? = nil,
    continuation: String? = nil
  ) async
    -> GReaderStreamContents?
  {
    let route =
      "\(baseURL)/stream/contents/\(id.urlEncode())"

    let queryItems = buildQueryItems(
      count: count,
      order: order,
      startTime: startTime,
      excludeTarget: excludeTarget,
      includeTarget: includeTarget,
      continuation: continuation
    )

    var url = URL(string: route)!
    url.append(queryItems: queryItems)

    let request = URLRequest(
      url: url,
      headers: headers
    )

    let response = await request.get(resultType: GReaderStreamContents.self)
    switch response {
    case .success(let result):
      return result
    case .failure:
      return nil
    }
  }

  public func getStreamItemIds(
    id: String,
    count: Int? = nil,
    order: String? = nil,
    startTime: Int? = nil,
    excludeTarget: String? = nil,
    includeTarget: String? = nil,
    continuation: String? = nil
  ) async
    -> GReaderStreamItemIds?
  {
    let route =
      "stream/items/ids"

    var url = URL(string: route)!
    var queryItems = buildQueryItems(
      count: count,
      order: order,
      startTime: startTime,
      excludeTarget: excludeTarget,
      includeTarget: includeTarget,
      continuation: continuation
    )

    queryItems.append(URLQueryItem(name: "s", value: id.urlEncode()))
    url.append(queryItems: queryItems)

    let request = URLRequest(
      url: url,
      headers: headers
    )

    let response = await request.get(resultType: GReaderStreamItemIds.self)
    switch response {
    case .success(let result):
      return result
    case .failure:
      return nil
    }
  }

  public func getSubscriptions() async -> GReaderSubscriptionList? {
    let url = URL(string: "\(baseURL)/subscription/list")
    let request = URLRequest(url: url!, headers: headers)
    let response = await request.get(resultType: GReaderSubscriptionList.self)
    switch response {
    case .success(let result):
      return result
    case .failure:
      return nil
    }
  }

  public func editTags(
    tagToAdd : String? = nil,
    tagToRemove : String? = nil,
    itemIds : [String]
  ) async {

    var url = URL(string: "\(baseURL)/edit-tag")!

    var queryItems : [URLQueryItem] = []
    if let tagToAdd = tagToAdd {
      queryItems.append(URLQueryItem(name: "a", value: tagToAdd.urlEncode()))
    }

    if let tagToRemove = tagToRemove {
      queryItems.append(URLQueryItem(name: "r", value: tagToRemove.urlEncode()))
    }

    for id in itemIds {
      queryItems.append(URLQueryItem(name: "i", value: id))
    }

    url.append(queryItems: queryItems)

    let request = URLRequest(url: url, headers: headers, method: "POST")
    _ = await request.post()
  }

  private func buildQueryItems(
    count: Int? = nil,
    order: String? = nil,
    startTime: Int? = nil,
    excludeTarget: String? = nil,
    includeTarget: String? = nil,
    continuation: String? = nil
  ) -> [URLQueryItem] {

    var queryItems: [String: String] = [:]
    if let count = count {
      queryItems["n"] = String(count)
    }

    if let order = order {
      queryItems["r"] = order
    }

    if let startTime = startTime {
      queryItems["ot"] = String(startTime)
    }

    if let includeTarget = includeTarget {
      queryItems["it"] = includeTarget
    }

    if let excludeTarget = excludeTarget {
      queryItems["xt"] = excludeTarget
    }

    if let continuation = continuation {
      queryItems["c"] = continuation
    }

    return queryItems.map({ URLQueryItem(name: $0.key, value: $0.value.urlEncode()) })
  }

}
