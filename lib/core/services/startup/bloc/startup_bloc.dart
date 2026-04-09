// import 'dart:async';
// import 'dart:developer';

// import 'package:bloc/bloc.dart';
// import 'package:caesar_cipher/core/services/shared_preferences/shared_preferences_service.dart';
// import 'package:caesar_cipher/core/services/startup/data/models/startup_model.dart';
// import 'package:caesar_cipher/core/services/startup/data/repositories/startup_respository.dart';
// import 'package:caesar_cipher/init_dependencies.dart';
// import 'package:equatable/equatable.dart';

// part 'startup_event.dart';
// part 'startup_state.dart';

// class StartupBloc extends Bloc<StartupEvent, StartupState> {
//   final sharedPrefsService = serviceLocator<SharedPreferencesService>();
//   final StartupRepository _repository;

//   StartupBloc({required StartupRepository repository})
//     : _repository = repository,
//       super(StartupInitial()) {
//     on<StartupFetchEvent>(_onStartupApiFetch);
//   }
//   void _onStartupApiFetch(
//     StartupFetchEvent event,
//     Emitter<StartupState> emit,
//   ) async {
//     try {
//       emit(const StartupApiLoadingState());
//       final data = await _repository.call({});

//       if (data.success == 4) {
//         emit(StartupApiForceLogoutState());
//         sharedPrefsService.deleteToken();
//       } else if (data.success == 0 || data.success == 99) {
//         emit(StartupApiFailedState(error: data.message!));
//       } else {
//         emit(StartupApiFetchedState(startupModel: data));
//       }
//     } on TimeoutException catch (e) {
//       log('TIMEOUT EXCEPTION$e');
//       emit(StartupConnectionTimeOutExceptionState());
//     } catch (e) {
//       emit(StartupApiExceptionState(error: e.toString()));
//     }
//   }
// }
