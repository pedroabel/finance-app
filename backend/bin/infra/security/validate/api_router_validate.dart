class APIRouterValidate {
  final List<String> _routes = [];

  APIRouterValidate add(String path) {
    _routes.add(path);
    return this;
  }

  bool isPublic(String path) {
    return _routes.contains(path);
  }
}
