with open('frontend/src/data.ts', 'r', encoding='utf-8') as f:
    content = f.read()

old_creators = '''const creators = {
  minh: { userId: 101, displayName: "Minh An", avatarUrl: avatar("#cffafe", "#0891b2", "MA") },
  lam: { userId: 102, displayName: "Lâm Mộc", avatarUrl: avatar("#fdf3e5", "#b4691e", "LM") },
  yen: { userId: 103, displayName: "Yên Chi", avatarUrl: avatar("#ffe4e6", "#e11d48", "YC") },
  kai: { userId: 104, displayName: "Kai Vũ", avatarUrl: avatar("#d1fae5", "#059669", "KV") },
  mck: { userId: 6, displayName: "MCK", avatarUrl: avatar("#fef08a", "#854d0e", "MCK") },
  hieuthuhai: { userId: 7, displayName: "HIEUTHUHAI ft. Marzuz", avatarUrl: avatar("#fed7aa", "#c2410c", "H22") },
  uyenlinh: { userId: 8, displayName: "Uyên Linh", avatarUrl: avatar("#fce7f3", "#be185d", "UL") },
  hngle: { userId: 9, displayName: "Hngle ft. Bảo Anh", avatarUrl: avatar("#e0e7ff", "#4338ca", "HB") },
  sontung: { userId: 10, displayName: "Sơn Tùng M-TP", avatarUrl: avatar("#dbeafe", "#1d4ed8", "ST") },
  yorushika: { userId: 11, displayName: "Yorushika", avatarUrl: avatar("#ccfbf1", "#0f766e", "YS") },
  yoko: { userId: 12, displayName: "Yoko Takahashi", avatarUrl: avatar("#ede9fe", "#6d28d9", "YT") },
  yoasobi: { userId: 13, displayName: "YOASOBI", avatarUrl: avatar("#fbcfe8", "#db2777", "YA") },
  hekio: { userId: 3, displayName: "Hekio", avatarUrl: avatar("#dbeafe", "#1d4ed8", "HK") },
};'''

new_creators = '''const creators = {
  minh: { userId: 20, displayName: "Minh An", avatarUrl: "https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=400&q=80" },
  lam: { userId: 102, displayName: "Lâm Mộc", avatarUrl: avatar("#fdf3e5", "#b4691e", "LM") },
  yen: { userId: 103, displayName: "Yên Chi", avatarUrl: avatar("#ffe4e6", "#e11d48", "YC") },
  kai: { userId: 104, displayName: "Kai Vũ", avatarUrl: avatar("#d1fae5", "#059669", "KV") },
  mck: { userId: 12, displayName: "MCK", avatarUrl: "https://res.cloudinary.com/dq0jm9tlt/image/upload/v1791565314/soundwave/tracks/covers/project-cover-baby-mck.webp" },
  hieuthuhai: { userId: 11, displayName: "HIEUTHUHAI", avatarUrl: "https://res.cloudinary.com/dq0jm9tlt/image/upload/v1791565335/soundwave/tracks/covers/project-cover-exit-sign-hieuthuhai.webp" },
  uyenlinh: { userId: 13, displayName: "Uyên Linh", avatarUrl: "https://res.cloudinary.com/dq0jm9tlt/image/upload/v1791565356/soundwave/tracks/covers/project-cover-giua-dai-lo-dong-tay.webp" },
  hngle: { userId: 14, displayName: "Hngle", avatarUrl: "https://res.cloudinary.com/dq0jm9tlt/image/upload/v1791565384/soundwave/tracks/covers/project-cover-tim-em-hngle-bao-anh.webp" },
  sontung: { userId: 10, displayName: "Sơn Tùng M-TP", avatarUrl: "https://res.cloudinary.com/dq0jm9tlt/image/upload/v1791565403/soundwave/tracks/covers/project-cover-noi-nay-co-anh.webp" },
  yorushika: { userId: 16, displayName: "Yorushika", avatarUrl: "https://res.cloudinary.com/dq0jm9tlt/image/upload/v1791565498/soundwave/tracks/covers/project-cover-haru-yorushika.webp" },
  yoko: { userId: 17, displayName: "Yoko Takahashi", avatarUrl: "https://res.cloudinary.com/dq0jm9tlt/image/upload/v1791565523/soundwave/tracks/covers/project-cover-a-cruel-angels-thesis.webp" },
  yoasobi: { userId: 15, displayName: "YOASOBI", avatarUrl: "https://res.cloudinary.com/dq0jm9tlt/image/upload/v1791565560/soundwave/tracks/covers/project-cover-yoru-ni-kakeru.webp" },
  yamazaki: { userId: 18, displayName: "Masayoshi Yamazaki", avatarUrl: "https://res.cloudinary.com/dq0jm9tlt/image/upload/v1791565463/soundwave/tracks/covers/project-cover-one-more-time-one-more-chance.webp" },
  lowg: { userId: 19, displayName: "Low G", avatarUrl: "https://res.cloudinary.com/dq0jm9tlt/image/upload/v1791565431/soundwave/tracks/covers/project-cover-laviem.webp" },
  hekio: { userId: 3, displayName: "Lê Hải Duy", avatarUrl: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=400&q=80" },
};'''

