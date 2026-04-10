import 'package:url_launcher/url_launcher.dart';

class PlaybackHandoffRequest {
  const PlaybackHandoffRequest({
    required this.trackTitle,
    this.spotifyTrackId,
    this.appleMusicTrackId,
    this.youtubeVideoId,
  });

  final String trackTitle;
  final String? spotifyTrackId;
  final String? appleMusicTrackId;
  final String? youtubeVideoId;
}

class PlaybackHandoffService {
  Future<bool> launch({
    required String selectedPlatform,
    required PlaybackHandoffRequest request,
  }) async {
    return switch (selectedPlatform) {
      'Apple Music' => _launchAppleMusic(request),
      'YouTube Music' => _launchYoutubeMusic(request),
      _ => _launchSpotify(request),
    };
  }

  Future<bool> _launchSpotify(PlaybackHandoffRequest request) async {
    final appUri = request.spotifyTrackId == null
        ? null
        : Uri.parse('spotify:track:${request.spotifyTrackId}');
    final webUri = request.spotifyTrackId == null
        ? Uri.parse('https://open.spotify.com/search/${Uri.encodeComponent(request.trackTitle)}')
        : Uri.parse('https://open.spotify.com/track/${request.spotifyTrackId}');

    if (appUri != null) {
      final launched = await launchUrl(appUri, mode: LaunchMode.externalApplication);
      if (launched) {
        return true;
      }
    }

    return launchUrl(webUri, mode: LaunchMode.externalApplication);
  }

  Future<bool> _launchAppleMusic(PlaybackHandoffRequest request) async {
    final appUri = request.appleMusicTrackId == null
        ? null
        : Uri.parse('music://music.apple.com/song/${request.appleMusicTrackId}');
    final webUri = request.appleMusicTrackId == null
        ? Uri.parse('https://music.apple.com/us/search?term=${Uri.encodeComponent(request.trackTitle)}')
        : Uri.parse('https://music.apple.com/us/song/${request.appleMusicTrackId}');

    if (appUri != null) {
      final launched = await launchUrl(appUri, mode: LaunchMode.externalApplication);
      if (launched) {
        return true;
      }
    }

    return launchUrl(webUri, mode: LaunchMode.externalApplication);
  }

  Future<bool> _launchYoutubeMusic(PlaybackHandoffRequest request) async {
    final appUri = request.youtubeVideoId == null
        ? null
        : Uri.parse('https://music.youtube.com/watch?v=${request.youtubeVideoId}');
    final webUri = request.youtubeVideoId == null
        ? Uri.parse('https://music.youtube.com/search?q=${Uri.encodeComponent(request.trackTitle)}')
        : Uri.parse('https://music.youtube.com/watch?v=${request.youtubeVideoId}');

    if (appUri != null) {
      final launched = await launchUrl(appUri, mode: LaunchMode.externalApplication);
      if (launched) {
        return true;
      }
    }

    return launchUrl(webUri, mode: LaunchMode.externalApplication);
  }
}

class TrackHandoffIndex {
  static const Map<String, PlaybackHandoffRequest> byTrackTitle = {
    'City of Tears': PlaybackHandoffRequest(
      trackTitle: 'City of Tears',
      spotifyTrackId: '4uLU6hMCjMI75M1A2tKUQC',
      youtubeVideoId: 'dQw4w9WgXcQ',
    ),
    'Greenpath': PlaybackHandoffRequest(
      trackTitle: 'Greenpath',
      spotifyTrackId: '4uLU6hMCjMI75M1A2tKUQC',
      youtubeVideoId: 'dQw4w9WgXcQ',
    ),
    'Mantis Lords': PlaybackHandoffRequest(
      trackTitle: 'Mantis Lords',
      spotifyTrackId: '4uLU6hMCjMI75M1A2tKUQC',
      youtubeVideoId: 'dQw4w9WgXcQ',
    ),
    'Radiance': PlaybackHandoffRequest(
      trackTitle: 'Radiance',
      spotifyTrackId: '4uLU6hMCjMI75M1A2tKUQC',
      youtubeVideoId: 'dQw4w9WgXcQ',
    ),
  };

  static PlaybackHandoffRequest forTitle(String title) {
    return byTrackTitle[title] ?? PlaybackHandoffRequest(trackTitle: title);
  }
}
