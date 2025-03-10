import 'package:flutter/material.dart';

class InAppNotification extends StatefulWidget {
  final String message;
  final Duration duration;

  const InAppNotification({
    super.key,
    required this.message,
    this.duration = const Duration(seconds: 3),
  });

  static void show(BuildContext context, String message) {
    OverlayState? overlay = Overlay.of(context);
    OverlayEntry? entry;

    entry = OverlayEntry(
      builder: (context) => Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: Material(
          color: Colors.transparent,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, -1),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: AnimationController(
                vsync: Navigator.of(context),
                duration: const Duration(milliseconds: 300),
              )..forward(),
              curve: Curves.easeOut,
            )),
            child: Container(
              padding: const EdgeInsets.only(
                top: kToolbarHeight + 20,
                left: 16,
                right: 16,
                bottom: 16,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.notifications,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          message,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          entry?.remove();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(entry);

    Future.delayed(const Duration(seconds: 3), () {
      entry?.remove();
    });
  }

  @override
  _InAppNotificationState createState() => _InAppNotificationState();
}

class _InAppNotificationState extends State<InAppNotification> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
