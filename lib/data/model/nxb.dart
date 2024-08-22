// Định nghĩa class Publisher
class NXB {
  String id;
  String name;

  NXB({
    required this.id,
    required this.name,
  });
}

 String findPublisherNameById(String id) {
   List<NXB> publishers = [
    NXB(id: '6694a87c23b80a4fead0a148', name: 'Nhã Nam'),
    NXB(id: '6694a87c23b80a4fead0a149', name: 'Đinh Tị'),
    NXB(id: '6694a87c23b80a4fead0a14a', name: 'Kim Đồng'),
    NXB(id: '6694a87c23b80a4fead0a14b', name: 'IPM'),
    NXB(id: '6694a87c23b80a4fead0a14c', name: 'NXB Hội Nhà Văn'),
    NXB(id: '6694a87c23b80a4fead0a14d', name: 'Dân Trí'),
    NXB(id: '6694a87c23b80a4fead0a14e', name: 'NXB Trẻ'),
    NXB(id: '6694a87c23b80a4fead0a14f', name: 'NXB Văn Học'),
    NXB(id: '6694a87c23b80a4fead0a150', name: 'Phụ Nữ Việt Nam'),
    NXB(id: '6694a87c23b80a4fead0a151', name: 'Thanh Niên'),
    NXB(id: '6694a87c23b80a4fead0a152', name: 'NXB Thế Giới'),
    NXB(id: '6694a87c23b80a4fead0a153', name: 'Lao Động'),
    NXB(id: '6694a87c23b80a4fead0a154', name: 'NXB Thanh Hóa'),
    NXB(id: '6694a87c23b80a4fead0a155', name: 'NXB Hồng Đức'),
    NXB(id: '6694a87c23b80a4fead0a156', name: 'NXB Tổng Hợp'),
    NXB(id: '6694a87c23b80a4fead0a157', name: 'Thái Hà'),
  ];

   NXB? foundPublisher = publishers.firstWhere((pub) => pub.id == id);
   return foundPublisher?.name ?? 'Chưa có';
}

