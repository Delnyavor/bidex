import 'package:bidex/core/error/failures.dart';
import 'package:bidex/features/payment/domain/entities/payment_method.dart';
import 'package:bidex/features/payment/domain/entities/transaction.dart';
import 'package:bidex/features/payment/domain/repositories/payment_repository.dart';
import 'package:dartz/dartz.dart';

class PaymentRepositoryImpl extends PaymentRepository {
  @override
  Future<Either<Failure, (List<Transaction>?, List<PaymentMethod>?)>>?
      getPaymentMethods() {
    return null;
  }

  @override
  Future<Either<Failure, PaymentMethod?>>? getPaymentMethod() {
    return null;
  }

  @override
  Future<Either<Failure, PaymentMethod?>>? createPaymentMethod() {
    return null;
  }

  @override
  Future<Either<Failure, bool?>>? deletePaymentMethod() {
    return null;
  }
}
