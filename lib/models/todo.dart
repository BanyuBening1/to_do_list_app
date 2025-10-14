class Todo {
  int? id;
  String judul;
  String deskripsi;
  String kategori;
  String prioritas;
  DateTime? dueDate;
  bool selesai;

  Todo({
    this.id,
    required this.judul,
    required this.deskripsi,
    required this.kategori,
    required this.prioritas,
    this.dueDate,
    this.selesai = false,
  });

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'],
      judul: map['judul'],
      deskripsi: map['deskripsi'],
      kategori: map['kategori'],
      prioritas: map['prioritas'],
      dueDate: map['dueDate'] != null
          ? DateTime.tryParse(map['dueDate'])
          : null,
      selesai: map['selesai'] == 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'judul': judul,
      'deskripsi': deskripsi,
      'kategori': kategori,
      'prioritas': prioritas,
      'dueDate': dueDate?.toIso8601String(),
      'selesai': selesai ? 1 : 0,
    };
  }
}
