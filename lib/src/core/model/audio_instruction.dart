import 'package:text_to_speech/text_to_speech.dart';
import 'instruction.dart';

/// A class that manages audio instructions using a text-to-speech (TTS) engine.
///
/// The `AudioInstruction` class handles a set of instructions and facilitates
/// audio output for each instruction through TTS. It provides properties to
/// manage the current instruction, list of all instructions, and an audio
/// toggle for enabling or disabling the TTS functionality.
class AudioInstruction {
  // Private fields

  /// The Text-to-Speech (TTS) engine used to convert instructions to audio.
  TextToSpeech _textToSpeech;

  /// A list of all instructions that can be output via TTS.
  List<Instruction> _instructionList;

  /// A list of unique identifiers for each instruction, used for indexing.
  List<String> _instructionIdentifiers;

  /// The currently selected instruction that can be output via TTS.
  Instruction _currentInstruction;

  /// A flag indicating whether audio is enabled for the instructions.
  bool _isAudioEnabled;

  /// Creates an instance of `AudioInstruction`.
  ///
  /// * [textToSpeech] - The TTS engine to use for audio output.
  /// * [instructionList] - Optional list of instructions to initialize with.
  /// * [instructionIdentifiers] - Optional list of unique identifiers.
  /// * [currentInstruction] - The instruction currently in focus.
  /// * [isAudioEnabled] - A flag indicating if audio is enabled.
  AudioInstruction({
    required TextToSpeech textToSpeech,
    required Instruction currentInstruction,
    required bool isAudioEnabled,
    List<Instruction>? instructionList,
    List<String>? instructionIdentifiers,
  })  : _textToSpeech = textToSpeech,
        _instructionList = instructionList ?? [],
        _instructionIdentifiers = instructionIdentifiers ?? [],
        _currentInstruction = currentInstruction,
        _isAudioEnabled = isAudioEnabled;

  // Getters and Setters

  /// Gets the current Text-to-Speech (TTS) engine.
  TextToSpeech get textToSpeech => _textToSpeech;

  /// Sets a new Text-to-Speech (TTS) engine.
  set textToSpeech(TextToSpeech value) => _textToSpeech = value;

  /// Gets the list of instructions.
  List<Instruction> get instructionList => _instructionList;

  /// Sets a new list of instructions.
  set instructionList(List<Instruction> value) => _instructionList = value;

  /// Gets the list of instruction identifiers.
  List<String> get instructionIdentifiers => _instructionIdentifiers;

  /// Sets a new list of instruction identifiers.
  set instructionIdentifiers(List<String> value) =>
      _instructionIdentifiers = value;

  /// Gets the current instruction in focus.
  Instruction get currentInstruction => _currentInstruction;

  /// Sets the current instruction in focus.
  set currentInstruction(Instruction value) => _currentInstruction = value;

  /// Gets the audio enable flag, indicating if audio output is enabled.
  bool get isAudioEnabled => _isAudioEnabled;

  /// Sets the audio enable flag to enable or disable audio output.
  set isAudioEnabled(bool value) => _isAudioEnabled = value;
}
