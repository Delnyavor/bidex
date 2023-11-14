import 'package:bidex/features/payment/domain/entities/payment_method.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/transaction.dart';

abstract class PaymentRepository {
  Future<Either<Failure, (List<Transaction>?, List<PaymentMethod>?)>>?
      getPaymentMethods();

  Future<Either<Failure, PaymentMethod?>>? getPaymentMethod();

  Future<Either<Failure, PaymentMethod?>>? createPaymentMethod();

  Future<Either<Failure, bool?>>? deletePaymentMethod();
}
