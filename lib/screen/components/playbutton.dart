import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class PlayButton extends StatefulWidget {
  final String id;
  final String url;

  const PlayButton({Key? key, required this.url, required this.id})
      : super(key: key);

  @override
  _PlayButtonState createState() => _PlayButtonState();
}

class _PlayButtonState extends State<PlayButton> {
  final player = AudioPlayer();
  bool _isPlaying = false;
  bool _isPaused = false;

  @override
  void dispose() {
    super.dispose();
    player.dispose();
  }

  void play() async {
    setState(() {
      _isPlaying = true;
    });
    await player.setUrl(widget.url);
    await player.play();
  }

  void pause() async {
    setState(() {
      _isPlaying = false;
      print(widget.url);
    });
    await player.pause();
  }

  void resume() async {
    setState(() {
      _isPlaying = true;
      print(widget.url);
    });

    await player.pause();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: MediaQuery.of(context).size.width * 0.07,
      padding: EdgeInsets.zero,
      icon: (_isPlaying)
          ? Icon(
              Icons.stop_circle_outlined,
              color: Colors.white,
            )
          : Icon(
              Icons.play_circle_filled_outlined,
              color: Colors.white,
            ),
      onPressed: () => _isPlaying
          ? pause()
          : _isPaused
              ? resume()
              : play(),
    );
  }
}
