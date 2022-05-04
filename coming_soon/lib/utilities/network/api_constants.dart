class ApiConstants {
  // Base Related

  static String scheme = 'https';
  static String host = 'us20.api.mailchimp.com';
  static int receiveTimeout = 3000;
  static int sendTimeout = 5000;
  static Uri baseUri = Uri(scheme: scheme, host: host, path: '/');

// Subscription Endpoints

  static Uri addSubscriberToWaitlistUri =
      Uri(scheme: scheme, host: host, path: '/3.0/lists/b95731553c/members');
  static Uri pingserverUris =
      Uri(scheme: scheme, host: host, path: '/3.0/ping');
  static Uri addSubscroberToBetaTesters(
          {required dynamic subscribedUserEmailHash}) =>
      Uri(
          scheme: scheme,
          host: host,
          path: '/3.0/lists/b95731553c/members/$subscribedUserEmailHash/tags');
}
