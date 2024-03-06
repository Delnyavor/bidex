class EndPoints {
  static const String baseUrl = 'https://bidex.up.railway.app/api';

  // POST
  static String createPost = "$baseUrl/posts/";
  static String fetchPosts = "$baseUrl/posts?user=true";

  // AUCTION ENDPOINTS
  static String createAuctionUrl = createPost;

  // BARTER ENDPOINTS
  static String createBarterUrl = createPost;

  // COMMENTS

  // same endpoint for fetching data. Change to get or post as needed
  static String createComment(String postId) =>
      '$baseUrl/posts/$postId/comments?user=true';

  static String createReply(String postId, String commentId) =>
      '$baseUrl/posts/$postId/comments/$commentId?user=true';
}
