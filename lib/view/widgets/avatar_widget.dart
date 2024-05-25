import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../generated/assets.dart';
import '../../providers/user_data_provider.dart';

class AvatarWidget extends ConsumerWidget {
  final double? maxRadius;
  final String? url;
  const AvatarWidget({super.key, this.maxRadius, required this.url});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final avatarUrl = ref.watch(avatarProvider);
    
    /*if ((avatarUrl == null || avatarUrl.isEmpty) && (url == null || url!.isEmpty)) {
      return Hero(
        tag: 'avatar', child: CircleAvatar(maxRadius: maxRadius, child: SvgPicture.asset(Assets.picturesDefaultAvatar))
      );
    }
    
    if (url != null && url!.isNotEmpty) {
      return Hero(
        tag: 'avatar',
        child: CircleAvatar(maxRadius: maxRadius, backgroundImage: NetworkImage(url!)),
      );
    }
    
    return Hero(
      tag: 'avatar',
      child: CircleAvatar(maxRadius: maxRadius, backgroundImage: NetworkImage(avatarUrl!)),
    );*/
    
    return Hero(
        tag: 'avatar',
        child: (avatarUrl == null || avatarUrl.isEmpty) && (url == null || url!.isEmpty)
            ? CircleAvatar(maxRadius: maxRadius, child: SvgPicture.asset(Assets.picturesDefaultAvatar))
            : CircleAvatar(
            maxRadius: maxRadius,
            backgroundImage: NetworkImage((url != null && url!.isNotEmpty && avatarUrl == null) ? url! : avatarUrl!))
    );
  }
}
