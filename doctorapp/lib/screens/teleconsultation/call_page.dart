import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import '../../widgets/teleconsultation_widgets/call_widgets/error_scaffold.dart';
import '../../widgets/teleconsultation_widgets/call_widgets/phr_button.dart';
import '../../widgets/teleconsultation_widgets/call_widgets/phr_viewer.dart';

/// Teleconsultation call page using ZEGOCLOUD prebuilt call UI.
///
/// Configuration is sourced from .env via flutter_dotenv.

class TeleconsultationCallPage extends StatelessWidget {
  final String appointmentId; // used as callID/roomID
  final String userId;
  final String userName;
  final bool isVideo; // true => video call; false => voice call
  final String? token; // if provided (token auth), appSign won't be used

  const TeleconsultationCallPage({
    super.key,
    required this.appointmentId,
    required this.userId,
    required this.userName,
    required this.isVideo,
    this.token,
  });

  @override
  Widget build(BuildContext context) {
    // Read AppID and appSign from .env
    final appIdStr = dotenv.env['ZEGO_APP_ID'] ?? '';
    final appId = int.tryParse(appIdStr) ?? 0;
    final appSign = (dotenv.env['ZEGO_APP_SIGN'] ?? '').trim();

    // Minimal validation & helpful message
    if (appId <= 0) {
      return const ErrorScaffold(
        title: 'ZEGOCLOUD not configured',
        message:
            'ZEGO_APP_ID is missing or invalid in your .env file.\n\n'
            'Add ZEGO_APP_ID and either ZEGO_APP_SIGN (for local dev) or set '
            'ZEGO_USE_TOKEN=true with a valid ZEGO_TOKEN_SERVER for production.',
      );
    }

    final callConfig = isVideo
        ? ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
        : ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall();
    callConfig.turnOnCameraWhenJoining = isVideo;
    callConfig.turnOnMicrophoneWhenJoining = true;

    // Ensure non-null strings for SDK fields
    final useToken =
        (dotenv.env['ZEGO_USE_TOKEN'] ?? 'false').toLowerCase() == 'true';
    final effectiveToken = token ?? (useToken ? '' : null);
    final effectiveAppSign = (effectiveToken == null || effectiveToken.isEmpty)
        ? appSign
        : '';

    if ((effectiveToken == null || effectiveToken.isEmpty) &&
        effectiveAppSign.isEmpty) {
      return const ErrorScaffold(
        title: 'Missing credentials',
        message:
            'Neither a token nor an appSign is available.\n\n'
            'For local dev, set ZEGO_APP_SIGN in .env. For production, provide a token ',
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Call UI
            Positioned.fill(
              child: ZegoUIKitPrebuiltCall(
                appID: appId,
                appSign: effectiveAppSign,
                token: effectiveToken ?? '',
                userID: userId,
                userName: userName,
                callID: appointmentId,
                config: callConfig,
              ),
            ),
            // PHR quick access button
            Positioned(
              top: 12.r,
              right: 12.r,
              child: SafeArea(child: PHRButton(onTap: () => _openPHR(context))),
            ),
          ],
        ),
      ),
    );
  }

  void _openPHR(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.white,
      builder: (ctx) => PHRViewer(appointmentId: appointmentId),
    );
  }
}
