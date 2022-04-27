part of coming_soon_view;

class _ComingSoonDesktop extends StatelessWidget {
  final ComingSoonViewModel viewModel;

  const _ComingSoonDesktop(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.zero,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            // TopBar
            TopBar(),
            // Heading Text
            Text(
              'Mind-Spa is a platform for the rejuvenation of the mind',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 36),
            ),
            SizedBox(
              height: 20,
            ),
            // Sub Text
            SubLongText(),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 300),
              child: FittedBox(
                child: Text(
                  'We are launching soon, join the waitlist to get notified',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 36),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            CountDownTimer(),
            SizedBox(
              height: 19,
            ),
            TextFieldAndSubmitButton(),
            BottomBar(),
          ],
        ),
      ),
    );
  }
}

class SubLongText extends StatelessWidget {
  const SubLongText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.15,
      ),
      child: const Text(
        'We are creating an avenue to provide access to holistic health and promote mental wellbeing towards the eradication of mental health problems in Africa by connecting users to the most relevant resources tailored to their mental health needs.',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 24,
          height: 2,
          color: Color(0XFF516D61),
        ),
      ),
    );
  }
}

class BottomBar extends StatelessWidget {
  const BottomBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.loose,
      child: SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.only(left: 50),
                child: Image.asset(
                  'assets/images/png/Frame 662.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SvgPicture.asset(
              'assets/images/svg/Ellipse 77.svg',
              fit: BoxFit.cover,
              height: 150,
            )
          ],
        ),
      ),
    );
  }
}

class CountDownTimer extends StatefulWidget {
  const CountDownTimer({
    Key? key,
  }) : super(key: key);

  @override
  State<CountDownTimer> createState() => _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer> {
  Timer? countdownTimer;
  Duration myDuration = const Duration(days: 20);
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  /// Timer related methods ///
  void startTimer() {
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  void setCountDown() {
    const reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');

    final days = strDigits(myDuration.inDays);
    // Step 7
    final hours = strDigits(myDuration.inHours.remainder(24));
    final minutes = strDigits(myDuration.inMinutes.remainder(60));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));
    final countDownText = [
      days,
      hours,
      minutes,
      seconds,
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i <= 3; i++)
          Column(
            children: [
              Container(
                height: 100,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                margin: const EdgeInsets.symmetric(horizontal: 35),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0XFF516D61),
                  ),
                ),
                child: FittedBox(
                  child: Text(countDownText[i]),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                countDownDays[i],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0XFF516D61),
                ),
              ),
            ],
          ),
      ],
    );
  }
}

class TextFieldAndSubmitButton extends StatelessWidget {
  const TextFieldAndSubmitButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey.shade100,
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.45,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: const Color(0XFF516D61),
                  width: 1.5,
                ),
              ),
              child: const TextField(
                cursorHeight: 25,
                cursorColor: Color(0XFF516D61),
                cursorRadius: Radius.circular(10),
                keyboardType: TextInputType.emailAddress,
                mouseCursor: MouseCursor.uncontrolled,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: ' johndoe@gmail.com',
                  hintStyle: TextStyle(fontSize: 18),
                  alignLabelWithHint: true,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          AnimatedContainer(
            padding: const EdgeInsets.all(17),
            duration: const Duration(milliseconds: 500),
            decoration: BoxDecoration(
              color: const Color(0XFF516D61),
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Text(
              'Join Waitlist',
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}

class TopBar extends StatelessWidget {
  const TopBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.15,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SizedBox(
              height: 100,
              width: 150,
              child: Image.asset(
                'assets/images/png/Mind-Spa-Logo-Green.png',
                filterQuality: FilterQuality.high,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, right: 50),
            child: Image.asset(
              'assets/images/png/Frame 665.png',
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}

List countDownDays = ['Days', 'Hours', 'Minutes', 'Seconds'];
