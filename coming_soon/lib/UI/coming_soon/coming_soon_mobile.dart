part of coming_soon_view;

class _ComingSoonMobile extends StatelessWidget {
  final ComingSoonViewModel viewModel;

  const _ComingSoonMobile(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.green,
          child: ElevatedButton(
            onPressed: viewModel.pingServer,
            child: Text('Ping'),
          ),
        ),
      ),
    );
  }
}
