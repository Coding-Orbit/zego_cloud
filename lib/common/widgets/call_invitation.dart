import 'package:flutter/material.dart';
import 'package:zego_cloud/common/static.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

class CallInvitationPage extends StatelessWidget {
  const CallInvitationPage({
    super.key,
    required this.child,
    required this.username,
  });

  final Widget child;
  final String username;

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCallWithInvitation(
      appID: Statics.appID,
      appSign: Statics.appSign,
      userID: username,
      userName: username,
      plugins: [ZegoUIKitSignalingPlugin()],
      child: child,
    );
  }
}
