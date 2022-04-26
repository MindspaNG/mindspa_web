part of coming_soon_view;

class _ComingSoonDesktop extends StatelessWidget {
  final ComingSoonViewModel viewModel;

  const _ComingSoonDesktop(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    height: 200,
                    width: 200,
                    child: Image.asset('assets/images/Mind-Spa-Logo-Green.png'),
                  ),
                ),
                const SizedBox(),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Mind-Spa is a platform for the rejuvenation of the mind',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30),
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 300),
              child: Text(
                'We are creating an avenue to provide access to holistic health and promote mental wellbeing towards the eradication of mental health problems in Africa by connecting users to the most relevant resources tailored to their mental health needs.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            const SizedBox(
              height: 70,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 300),
              child: FittedBox(
                child: Text(
                  'We are launching soon, join the waitlist to get notified',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i <= 3; i++)
                  Container(
                    height: 100,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey)),
                    child: const FittedBox(
                      child: Text('20'),
                    ),
                  ),
              ],
            ),
            // SizedBox(
            //   height: 150,
            //   width: double.infinity,
            //   child: Center(
            //     child: ListView.builder(
            //       itemCount: 1,
            //       scrollDirection: Axis.horizontal,
            //       itemBuilder: (context, index) => Container(
            //         padding: const EdgeInsets.symmetric(
            //             horizontal: 10, vertical: 10),
            //         margin: const EdgeInsets.symmetric(horizontal: 10),
            //         decoration: BoxDecoration(
            //             shape: BoxShape.circle,
            //             border: Border.all(color: Colors.grey)),
            //         child: const FittedBox(
            //           child: Text('20'),
            //         ),
            //       ),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
      // SingleChildScrollView(
      //   child: Column(
      //     mainAxisSize: MainAxisSize.max,
      //     children: [

      //     ],
      //   ),
      // )
    );
  }
}
