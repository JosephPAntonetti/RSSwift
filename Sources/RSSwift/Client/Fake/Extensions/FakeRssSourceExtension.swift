extension Source {

  public static func fake() -> Source {
    return Source(client: FakeRssClient())
  }

}
