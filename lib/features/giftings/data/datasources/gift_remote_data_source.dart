import '../../domain/entities/gift_item.dart';

abstract class GiftRemoteDataSource {
  ///gets the cached [Gift] saved on the local device
  ///
  ///Throws [CacheException] if not data is present
  Future<List<Gift>?>? getAllItems(int index);

  ///saves the [Gift] onto the local device
  ///
  ///Throws [CacheException] if not data is present
  Future<Gift?>? createGift(Gift gift, String authToken, String refreshToken);

  ///gets the cached [Gift] saved on the local device
  ///
  ///Throws [CacheException] if not data is present
  Future<Gift?>? getGift(int id);

  ///modifies the cached [Gift] saved on the local device
  ///
  ///Throws [CacheException] if not data is present
  Future<Gift?>? updateGift(Gift gift);

  ///deletes the cached [Gift] saved on the local device
  ///
  ///Throws [CacheException] if not data is present
  Future<bool?>? deleteGift(int id);

  ///checks the local database for any unsynced data and
  ///pushes them to the remote store
  ///
}
