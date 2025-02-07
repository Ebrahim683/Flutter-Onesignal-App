class RouterPath {
  static RouterPath routerPath = RouterPath._();
  RouterPath._();
  factory RouterPath() => routerPath;

  String homePage = '/home_page';
}

final RouterPath routerPath = RouterPath();
