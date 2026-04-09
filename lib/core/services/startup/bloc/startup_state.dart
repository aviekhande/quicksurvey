// part of 'startup_bloc.dart';

// sealed class StartupState extends Equatable {
//   const StartupState();

//   @override
//   List<Object> get props => [];
// }

// final class StartupInitial extends StartupState {}

// class StartupApiLoadingState extends StartupState {
//   const StartupApiLoadingState();
//   @override
//   List<Object> get props => [];
// }

// class StartupApiFetchedState extends StartupState {
//   const StartupApiFetchedState({required this.startupModel});
//   final StartupModel startupModel;
//   @override
//   List<Object> get props => [startupModel];
// }

// class StartupApiFailedState extends StartupState {
//   final String error;
//   const StartupApiFailedState({required this.error});
//   @override
//   List<Object> get props => [error];
// }

// class StartupApiExceptionState extends StartupState {
//   final String error;
//   const StartupApiExceptionState({required this.error});
//   @override
//   List<Object> get props => [error];
// }

// class StartupApiForceLogoutState extends StartupState {
//   @override
//   List<Object> get props => [];
// }

// class StartupConnectionTimeOutExceptionState extends StartupState {
//   @override
//   List<Object> get props => [];
// }
