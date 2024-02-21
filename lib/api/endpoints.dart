class EndPoints {
  static const String baseUrl = 'https://bidex.up.railway.app/api';

  // POST
  static String createPost = "$baseUrl/posts/";

  // AUCTION ENDPOINTS
  static String createAuctionUrl = createPost;

  // BARTER ENDPOINTS
  static String createBarterUrl = createPost;

  // COMMENTS

  // same endpoint for fetching data. Change to get or post as needed
  static String createComment(String postId) =>
      '$baseUrl/api/posts/$postId/comments';

  static String createReply(String postId, String commentId) =>
      '$baseUrl/api/posts/$postId/comments/$commentId';
}
