import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_market/models/transaction.dart';
import 'package:food_market/services/transaction/transaction_provider.dart';
import 'package:http/http.dart' as http;

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc() : super(TransactionInitial()) {
    on<TransactionSubmit>(submitTransaction);
    on<LoadTransaction>(loadTransaction);
    on<UpdateStatusCanceled>(updateStatusCanceled);
  }

  Future<void> updateStatusCanceled(
      UpdateStatusCanceled event, Emitter emit) async {
    try {
      emit(const TransactionLoading());

      TransactionProvider transactionProvider = TransactionProvider();

      http.Response res =
          await transactionProvider.updateCanceledStatus(event.transaction.id);

      dynamic bodyResponse = jsonDecode(res.body);

      if (res.statusCode == 201) {
        emit(const TransactionUpdated());
      } else {
        emit(TransactionFailed(message: bodyResponse['meta']['message']));
      }
    } catch (e) {
      emit(const TransactionFailed(message: "Internal Server Error"));
    }
  }

  Future<void> loadTransaction(LoadTransaction event, Emitter emit) async {
    try {
      emit(const TransactionLoading());

      TransactionProvider transactionProvider = TransactionProvider();

      http.Response res = await transactionProvider.getTransactions();

      dynamic bodyResponse = jsonDecode(res.body);

      if (res.statusCode == 200) {
        List<Transaction> transactions =
            (bodyResponse['data'] as Iterable).map((element) {
          return Transaction.fromJson(element);
        }).toList();

        emit(TransactionLoaded(transactions: transactions));
      } else {
        emit(TransactionFailed(message: bodyResponse['meta']['message']));
      }
    } catch (e) {
      emit(const TransactionFailed(message: "Internal server error"));
    }
  }

  Future<void> submitTransaction(TransactionSubmit event, Emitter emit) async {
    emit(const TransactionLoading());
    Transaction transaction = event.transaction;

    TransactionProvider transactionProvider = TransactionProvider();

    http.Response res =
        await transactionProvider.submitTransaction(transaction);

    dynamic bodyResponse = jsonDecode(res.body);

    if (res.statusCode == 201) {
      Transaction newTransaction = Transaction.fromJson(bodyResponse['data']);
      emit(TransactionSuccess(transaction: newTransaction));
    } else {
      emit(TransactionFailed(message: bodyResponse['meta']['message']));
    }
  }
}
