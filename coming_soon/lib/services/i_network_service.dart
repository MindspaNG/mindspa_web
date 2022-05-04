abstract class INetworkService {
  Future openlinkInNewTab({required String url});
  Future openLinkInSameTab({required String url});
  Future<bool> subscribeToMailingList({required String email});
  Future<bool> addToBetaTesterMailingList(
      {required String subscribedUserEmail});
  Future<bool> pingServer();
}
