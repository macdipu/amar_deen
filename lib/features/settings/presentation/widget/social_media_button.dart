import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:amar_deen/core/utils/url_launcher_controller.dart';
import '../../domain/entities/social_media_entity.dart';

class SocialMediaButton extends StatelessWidget {
  const SocialMediaButton(
    this.socialMedia,
  );

  final SocialMediaEntity socialMedia;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await launchURL(socialMedia.url);
      },
      child: Row(
        children: [
          SvgPicture.asset(
            socialMedia.imagePath,
            width: 16.w,
            color: Theme.of(context).primaryColor,
          ),
          SizedBox(
            width: 8.w,
          ),
          Text(
            socialMedia.name,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
