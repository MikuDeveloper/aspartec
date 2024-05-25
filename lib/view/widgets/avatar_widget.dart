import 'package:aspartec/generated/assets.dart';
import 'package:aspartec/providers/user_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class AvatarWidget extends ConsumerWidget {
  final double? maxRadius;
  const AvatarWidget({super.key, this.maxRadius});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final avatarUrl = ref.watch(avatarProvider);
    return Hero(
        tag: 'avatar',
        child: (avatarUrl == null || avatarUrl.isEmpty)
            ? CircleAvatar(maxRadius: maxRadius, child: SvgPicture.asset(Assets.picturesDefaultAvatar))
            : CircleAvatar(maxRadius: maxRadius, backgroundImage: NetworkImage(avatarUrl))
    );
  }
}
