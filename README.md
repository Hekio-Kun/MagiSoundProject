# 🎵 MagiSound — Nền tảng Nghe nhạc & Sáng tạo Trực tuyến (Music Streaming Platform)

> **MagiSound** là nền tảng streaming âm nhạc và không gian sáng tạo dành cho nghệ sĩ độc lập, người nghe nhạc và đội ngũ quản trị. Dự án được phát triển theo kiến trúc Full-stack hiện đại với **Spring Boot (Java 21+)**, **React 19 + TypeScript**, **PostgreSQL** và phong cách giao diện tối giản, trực quan (Spotify Light & Modern Monochrome).

---

## 📑 Mục lục
1. [Giới thiệu & Tính năng chính](#-giới-thiệu--tính-năng-chính)
2. [Công nghệ sử dụng (Tech Stack)](#-công-nghệ-sử-dụng-tech-stack)
3. [Yêu cầu hệ thống (Prerequisites)](#-yêu-cầu-hệ-thống-prerequisites)
4. [Hướng dẫn cài đặt Database (Database Setup)](#-hướng-dẫn-cài-đặt-database-database-setup)
5. [Hướng dẫn cấu hình & Chạy dự án (Quick Start)](#-hướng-dẫn-cấu-hình--chạy-dự-án-quick-start)
6. [Tài khoản mặc định để thử nghiệm](#-tài-khoản-mặc-định-để-thử-nghiệm)
7. [Cấu trúc thư mục dự án](#-cấu-trúc-thư-mục-dự-án-project-structure)
8. [Các biến môi trường cấu hình](#-các-biến-môi-trường-cấu-hình)
9. [Xử lý sự cố thường gặp (Troubleshooting)](#-xử-lý-sự-cố-thường-gặp-troubleshooting)

---

## 🌟 Giới thiệu & Tính năng chính

MagiSound phân chia rõ ràng các phân hệ tính năng theo 4 nhóm đối tượng:

### 1. 🎧 Dành cho Người nghe (Listener)
- **Khám phá âm nhạc (Explore & Catalog)**: Trải nghiệm các bài hát thịnh hành, album mới phát hành, bảng xếp hạng theo thể loại (Pop, Rap/Hip-hop, Ballad, R&B, Indie, Lofi, Rock, Electronic,...).
- **Trình phát nhạc nâng cao (Persistent Audio Player)**:
  - Hỗ trợ phát nhạc liên tục khi chuyển trang.
  - Tùy chỉnh âm lượng, thanh tiến trình (seekbar), chế độ xáo trộn (Shuffle), lặp lại (Repeat).
  - Quản lý **Hàng đợi phát nhạc (Play Queue)** linh hoạt theo ngữ cảnh (Album, Playlist hoặc kết quả tìm kiếm).
  - Hiển thị **Lời bài hát (Lyrics)** chính thức hoặc lời bài hát đồng bộ thời gian thực.
- **Tìm kiếm thông minh (Smart Header Search)**:
  - Thanh tìm kiếm tức thời trên thanh công cụ (Header Bar) với cơ chế tự động tìm sau khi gõ (debounce 250ms).
  - Lọc kết quả tìm kiếm theo Tất cả (All), Bài hát (Tracks), hoặc Nghệ sĩ (Creators).
  - Gợi ý từ khóa xu hướng một chạm (Sơn Tùng M-TP, HIEUTHUHAI, MCK, YOASOBI, Acoustic,...).
- **Thư viện cá nhân (Personal Library)**:
  - Lưu và quản lý danh sách **Bài hát yêu thích (Favorites)** chỉ với 1 click vào biểu tượng trái tim.
  - **Tạo và quản lý Playlist**: Tạo danh sách phát, thêm/bớt bài hát tùy ý.
  - **Lịch sử nghe nhạc (Listening History)**: Tự động ghi nhận lượt nghe và thời gian nghe thực tế.

### 2. 🎙️ Dành cho Nghệ sĩ & Người sáng tạo (Creator Studio)
- **Đăng tải âm nhạc (Music Upload)**:
  - Đăng tải file âm thanh (MP3, WAV, FLAC), ảnh bìa bài hát (Cover Art).
  - Tùy chỉnh thông tin: Tên bài hát, thể loại, thông tin phát hành, lời bài hát (Official Lyrics).
- **Content Studio & Quản lý bài hát**:
  - Theo dõi trạng thái kiểm duyệt bài hát: `Chờ duyệt (PENDING)` ➔ `Đã duyệt (APPROVED)` / `Bị từ chối (REJECTED)`.
  - Xem lý do phản hồi chi tiết từ ban kiểm duyệt nếu bài hát cần chỉnh sửa.
  - Quản lý danh sách tác phẩm đã phát hành, theo dõi tổng lượt nghe (Plays) theo thời gian thực.

### 3. 🛡️ Dành cho Nhân viên kiểm duyệt (Staff Moderation)
- **Moderation Workspace**:
  - Hàng đợi kiểm duyệt bài hát tập trung (Pending Submissions).
  - Nghe thử trực tiếp bài hát và xem toàn bộ metadata trước khi phê duyệt.
  - **Hành động duyệt**: Phê duyệt phát hành (Approve) hoặc Từ chối (Reject) kèm lý do chi tiết để thông báo cho Creator.
- **Xử lý khiếu nại & báo cáo (Content Reports)**: Xử lý các báo cáo vi phạm bản quyền hoặc nội dung không phù hợp từ cộng đồng.

### 4. ⚙️ Dành cho Quản trị viên hệ thống (Admin Dashboard)
- **Telemetry & Thống kê thời gian thực**:
  - Dữ liệu trực tiếp 100% từ PostgreSQL: Tổng người dùng, tổng bài hát đã duyệt, tổng lượt nghe catalog, số yêu cầu chờ duyệt.
  - Biểu đồ tăng trưởng tài khoản theo ngày (User Growth Chart).
  - Biểu đồ tỷ lệ phân bố vai trò (Role Distribution: Listeners, Creators, Staff, Admin).
  - Bảng xếp hạng **Top 5 / Top 10 bài hát có lượt nghe cao nhất** kèm ảnh bìa và thông tin tác giả.
  - Danh sách tài khoản đăng ký gần đây (Recent Accounts) với trạng thái xác thực.
- **Quản lý thể loại (Genre Management)**: Thêm mới thể loại âm nhạc, cập nhật mô tả, bật/tắt trạng thái hoạt động.
- **Quản lý nhân viên (Staff Management)**: Cấp quyền, quản lý tài khoản nhân viên kiểm duyệt.

---

## 🛠 Công nghệ sử dụng (Tech Stack)

| Thành phần | Công nghệ chính | Chi tiết / Thư viện |
| :--- | :--- | :--- |
| **Backend** | Java 21+ / Spring Boot 4.x | Spring Web MVC, Spring Security, Spring Data JPA, Hibernate, JJWT (JWT Auth) |
| **Frontend** | React 19 + TypeScript | Vite 8, CSS3 Native Variables, Responsive Design, HTML5 Audio API |
| **Database** | PostgreSQL 16+ / 18 | Quan hệ dữ liệu chuẩn hóa, Foreign Keys, Triggers, Sequence Auto-increment |
| **Authentication** | JWT Stateless Auth | Access Token (15m) + Secure Refresh Token (7d / 30d Remember Me) |
| **Email Service** | Spring Mail (JavaMail) | Gửi OTP kích hoạt tài khoản / đặt lại mật khẩu qua Gmail SMTP |

---

## 📋 Yêu cầu hệ thống (Prerequisites)

Trước khi bắt đầu, hãy đảm bảo máy tính của bạn đã cài đặt các công cụ sau:

1. **Java Development Kit (JDK)**: Phiên bản **Java 21 LTS** trở lên (Khuyên dùng OpenJDK 21 hoặc Java 25).
   - Kiểm tra bằng lệnh: `java -version`
2. **Node.js**: Phiên bản **v18.0+** hoặc **v20.0+** (kèm `npm`).
   - Kiểm tra bằng lệnh: `node -v` và `npm -v`
3. **PostgreSQL**: Phiên bản **PostgreSQL 15+** (Khuyên dùng bản 16, 17 hoặc 18).
   - Cổng mặc định: `5432`
   - Kiểm tra bằng lệnh: `psql -V`
4. *(Tùy chọn)* Công cụ quản lý Database trực quan: **DBeaver**, **pgAdmin 4**, hoặc **DataGrip**.

---

## 🗄️ Hướng dẫn cài đặt Database (Database Setup)

Dự án đã có sẵn file backup dữ liệu đầy đủ bao gồm **23 bảng dữ liệu**, các mối quan hệ (Foreign Keys), Sequence tự tăng, và dữ liệu mẫu phong phú (39 bài hát, 19 tài khoản, playlist, thể loại, lời bài hát,...).

File backup nằm tại:
- `backup/magisound_backup_with_data.sql`
- hoặc `magisound_backup_with_data.sql` *(ngay thư mục gốc)*

### Bước 1: Khởi động dịch vụ PostgreSQL
Đảm bảo dịch vụ PostgreSQL đang chạy trên máy (mặc định cổng `5432`).

### Bước 2: Tạo database mới có tên `magisound`

#### Cách 2.1: Sử dụng dòng lệnh (psql / Command Prompt / PowerShell)
```bash
# Mở psql với tài khoản postgres
psql -U postgres

# Nhập mật khẩu postgres của bạn, sau đó chạy lệnh SQL tạo database:
CREATE DATABASE magisound;

# Thoát psql
\q
```

#### Cách 2.2: Sử dụng DBeaver hoặc pgAdmin
- Mở **DBeaver** (hoặc pgAdmin) kết nối đến PostgreSQL Local.
- Chuột phải vào mục **Databases** ➔ chọn **Create New Database**.
- Đặt tên Database Name: `magisound` ➔ nhấn **Save** (hoặc **OK**).

---

### Bước 3: Nạp (Restore) toàn bộ dữ liệu vào Database

#### Cách 3.1: Dùng lệnh Terminal (Nhanh nhất & Tự động)
Mở cửa sổ dòng lệnh tại thư mục gốc của dự án `MagiSoundProject`:

- **Trên Windows (PowerShell):**
```powershell
# Gán biến mật khẩu postgres của bạn (ví dụ mật khẩu là 020105 hoặc postgres)
$env:PGPASSWORD = "020105"

# Chạy lệnh restore bằng pg_dump / psql (sửa đường dẫn nếu postgres nằm ở vị trí khác)
& "C:\Program Files\PostgreSQL\18\bin\psql.exe" -h localhost -U postgres -d magisound -f "backup\magisound_backup_with_data.sql"
```

- **Trên macOS / Linux:**
```bash
PGPASSWORD="mat_khau_postgres_cua_ban" psql -h localhost -U postgres -d magisound -f backup/magisound_backup_with_data.sql
```

#### Cách 3.2: Dùng DBeaver
1. Mở DBeaver và bấm đúp mở kết nối đến database `magisound`.
2. Trên thanh menu, chọn **SQL Editor** ➔ **Open SQL Script...** (hoặc nhấn `Ctrl + O`).
3. Chọn file `backup/magisound_backup_with_data.sql`.
4. Nhấn phím tắt **`Alt + X`** (hoặc bấm nút **Execute SQL Script** trên thanh công cụ).
5. Sau khi thanh tiến trình chạy xong, nhấn `F5` tại mục `Tables` để thấy đầy đủ 23 bảng đã được nạp.

---

### Bước 4: Kiểm tra kết nối trong `application.properties`
Mở file `backend/src/main/resources/application.properties` và đảm bảo thông tin khớp với máy của bạn:

```properties
spring.datasource.url=jdbc:postgresql://localhost:5432/magisound
spring.datasource.username=postgres
spring.datasource.password=020105   # <-- Thay đổi thành mật khẩu postgres trên máy bạn
```

> **Mẹo:** Bạn cũng có thể thiết lập biến môi trường hệ thống `DB_PASSWORD=mật_khẩu_của_bạn` mà không cần sửa file code.

---

## 🚀 Hướng dẫn cấu hình & Chạy dự án (Quick Start)

Dự án gồm 2 phần độc lập: **Backend** (Spring Boot) và **Frontend** (React Vite). Hãy mở 2 cửa sổ terminal riêng biệt.

### 1. Khởi động Backend (Spring Boot Server)

Mở Terminal thứ nhất tại thư mục dự án:

```bash
# 1. Di chuyển vào thư mục backend
cd backend

# 2. Khởi động ứng dụng bằng Maven Wrapper:
# Trên Windows:
.\mvnw.cmd spring-boot:run

# Trên macOS / Linux:
./mvnw spring-boot:run
```

Khi màn hình hiển thị:
```text
INFO ... Completed initialization in ... ms
Tomcat started on port 8088 (http) with context path '/'
```
➔ **Backend đã sẵn sàng hoạt động tại:** `http://127.0.0.1:8088`

---

### 2. Khởi động Frontend (React + TypeScript)

Mở Terminal thứ hai tại thư mục dự án:

```bash
# 1. Di chuyển vào thư mục frontend
cd frontend

# 2. Cài đặt các thư viện phụ thuộc (chỉ cần làm ở lần đầu tiên)
npm install

# 3. Khởi chạy máy chủ phát triển Vite:
npm run dev
```

Khi màn hình hiển thị:
```text
  VITE v8.x.x  ready in ... ms

  ➜  Local:   http://127.0.0.1:4174/
  ➜  Network: use --host to expose
```
➔ **Frontend đã sẵn sàng hoạt động tại:** `http://127.0.0.1:4174`

---

### 3. Truy cập ứng dụng
Mở trình duyệt web bất kỳ (Chrome, Edge, Brave, Firefox) và truy cập vào:
👉 **`http://127.0.0.1:4174`**

---

## 🔑 Tài khoản mặc định để thử nghiệm

Dữ liệu sao lưu đã bao gồm sẵn các tài khoản demo đại diện cho từng vai trò để bạn trải nghiệm ngay mà không cần tạo mới:

| Vai trò (Role) | Email đăng nhập | Mật khẩu | Quyền hạn & Mục đích thử nghiệm |
| :--- | :--- | :--- | :--- |
| **System Administrator (ADMIN)** | `admin@magisound.com` | `Admin@123456` | Toàn quyền quản trị hệ thống, xem System Dashboard thời gian thực, quản lý thể loại nhạc và nhân viên. |
| **Moderation Staff (STAFF)** | `staff@magisound.com` | `Staff@123456` | Kiểm duyệt bài hát mới tải lên (Approve / Reject kèm lý do), quản lý báo cáo vi phạm nội dung. |
| **Creator / Nghệ sĩ** | `truonganhtuan04072020@gmail.com` | `Password@123` | Nghệ sĩ sáng tạo: Upload nhạc, xem trạng thái kiểm duyệt, quản lý tác phẩm cá nhân. |
| **Người nghe (Listener)** | Bạn có thể tự đăng ký tự do tại mục **Sign Up** | Tuỳ chọn | Nghe nhạc, thả tim yêu thích, tạo playlist cá nhân, tìm kiếm bài hát. |

---

## 📂 Cấu trúc thư mục dự án (Project Structure)

```text
MagiSoundProject/
├── backup/
│   └── magisound_backup_with_data.sql     # File backup PostgreSQL đầy đủ schema và dữ liệu
├── magisound_backup_with_data.sql         # Bản sao lưu dự phòng tại root
│
├── backend/                               # Phân hệ Backend (Spring Boot 4.x, Java 21+)
│   ├── mvnw / mvnw.cmd                    # Maven Wrapper
│   ├── pom.xml                            # Quản lý dependencies dự án
│   └── src/
│       ├── main/
│       │   ├── java/group03/magisound/
│       │   │   ├── admin/                 # Thống kê, quản lý hệ thống, telemetry
│       │   │   ├── auth/                  # Đăng ký, đăng nhập, JWT, xác thực OTP, bảo mật
│       │   │   ├── catalog/               # Quản lý bài hát, albums, thể loại, tìm kiếm
│       │   │   ├── common/                # Exception handling, ApiResponse, Pagination
│       │   │   ├── config/                # Cấu hình Spring Security, CORS, Mail, Seeds
│       │   │   ├── creator/               # Upload nhạc, quản lý tác phẩm sáng tạo
│       │   │   ├── library/               # Yêu thích, danh sách phát (Playlist), lịch sử nghe
│       │   │   ├── lyrics/                # Lời bài hát chính thức & cá nhân
│       │   │   ├── moderation/            # Staff duyệt bài hát, xử lý báo cáo
│       │   │   └── notification/          # Thông báo người dùng & nhân viên
│       │   └── resources/
│       │       └── application.properties # Cấu hình database, JWT, SMTP mail, cổng port
│       └── test/                          # Unit tests & Integration tests
│
├── frontend/                              # Phân hệ Frontend (React 19, TypeScript, Vite 8)
│   ├── package.json                       # Scripts và thư viện dependencies
│   ├── vite.config.ts                     # Cấu hình Vite dev server & build
│   ├── index.html                         # Template HTML chính
│   └── src/
│       ├── api/                           # Tầng giao tiếp REST API (Axios / Fetch client)
│       ├── components/
│       │   ├── audio/                     # Persistent Audio Player, Seekbar, Queue, Lyrics
│       │   ├── common/                    # Music Cards, Modals, Buttons, Alerts
│       │   └── layout/                    # AppTopBar, Sidebar, Navigation
│       ├── pages/                         # Trang giao diện chính (Explore, Search, Admin,...)
│       ├── types/                         # TypeScript interfaces & types
│       ├── App.tsx                        # Entry-point router & context state
│       └── main.tsx                       # React DOM root render
│
└── README.md                              # Tài liệu hướng dẫn sử dụng chi tiết
```

---

## ⚙️ Các biến môi trường cấu hình

Bạn có thể tùy biến cấu hình hệ thống thông qua các biến môi trường hoặc trong `application.properties`:

| Tên biến (Env / Property) | Giá trị mặc định | Mô tả |
| :--- | :--- | :--- |
| `SERVER_PORT` | `8088` | Cổng hoạt động của máy chủ Backend REST API |
| `DB_URL` | `jdbc:postgresql://localhost:5432/magisound` | Đường dẫn kết nối cơ sở dữ liệu PostgreSQL |
| `DB_USERNAME` | `postgres` | Tên đăng nhập cơ sở dữ liệu |
| `DB_PASSWORD` | `020105` | Mật khẩu đăng nhập cơ sở dữ liệu |
| `ACCESS_TOKEN_MINUTES` | `15` | Thời hạn hiệu lực của JWT Access Token |
| `REFRESH_TOKEN_DAYS` | `7` | Thời hạn hiệu lực của Refresh Token thông thường |
| `REMEMBER_REFRESH_TOKEN_DAYS`| `30` | Thời hạn hiệu lực khi người dùng chọn "Remember Me" |
| `CORS_ALLOWED_ORIGINS` | `http://localhost:5173,http://localhost:4174,...` | Danh sách URL Frontend được phép gọi API |
| `MAIL_HOST` / `MAIL_PORT` | `smtp.gmail.com` / `587` | Cấu hình máy chủ gửi email kích hoạt và OTP |

---

## ❓ Xử lý sự cố thường gặp (Troubleshooting)

### 1. Lỗi kết nối Database `Connection refused` hoặc `FATAL: password authentication failed`
- **Nguyên nhân**: Dịch vụ PostgreSQL chưa chạy, hoặc sai mật khẩu `DB_PASSWORD` trong file `application.properties`.
- **Cách khắc phục**:
  1. Kiểm tra dịch vụ PostgreSQL trong `services.msc` (Windows) để chắc chắn đang ở trạng thái **Running**.
  2. Mở file `backend/src/main/resources/application.properties` và sửa `spring.datasource.password=mật_khẩu_của_bạn`.

### 2. Lỗi cổng (Port) đã bị chiếm dụng `Address already in use: bind`
- **Cổng 8088 (Backend)**: Đang có một tiến trình Java/Tomcat khác chạy ngầm.
  - Trên Windows PowerShell, chạy: `Get-Process -Name java | Stop-Process -Force` rồi khởi động lại backend.
- **Cổng 4174 (Frontend)**: Vite sẽ tự động chuyển sang cổng tiếp theo (ví dụ `4175`). Bạn có thể dừng tiến trình Node cũ bằng: `Get-Process -Name node | Stop-Process -Force`.

### 3. Lỗi CORS khi gọi API từ Frontend
- Nếu bạn chạy Frontend ở một cổng khác (ví dụ cổng `3000`), hãy mở `backend/src/main/resources/application.properties` và thêm cổng đó vào mục `app.security.allowed-origins`.

### 4. Lỗi âm thanh không phát được trên trình duyệt
- Một số bài hát sử dụng file nhạc cục bộ cần đảm bảo thư mục lưu trữ media tồn tại hoặc uploader tải file âm thanh hợp lệ (`.mp3`, `.wav`).
- Hãy kiểm tra kết nối mạng nếu bài hát lấy nguồn từ CDN bên ngoài.

---

## 👥 Đóng góp & Phát triển

Dự án được thực hiện bởi nhóm phát triển **MagiSound (Group 03)**.
Mọi thắc mắc hoặc yêu cầu hỗ trợ, vui lòng tạo Issue trên hệ thống quản lý mã nguồn của dự án. Chúc bạn có trải nghiệm nghe nhạc và sáng tạo tuyệt vời cùng MagiSound! 🎧✨