old_featured = '''export const featuredCreators: FeaturedCreator[] = [
  { ...creators.minh, avatarUrl: creators.minh.avatarUrl!, bio: "Acoustic melodies for slow, peaceful days.", publishedTracks: 12, followersCount: 4320 },
  { ...creators.lam, avatarUrl: creators.lam.avatarUrl!, bio: "Telling city stories through alternative pop.", publishedTracks: 9, followersCount: 3180 },
  { ...creators.yen, avatarUrl: creators.yen.avatarUrl!, bio: "Dream pop, blue seas, and distant skies.", publishedTracks: 7, followersCount: 2950 },
  { ...creators.kai, avatarUrl: creators.kai.avatarUrl!, bio: "Summer energy in every beat.", publishedTracks: 11, followersCount: 5120 },
  { ...creators.hekio, avatarUrl: creators.hekio.avatarUrl!, bio: "Creator on MagiSound.", publishedTracks: 10, followersCount: 6540 },
];'''

new_featured = '''export const featuredCreators: FeaturedCreator[] = [
  { ...creators.sontung, avatarUrl: creators.sontung.avatarUrl!, bio: "Ca sĩ, nhạc sĩ, nhà sản xuất âm nhạc V-Pop hàng đầu. Founder M-TP Entertainment.", publishedTracks: 2, followersCount: 95400 },
  { ...creators.hieuthuhai, avatarUrl: creators.hieuthuhai.avatarUrl!, bio: "Rapper thành viên nhóm nhạc GERDNANG. Chủ nhân album thành công 'Ai Cũng Phải Bắt Đầu Từ Đâu Đó'.", publishedTracks: 1, followersCount: 88200 },
  { ...creators.mck, avatarUrl: creators.mck.avatarUrl!, bio: "Rapper, ca sĩ, nhạc sĩ thuộc tổ đội RPT. Chủ nhân album đình đám '99%'.", publishedTracks: 1, followersCount: 76500 },
  { ...creators.yoasobi, avatarUrl: creators.yoasobi.avatarUrl!, bio: "Japanese music superduo composed of producer Ayase and vocalist ikura, turning novels into music.", publishedTracks: 1, followersCount: 125000 },
  { ...creators.yorushika, avatarUrl: creators.yorushika.avatarUrl!, bio: "Japanese rock duo consisting of producer n-buna and vocalist suis. Creators of nostalgic melodic themes.", publishedTracks: 1, followersCount: 92300 },
  { ...creators.lowg, avatarUrl: creators.lowg.avatarUrl!, bio: "Rapper thuộc Rapital, được mệnh danh là 'chủ tọa' với phong cách flow mượt mà đặc trưng.", publishedTracks: 1, followersCount: 64100 },
  { ...creators.uyenlinh, avatarUrl: creators.uyenlinh.avatarUrl!, bio: "Nữ ca sĩ sở hữu giọng hát nội lực, truyền cảm với các bản hit Ballad da diết.", publishedTracks: 1, followersCount: 45200 },
];'''

content_norm = content.replace('\r\n', '\n')
old_creators_norm = old_creators.replace('\r\n', '\n')
new_creators_norm = new_creators.replace('\r\n', '\n')
old_featured_norm = old_featured.replace('\r\n', '\n')
new_featured_norm = new_featured.replace('\r\n', '\n')

assert old_creators_norm in content_norm, 'old_creators not found'
assert old_featured_norm in content_norm, 'old_featured not found'

content_norm = content_norm.replace(old_creators_norm, new_creators_norm)
content_norm = content_norm.replace(old_featured_norm, new_featured_norm)

with open('frontend/src/data.ts', 'w', encoding='utf-8', newline='\r\n') as f:
    f.write(content_norm.replace('\n', '\r\n'))

print('Successfully updated frontend/src/data.ts!')
