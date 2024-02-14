class EndPoints {
  static const String baseUrl = 'https://bidex.up.railway.app/api/';

  // POST
  static String createPost = "$baseUrl+posts/";

  // AUCTION ENDPOINTS
  static String createAuctionUrl = createPost;

  // BARTER ENDPOINTS
  static String createBarterUrl = createPost;
}
