part of 'locale_bloc.dart';

abstract class LocaleState extends Equatable {
  const LocaleState();
}

class InitialLocaleState extends LocaleState {
  @override
  List<Object> get props => [];
}
