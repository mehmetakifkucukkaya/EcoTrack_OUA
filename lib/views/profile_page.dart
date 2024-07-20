import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

//Todo: Sayfadaki tüm veriler veri tabanından gelecek.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            _buildStats(),
            _buildGallery(),
            _buildActivities(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: Colors.green[200],
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(
                'https://ps.w.org/user-avatar-reloaded/assets/icon-256x256.png?rev=2540745'), // Profil resmi URL'si
          ),
          const SizedBox(height: 8),
          const Text(
            'Mehmet Akif Küçükkaya',
            style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold),
          ),
          Text(
            '@mehmet.akif_',
            style: TextStyle(color: Colors.grey[900], fontSize: 16),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildProfileButton('Başarılar'),
              const SizedBox(width: 8),
              _buildProfileButton('Ayarlar'),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildProfileButton(String text) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blueAccent,
      ),
      child: Text(text),
    );
  }

  Widget _buildStats() {
    return Container(
      margin: const EdgeInsets.only(top: 18),
      color: Colors.blueGrey[100],
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStatItem('30k', 'Eco Puan'),
          _buildStatItem('260', 'Bağlantı'),
        ],
      ),
    );
  }

  Widget _buildStatItem(String count, String label) {
    return Column(
      children: [
        Text(
          count,
          style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(color: Colors.grey[600], fontSize: 16),
        ),
      ],
    );
  }

  //* Geri Dönüştürülen Maddelerin Galerisi.

  Widget _buildGallery() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Gallery',
            style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            children: List.generate(4, (index) {
              return Container(
                color: Colors.grey[300],
                child: Image.network(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSsER5sOvrb9egZgfERYJmoaWf4btRYoY2ynQ&s',
                  fit: BoxFit.cover,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  //* Geçmişte Yapılan Aktiviteler
  //TODO: (Son 3 Aktivite gözüksün sadece. Üzerine tıklanınca tamamının gözüktüğü liste açılsın)
  Widget _buildActivities() {
    return Container(
      color: Colors.grey[300],
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Activities',
            style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 4),
                child: ListTile(
                  title: const Text('Pet geri dönüştürüldü'),
                  subtitle: const Text('5 puan kazandınız'),
                  trailing: Text('${index + 2} saat önce'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
