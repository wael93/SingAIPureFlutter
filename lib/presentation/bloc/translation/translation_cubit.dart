// TODO: Implement translation cubit
import 'package:flutter_bloc/flutter_bloc.dart';

class TranslationCubit extends Cubit<TranslationState> {
  TranslationCubit() : super(TranslationInitial());
  
  // Placeholder for translation cubit methods
}

class TranslationState {}

class TranslationInitial extends TranslationState {}

class TranslationLoading extends TranslationState {}

class TranslationSuccess extends TranslationState {}

class TranslationFailure extends TranslationState {
  final String message;
  
  TranslationFailure(this.message);
}
