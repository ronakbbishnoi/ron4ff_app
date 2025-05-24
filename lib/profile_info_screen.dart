import 'package:flutter/material.dart';

class ProfileInfoScreen extends StatelessWidget {
  final Map<String, dynamic> profileData;

  const ProfileInfoScreen({super.key, required this.profileData});

  // Helper function to safely extract values from nested maps
  String _getNestedValue(Map<String, dynamic> data, List<String> keys, {String defaultValue = 'N/A'}) {
    dynamic value = data;
    for (String key in keys) {
      if (value is Map<String, dynamic> && value.containsKey(key)) {
        value = value[key];
      } else {
        return defaultValue;
      }
    }
    return value?.toString() ?? defaultValue;
  }

  // Helper widget to build a consistent info row
  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              '$label:',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Theme.of(context).primaryColor),
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget to build a section title
  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Colors.white,
              fontSize: 26,
              decoration: TextDecoration.underline,
              decorationColor: Theme.of(context).primaryColor.withOpacity(0.5),
              decorationThickness: 2,
            ),
        textAlign: TextAlign.center,
      ),
    );
  }

  // Helper widget to build a consistent card
  Widget _buildCard(BuildContext context, Widget child) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final playerInfo = profileData['data']['player_info'] as Map<String, dynamic>?;
    final petInfo = profileData['data']['petInfo'] as Map<String, dynamic>?;
    final guildInfo = profileData['data']['guildInfo'] as Map<String, dynamic>?;

    // Retrieve the credits, which were modified in the previous screen
    final credits = profileData['credits']?.toString() ?? 'Unknown Credits';

    String nickname = _getNestedValue(playerInfo ?? {}, ['nikname'], defaultValue: 'Unknown Player');

    return Scaffold(
      appBar: AppBar(
        title: Text(nickname, style: const TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.transparent, // Make app bar transparent
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Player Info Section
            if (playerInfo != null)
              _buildCard(
                context,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle(context, 'Player Info'),
                    _buildInfoRow(context, 'Nickname', _getNestedValue(playerInfo, ['nikname'])),
                    _buildInfoRow(context, 'UID', _getNestedValue(playerInfo, ['uid'])),
                    _buildInfoRow(context, 'Level', _getNestedValue(playerInfo, ['level'])),
                    _buildInfoRow(context, 'Likes', _getNestedValue(playerInfo, ['likes'])),
                    _buildInfoRow(context, 'Region', _getNestedValue(playerInfo, ['region'])),
                    _buildInfoRow(context, 'Signature', _getNestedValue(playerInfo, ['signature'])),
                    _buildInfoRow(context, 'XP', _getNestedValue(playerInfo, ['exp'])),
                    _buildInfoRow(context, 'Honor Score', _getNestedValue(playerInfo, ['honor_score'])),
                    _buildInfoRow(context, 'BP Level', _getNestedValue(playerInfo, ['bp_level'])),
                    _buildInfoRow(context, 'CS Rank Points', _getNestedValue(playerInfo, ['cs_rank_points'])),
                    _buildInfoRow(context, 'BR Rank Points', _getNestedValue(playerInfo, ['br_rank_points'])),
                    _buildInfoRow(context, 'Release Version', _getNestedValue(playerInfo, ['release_version'])),
                    _buildInfoRow(context, 'Account Created', _getNestedValue(playerInfo, ['account_created'])),
                    _buildInfoRow(context, 'Last Login', _getNestedValue(playerInfo, ['last_login'])),
                  ],
                ),
              ),

            // Pet Info Section
            if (petInfo != null)
              _buildCard(
                context,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle(context, 'Pet Info'),
                    _buildInfoRow(context, 'Pet Name', _getNestedValue(petInfo, ['name'])),
                    _buildInfoRow(context, 'Pet Level', _getNestedValue(petInfo, ['level'])),
                    _buildInfoRow(context, 'Pet EXP', _getNestedValue(petInfo, ['exp'])),
                  ],
                ),
              ),

            // Guild Info Section
            if (guildInfo != null)
              _buildCard(
                context,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle(context, 'Guild Info'),
                    _buildInfoRow(context, 'Guild Name', _getNestedValue(guildInfo, ['name'])),
                    _buildInfoRow(context, 'Guild Level', _getNestedValue(guildInfo, ['level'])),
                    _buildInfoRow(context, 'Members', _getNestedValue(guildInfo, ['members'])),
                    _buildInfoRow(context, 'Owner Nickname', _getNestedValue(guildInfo, ['owner_basic_info', 'nickname'])),
                  ],
                ),
              ),

            // Credits Section
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              child: Text(
                'Credits: $credits',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white54, fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
