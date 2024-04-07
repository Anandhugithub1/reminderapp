import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:reminderapp/common/pallete.dart';

class CustomDropdownButton extends StatefulWidget {
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final String label;
  final String? values;
  final bool displayAudioLabels;

  const CustomDropdownButton({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.label,
    this.displayAudioLabels = false,
    this.values,
  });

  @override
  State<CustomDropdownButton> createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  late AudioPlayer _player;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButtonFormField<String>(
        value: widget.value,
        items: widget.items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: widget.displayAudioLabels
                ? Row(
                    children: [
                      Text('Audio ${widget.items.indexOf(value) + 1}'),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(1, 0, 0, 4),
                        child: IconButton(
                          icon: const Icon(Icons.play_arrow),
                          onPressed: () {
                            _player.play(UrlSource(value));
                          },
                        ),
                      ),
                    ],
                  )
                : Text(value),
          );
        }).toList(),
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          labelText: widget.label,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Pallete.borderColor,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Pallete.gradient2,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
        ),
      ),
    );
  }
}
