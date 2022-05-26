part of 'transaction_bloc.dart';

abstract class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object> get props => [];
}

class TransactionInitial extends TransactionState {}

class TransactionSuccess extends TransactionState {
  final Transaction transaction;

  const TransactionSuccess({required this.transaction});

  @override
  List<Object> get props => [transaction];
}

class TransactionLoaded extends TransactionState {
  final List<Transaction> transactions;

  const TransactionLoaded({required this.transactions});

  @override
  List<Object> get props => [transactions];
}

class TransactionFailed extends TransactionState {
  final String message;

  const TransactionFailed({required this.message});

  @override
  List<Object> get props => [message];
}

class TransactionLoading extends TransactionState {
  const TransactionLoading();

  @override
  List<Object> get props => [];
}

class TransactionUpdated extends TransactionState {
  const TransactionUpdated();

  @override
  List<Object> get props => [];
}
