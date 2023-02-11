extension Source {

  static func fake() -> Source {
    return Source(client: FakeRssClient())
  }

}
