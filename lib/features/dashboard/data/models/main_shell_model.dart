class NavTabItem {
  const NavTabItem({
    required this.id,
    required this.label,
    required this.iconCode,
  });

  final String id;
  final String label;
  final String iconCode;
}

class MainShellModel {
  const MainShellModel({
    required this.tabs,
  });

  final List<NavTabItem> tabs;

  static const dummy = MainShellModel(
    tabs: [
      NavTabItem(id: 'home', label: 'Home', iconCode: 'home'),
      NavTabItem(id: 'orders', label: 'Orders', iconCode: 'orders'),
      NavTabItem(id: 'kitchen', label: 'Kitchen', iconCode: 'kitchen'),
      NavTabItem(id: 'menu', label: 'Menu', iconCode: 'menu'),
      NavTabItem(id: 'more', label: 'More', iconCode: 'more'),
    ],
  );
}
