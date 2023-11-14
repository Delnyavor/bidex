import 'package:bidex/features/payment/domain/entities/payment_method.dart';
import 'package:bidex/features/payment/domain/entities/transaction.dart';

typedef PaymentPayload = (
  List<PaymentMethod> methods,
  List<Transaction> transactions
);
