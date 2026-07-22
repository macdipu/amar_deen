/// A single row in the Settings screen's "General" card - either navigates
/// to [routeName] or runs [onTap] directly (e.g. rate on Play Store, share).
class GeneralOptionEntity {
  final String imagePath;
  final String? routeName;
  final Function()? onTap;
  final String title;
  final String subtitle;

  const GeneralOptionEntity({
    required this.imagePath,
    required this.onTap,
    required this.title,
    required this.subtitle,
    this.routeName,
  });
}
