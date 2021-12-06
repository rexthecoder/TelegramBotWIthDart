import 'package:bloc/bloc.dart';

/// Track and stream the current state[data] of the application.
class BotCubit extends Cubit<dynamic> {
  BotCubit() : super([]);

  void data(dynamic data) => emit(data);

  @override
  void onError(Object error, StackTrace stackTrace) {
    print('$error, $stackTrace');
    super.onError(error, stackTrace);
  }
}
