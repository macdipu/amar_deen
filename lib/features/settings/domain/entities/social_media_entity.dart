import 'package:amar_deen/core/constants/constants.dart';

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

/// Hardcoded contact links - no external source to abstract behind a
/// repository, same "nothing to abstract" precedent as Zakat.
final List<SocialMediaEntity> socialMediaList = [
  SocialMediaEntity(
    imagePath: 'assets/images/setting_icon/svg/link.svg',
    name: 'Website',
    url: WEBSITE_URL,
  ),
  SocialMediaEntity(
    imagePath: 'assets/images/setting_icon/svg/email.svg',
    name: 'Email',
    url: EMAIL_URL,
  ),
  SocialMediaEntity(
    imagePath: 'assets/images/setting_icon/svg/medium.svg',
    name: 'Medium',
    url: MEDIUM_URL,
  ),
  SocialMediaEntity(
    imagePath: 'assets/images/setting_icon/svg/youtube.svg',
    name: 'Youtube',
    url: YOUTUBE_URL,
  ),
  SocialMediaEntity(
    imagePath: 'assets/images/setting_icon/svg/facebook.svg',
    name: 'Facebook',
    url: FACEBOOK_URL,
  ),
  SocialMediaEntity(
    imagePath: 'assets/images/setting_icon/svg/insta.svg',
    name: 'Instagram',
    url: INSTA_URL,
  ),
];
