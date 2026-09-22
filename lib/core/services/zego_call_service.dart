// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
// import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';
// import 'package:permission_handler/permission_handler.dart';
// import '../../data/repositories/user_repository.dart';
// import 'storage_service.dart';
// import '../../main.dart';
// import 'package:audioplayers/audioplayers.dart';

// class ZegoCallService extends GetxService {
//   final _userRepository = UserRepository();
//   final _storageService = Get.find<StorageService>();

//   AudioPlayer? _ringtonePlayer;

//   Future<void> _startRingtone() async {
//     try {
//       if (_ringtonePlayer == null) {
//         _ringtonePlayer = AudioPlayer();
//         await _ringtonePlayer!.setReleaseMode(ReleaseMode.loop);
//       }
//       await _ringtonePlayer!.play(AssetSource('old_phone_ring_tone.mp3'));
//     } catch (e) {
//       print('[ZegoCloud] Error playing ringtone: $e');
//     }
//   }

//   void _stopRingtone() {
//     try {
//       _ringtonePlayer?.stop();
//       _ringtonePlayer?.dispose();
//       _ringtonePlayer = null;
//     } catch (e) {
//       print('[ZegoCloud] Error stopping ringtone: $e');
//     }
//   }

//   Future<ZegoCallService> init() async {
//     try {
//       await initZego();
//     } catch (e) {
//       print('❌ ZegoCallService initialization failed: $e');
//     }
//     return this;
//   }

//   Future<void> requestPermissions() async {
//     try {
//       await [
//         Permission.camera,
//         Permission.microphone,
//         Permission.notification,
//       ].request();
//       print('[ZegoCloud] Call permissions (camera, mic, notifications) requested.');
//     } catch (e) {
//       print('[ZegoCloud] Error requesting call permissions: $e');
//     }
//   }

//   Future<void> initZego() async {
//     final vehicle = _storageService.getVehicle();
//     if (vehicle == null) {
//       print('[ZegoCloud] No vehicle owner info found. Skipping init.');
//       return;
//     }

//     await requestPermissions();

//     try {
//       final settings = await _userRepository.getPublicSettings();
//       if (settings != null) {
//         final appIdStr = settings['zegocloud_appid'];
//         final appSign = settings['zegocloud_appsign'];
        
//         if (appIdStr != null && appSign != null && appIdStr.toString().isNotEmpty && appSign.toString().isNotEmpty) {
//           final appId = int.tryParse(appIdStr.toString()) ?? 0;
//           if (appId != 0) {
//             ZegoUIKitPrebuiltCallInvitationService().init(
//               appID: appId,
//               appSign: appSign.toString(),
//               userID: vehicle.ownerPhone,
//               userName: vehicle.ownerName,
//               plugins: [ZegoUIKitSignalingPlugin()],
//               config: ZegoCallInvitationConfig(),
//               uiConfig: ZegoCallInvitationUIConfig(
//                 invitee: ZegoCallInvitationInviteeUIConfig(
//                   popUp: ZegoCallInvitationNotifyPopUpUIConfig(
//                     visible: false,
//                   ),
//                 ),
//               ),
//               notificationConfig: ZegoCallInvitationNotificationConfig(
//                 androidNotificationConfig: ZegoAndroidNotificationConfig(
//                   showOnLockedScreen: true,
//                   channelID: "ZegoCall",
//                   channelName: "Call Notifications",
//                 ),
//                 iOSNotificationConfig: ZegoIOSNotificationConfig(),
//               ),
//               invitationEvents: ZegoUIKitPrebuiltCallInvitationEvents(
//                 onIncomingCallReceived: (callID, caller, callType, callees, customData) {
//                   print('[ZegoCloud] Incoming call received from: ${caller.name} (ID: $callID)');
//                   _showIncomingCallPopup(callID, caller.name);
//                 },
//               ),
//             );
//             print('[ZegoCloud] Initialized successfully for user: ${vehicle.ownerName} (${vehicle.ownerPhone})');
//           } else {
//             print('[ZegoCloud] Invalid App ID: $appIdStr');
//           }
//         } else {
//           print('[ZegoCloud] ZegoCloud configurations not found in public settings.');
//         }
//       }
//     } catch (e) {
//       print('[ZegoCloud] Init failed: $e');
//     }
//   }

//   void _showIncomingCallPopup(String callID, String callerName) {
//     final context = navigatorKey.currentContext;
//     if (context == null) {
//       print('[ZegoCloud] Cannot show popup: Navigator context is null');
//       return;
//     }
//     _startRingtone();
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (dialogContext) => Dialog(
//         // backgroundColor: Colors.transparent,
//         elevation: 0,
//         child: Container(
//           padding: const EdgeInsets.all(24),
//           decoration: BoxDecoration(
//             color: const Color(0xFF1E1E2E).withOpacity(0.95), // SLEEK DARK THEME
//             borderRadius: BorderRadius.circular(24),
//             border: Border.all(
//               color: Colors.white.withOpacity(0.1),
//               width: 1,
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.5),
//                 blurRadius: 20,
//                 offset: const Offset(0, 10),
//               ),
//             ],
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               // Phone/Call Icon with subtle color background
//               Container(
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: Colors.green.withOpacity(0.1),
//                   shape: BoxShape.circle,
//                 ),
//                 child: const Icon(
//                   Icons.phone_in_talk_rounded,
//                   color: Colors.greenAccent,
//                   size: 48,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               const Text(
//                 'INCOMING CALL',
//                 style: TextStyle(
//                   color: Colors.white70,
//                   fontSize: 12,
//                   fontWeight: FontWeight.w600,
//                   letterSpacing: 2.0,
//                 ),
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 callerName,
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 24),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   // Decline Button
//                   GestureDetector(
//                     onTap: () async {
//                       try {
//                         await ZegoUIKitPrebuiltCallInvitationService().reject();
//                       } catch (e) {
//                         print('[ZegoCloud] Error rejecting call: $e');
//                       }
//                       _stopRingtone();
//                       Navigator.of(dialogContext).pop();
//                     },
//                     child: Container(
//                       padding: const EdgeInsets.all(16),
//                       decoration: const BoxDecoration(
//                         color: Colors.redAccent,
//                         shape: BoxShape.circle,
//                       ),
//                       child: const Icon(
//                         Icons.call_end,
//                         color: Colors.white,
//                         size: 28,
//                       ),
//                     ),
//                   ),
//                   // Accept Button
//                   GestureDetector(
//                     onTap: () async {
//                       try {
//                         await ZegoUIKitPrebuiltCallInvitationService().accept();
//                       } catch (e) {
//                         print('[ZegoCloud] Error accepting call: $e');
//                       }
//                       _stopRingtone();
//                       Navigator.of(dialogContext).pop();
//                     },
//                     child: Container(
//                       padding: const EdgeInsets.all(16),
//                       decoration: const BoxDecoration(
//                         color: Colors.greenAccent,
//                         shape: BoxShape.circle,
//                       ),
//                       child: const Icon(
//                         Icons.call,
//                         color: Colors.white,
//                         size: 28,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void terminateZego() {
//     try {
//       ZegoUIKitPrebuiltCallInvitationService().uninit();
//       print('[ZegoCloud] Terminated calling service.');
//     } catch (e) {
//       print('[ZegoCloud] Termination failed: $e');
//     }
//   }
// }
