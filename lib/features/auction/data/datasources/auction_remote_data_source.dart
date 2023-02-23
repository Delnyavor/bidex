import 'package:bidex/features/auction/domain/entities/auction_item.dart';

abstract class AuctionRemoteDataSource {
  ///gets the cached [AuctionItem] saved on the local device
  ///
  ///Throws [CacheException] if not data is present
  Future<List<AuctionItem>?>? getAllItems(int index);

  ///saves the [AuctionItem] onto the local device
  ///
  ///Throws [CacheException] if not data is present
  Future<AuctionItem?>? createAuction(AuctionItem auction);

  ///gets the cached [AuctionItem] saved on the local device
  ///
  ///Throws [CacheException] if not data is present
  Future<AuctionItem?>? getAuction(int id);

  ///modifies the cached [AuctionItem] saved on the local device
  ///
  ///Throws [CacheException] if not data is present
  Future<AuctionItem?>? updateAuction(AuctionItem auction);

  ///deletes the cached [AuctionItem] saved on the local device
  ///
  ///Throws [CacheException] if not data is present
  Future<bool?>? deleteAuction(int id);
}
