part of 'translation_cubit.dart';

@freezed
class TranslationState with _$TranslationState {
  const factory TranslationState.idle() = _Idle;
  const factory TranslationState.loading() = _Loading;
  const factory TranslationState.success() = _Success;
  const factory TranslationState.error(String message) = _Error;
}
