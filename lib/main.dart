void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'A Players Club',
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF000000),
          secondary: Color(0xFFFFFFFF),
          tertiary: Color(0xFFAA6C23),
          onSurface: Color.fromARGB(255, 255, 255, 255),
          onPrimary: Color(0xFFFFFFFF),
          surface: Color(0xFF3A3A3A),
        ),
        fontFamily: 'Black Mango',
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final List<String> buttons = const [
    'Events',
    'Resources',
    'Mentors',
    'Accountability'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'A Players Club',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.grey,
            ),
          )
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.tertiary,
                Theme.of(context).colorScheme.primary
              ],
              begin: Alignment.topCenter,
              end: Alignment.center,
            ),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: Container(
            color: Theme.of(context).colorScheme.surface,
            padding: const EdgeInsets.symmetric(vertical: 4),
            alignment: Alignment.center,
            child: SizedBox(
              height: 48,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: buttons.length,
                  itemBuilder: (context, index) {
                    final text = buttons[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          text,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                  fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  }),
            ),
          ),
        ),
      ),
      body: const Center(
        child: Text('Welcome to the club!'),
      ),
    );
  }
}
