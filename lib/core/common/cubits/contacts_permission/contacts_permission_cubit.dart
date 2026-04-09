// import 'dart:developer';

// import 'package:caesar_cipher/core/common/cubits/contacts_permission/contacts_permission_state.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_contacts/flutter_contacts.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:permission_handler/permission_handler.dart' as AppSettings;

// class ContactsPermissionCubit extends Cubit<ContactsPermissionState> {
//   ContactsPermissionCubit() : super(const ContactsPermissionState());

//   /// Check current permission status without requesting
//   Future<void> checkPermissionStatus() async {
//     try {
//       emit(state.copyWith(isLoading: true));

//       // Check if permission is already granted
//       final hasPermission = await FlutterContacts.requestPermission(
//         readonly: true,
//       );

//       if (hasPermission) {
//         emit(
//           state.copyWith(
//             status: ContactsPermissionStatus.granted,
//             isLoading: false,
//           ),
//         );
//       } else {
//         // Check if permission was permanently denied
//         final permissionStatus = await Permission.contacts.status;

//         if (permissionStatus.isPermanentlyDenied) {
//           print("PERMANENTLY DENIED");
//           emit(
//             state.copyWith(
//               status: ContactsPermissionStatus.permanentlyDenied,
//               isLoading: false,
//             ),
//           );
//         } else {
//           print("SIMPLE DENIED");

//           emit(
//             state.copyWith(
//               status: ContactsPermissionStatus.denied,
//               isLoading: false,
//             ),
//           );
//         }
//       }
//     } catch (e) {
//       emit(
//         state.copyWith(
//           isLoading: false,
//           errorMessage: 'Failed to check permission: $e',
//         ),
//       );
//     }
//   }

//   /// Request contacts permission
//   Future<bool> requestPermission() async {
//     try {
//       emit(state.copyWith(isLoading: true));
//       final hasPermission = await FlutterContacts.requestPermission();
//       if (hasPermission) {
//         emit(
//           state.copyWith(
//             status: ContactsPermissionStatus.granted,
//             isLoading: false,
//             errorMessage: null,
//           ),
//         );
//         return true;
//       } else {
//         // Check if it's permanently denied
//         final permissionStatus = await Permission.contacts.status;

//         if (permissionStatus.isPermanentlyDenied) {
//           emit(
//             state.copyWith(
//               status: ContactsPermissionStatus.permanentlyDenied,
//               isLoading: false,
//               errorMessage:
//                   'Permission permanently denied. Please enable in settings.',
//             ),
//           );
//         } else {
//           emit(
//             state.copyWith(
//               status: ContactsPermissionStatus.denied,
//               isLoading: false,
//               errorMessage: 'Contacts permission denied',
//             ),
//           );
//         }
//         return false;
//       }
//     } catch (e) {
//       emit(
//         state.copyWith(
//           isLoading: false,
//           errorMessage: 'Failed to request permission: $e',
//         ),
//       );
//       return false;
//     }
//   }

//   /// Open app settings (useful for permanently denied cases)
//   Future<void> openAppSettings() async {
//     try {
//       final opened = await AppSettings.openAppSettings();
//       if (opened) {
//         // You can optionally wait a few seconds or recheck after Navigator pop
//         await Future.delayed(Duration(seconds: 2));
//         await checkPermissionStatus();
//         log("After check permission status");
//       } else {
//         emit(state.copyWith(errorMessage: 'Unable to open app settings'));
//       }
//     } catch (e) {
//       emit(state.copyWith(errorMessage: 'Failed to open settings: $e'));
//     }
//   }

//   /// Reset error message
//   void clearError() {
//     emit(state.copyWith(errorMessage: null));
//   }

//   /// Manual permission update (useful when permission changes externally)
//   void updatePermissionStatus(ContactsPermissionStatus status) {
//     emit(state.copyWith(status: status));
//   }
// }
