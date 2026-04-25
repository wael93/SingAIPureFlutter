// TODO: Implement translation cubit
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'translation_state.dart';

class TranslationCubit extends Cubit<TranslationState> {
  TranslationCubit() : super(const TranslationState.idle());
  
  // Placeholder for translation cubit methods
}

@freezed
class TranslationState with _$TranslationState {
  const factory TranslationState.idle() = _Idle;
  const factory TranslationState.loading() = _Loading;
  const factory TranslationState.success() = _Success;
  const factory TranslationState.error(String message) = _Error;
}
