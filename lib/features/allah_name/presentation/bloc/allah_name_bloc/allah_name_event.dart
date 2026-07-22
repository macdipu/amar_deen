part of 'allah_name_bloc.dart';

abstract class AllahNameEvent extends Equatable {
  const AllahNameEvent();
}

class FetchAllahName extends AllahNameEvent {
  const FetchAllahName();

  @override
  List<Object> get props => [];
}
