import '../../domain/entities/barter_item.dart';

abstract class BarterRemoteDataSource {
  ///gets the cached [BarterItem] saved on the local device
  ///
  ///Throws [CacheException] if not data is present
  Future<List<BarterItem>?>? getAllItems(int index);

  ///saves the [BarterItem] onto the local device
  ///
  ///Throws [CacheException] if not data is present
  Future<BarterItem?>? createBarterItem(BarterItem barterItem);

  ///gets the cached [BarterItem] saved on the local device
  ///
  ///Throws [CacheException] if not data is present
  Future<BarterItem?>? getBarterItem(int id);

  ///modifies the cached [BarterItem] saved on the local device
  ///
  ///Throws [CacheException] if not data is present
  Future<BarterItem?>? updateBarterItem(BarterItem barterItem);

  ///deletes the cached [BarterItem] saved on the local device
  ///
  ///Throws [CacheException] if not data is present
  Future<bool?>? deleteBarterItem(int id);

  ///checks the local database for any unsynced data and
  ///pushes them to the remote store
  ///
}
