// import 'package:equatable/equatable.dart';

// enum ContactsPermissionStatus { initial, granted, denied, permanentlyDenied }

// class ContactsPermissionState extends Equatable {
//   final ContactsPermissionStatus status;
//   final bool isLoading;
//   final String? errorMessage;

//   const ContactsPermissionState({
//     this.status = ContactsPermissionStatus.initial,
//     this.isLoading = false,
//     this.errorMessage,
//   });

//   ContactsPermissionState copyWith({
//     ContactsPermissionStatus? status,
//     bool? isLoading,
//     String? errorMessage,
//   }) {
//     return ContactsPermissionState(
//       status: status ?? this.status,
//       isLoading: isLoading ?? this.isLoading,
//       errorMessage: errorMessage ?? this.errorMessage,
//     );
//   }

//   @override
//   List<Object?> get props => [status, isLoading, errorMessage];
// }
