abstract class INetworkService {
  Future openlink({required String url});
  Future<bool> subscribeToMailingList({required String email});
  Future<bool> addToBetaTesterMailingList(
      {required String subscribedUserEmail});
  Future<bool> pingServer();
}
