import 'dart:async';

import 'package:coming_soon/app/app.locator.dart';
import 'package:coming_soon/app/app.logger.dart';
import 'package:coming_soon/utilities/enums/app_enums.dart';
import 'package:coming_soon/utilities/network/failure.dart';

import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../services/i_network_service.dart';

class ComingSoonViewModel extends BaseViewModel {
  final _log = getLogger('ComingSoonViewModel');
  final _networkService = locator<INetworkService>();
  final _dialogService = locator<DialogService>();
  bool _subscriptionSuccessful = false;
  bool get subscriptionSuccessful => _subscriptionSuccessful;

  void _setSubScriptionSuccessfullStatus(bool value) {
    _subscriptionSuccessful = value;
    notifyListeners();
  }

  String? _days;
  String? _hours;
  String? _minutes;
  String? _seconds;

  String? get days => _days;
  String? get hours => _hours;
  String? get minutes => _minutes;
  String? get seconds => _seconds;

  /// Timer related methods
  Timer? countdownTimer;

  Duration myDuration = Duration(
      days: DateTime.parse('2022-05-20').difference(DateTime.now()).inDays);
  String strDigits(int n) => n.toString().padLeft(2, '0');

  // Start Timer
  void startTimer() {
    _log.i('Timer Started');
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  // CountDown
  void setCountDown() {
    const reduceSecondsBy = 1;
    final newSeconds = myDuration.inSeconds - reduceSecondsBy;
    if (newSeconds < 0) {
      countdownTimer!.cancel();
    } else {
      myDuration = Duration(seconds: newSeconds);
      _days = strDigits(myDuration.inDays);
      _hours = strDigits(myDuration.inHours.remainder(24));
      _minutes = strDigits(myDuration.inMinutes.remainder(60));
      _seconds = strDigits(myDuration.inSeconds.remainder(60));
    }
    notifyListeners();
  }

  // Subsctibing User to mailing list and adding users to beta testing mailing list

  Future subscribeUserToMailingList({required String email}) async {
    try {
      setBusy(true);
      bool isSucccessful =
          await _networkService.subscribeToMailingList(email: email);
      if (isSucccessful) {
        _setSubScriptionSuccessfullStatus(isSucccessful);

        await _dialogService
            .showCustomDialog(
              variant: DialogType.success,
              barrierDismissible: true,
            )
            .then((value) => redirectToBlogSite());
      }
    } on Failure catch (ex) {
      _log.d(ex.message);
      _setSubScriptionSuccessfullStatus(false);
      _dialogService.showCustomDialog(
        variant: DialogType.error,
        title: ex.message,
      );
    } catch (err) {
      _log.d(err);
      _setSubScriptionSuccessfullStatus(false);
      _dialogService.showCustomDialog(
        variant: DialogType.error,
        title: 'Something went wrong, pls try again',
      );
    } finally {
      setBusy(false);
    }
  }

  // Ping server
  Future pingServer() async {
    try {
      setBusy(true);
      _networkService.pingServer();
    } on Failure catch (ex) {
      _log.e(ex.message);
    } finally {
      setBusy(false);
    }
  }

  Future openWebUrlLink(String url) async {
    try {
      await _networkService.openlinkInNewTab(url: url);
    } on Failure catch (ex) {
      _dialogService.showCustomDialog(
        variant: DialogType.error,
        title: ex.message,
      );
      _log.e(ex);
    }
  }

  Future redirectToBlogSite() async {
    _log.i('Redirecting to blogsite');
    try {
      await _networkService.openLinkInSameTab(
          url: 'https://www.blog.mindspang.com');
    } on Failure catch (ex) {
      _dialogService.showCustomDialog(
        variant: DialogType.error,
        title: ex.message,
      );
      _log.e(ex);
    }
  }
}
