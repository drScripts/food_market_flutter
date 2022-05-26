part of 'transaction_bloc.dart';

abstract class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object> get props => [];
}

class TransactionSubmit extends TransactionEvent {
  final Transaction transaction;

  const TransactionSubmit({required this.transaction});

  @override
  List<Object> get props => [transaction];
}

class LoadTransaction extends TransactionEvent {
  const LoadTransaction();

  @override
  List<Object> get props => [];
}

class UpdateStatusCanceled extends TransactionEvent {
  final Transaction transaction;
  const UpdateStatusCanceled({required this.transaction});

  @override
  List<Object> get props => [transaction];
}
