import 'package:flutter/material.dart';
import 'package:zego_cloud/models/user.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class UserCard extends StatefulWidget {
  final UserModel userModel;

  const UserCard({
    required this.userModel,
    super.key,
  });

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 75,
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.5),
          boxShadow: [
            BoxShadow(
              offset: const Offset(10, 20),
              blurRadius: 10,
              spreadRadius: 0,
              color: Colors.grey.withOpacity(.05),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              radius: 25,
              child: Center(
                child: Text(
                  widget.userModel.name.substring(0, 1).toUpperCase(),
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              widget.userModel.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const Spacer(),
            // audio call button
            actionButton(false),
            // video call button
            actionButton(true),
          ],
        ),
      ),
    );
  }

  ZegoSendCallInvitationButton actionButton(bool isVideo) =>
      ZegoSendCallInvitationButton(
        isVideoCall: isVideo,
        resourceID: "zegouikit_call",
        invitees: [
          ZegoUIKitUser(
            id: widget.userModel.username,
            name: widget.userModel.name,
          ),
        ],
      );
}
