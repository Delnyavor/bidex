import 'package:bidex/features/payment/domain/entities/payment_method.dart';

abstract class PaymentRemoteDataSource {
  ///gets the cached [PaymentMethod] saved on the local device
  ///
  ///Throws [CacheException] if not data is present
  Future<List<PaymentMethod>?>? getAllMethods(int index);

  ///saves the [PaymentMethod] onto the local device
  ///
  ///Throws [CacheException] if not data is present
  Future<PaymentMethod?>? createPaymentMethod(PaymentMethod paymentMethod);

  ///gets the cached [PaymentMethod] saved on the local device
  ///
  ///Throws [CacheException] if not data is present
  Future<PaymentMethod?>? getPaymentMethod(int id);

  ///deletes the cached [PaymentMethod] saved on the local device
  ///
  ///Throws [CacheException] if not data is present
  Future<bool?>? deletePaymentMethod(int id);
}
