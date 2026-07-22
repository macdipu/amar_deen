/// A single social/contact link shown on the Settings screen's "Connect"
/// card.
class SocialMediaEntity {
  final String imagePath;
  final String name;
  final String url;

  const SocialMediaEntity({
    required this.imagePath,
    required this.name,
    required this.url,
  });
}

// TODO: old fork's contact links (website/email/medium/youtube/facebook/
// instagram, all pointing at the prior maintainer) removed along with the
// Settings screen's "Connect" card. Repopulate with Amar Deen's own links
// when available and re-add SocialMediaCard() to setting_screen.dart.
final List<SocialMediaEntity> socialMediaList = [];
