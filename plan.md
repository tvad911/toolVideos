# PROJECT PLAN: PACKSTATION STANDALONE (EVIDENCE RECORDER)
**Type:** Standalone Desktop Application  
**Platform:** Ubuntu 22.04/24.04 (Recommended) / Windows 10/11  
**Tech Stack:** Flutter (Dart) + SQLite (Drift) + FFmpeg Core

---

## 1. TỔNG QUAN DỰ ÁN
*   **Mục tiêu:** Xây dựng phần mềm chuyên dụng để ghi hình quy trình đóng gói/khui hàng, phục vụ việc khiếu nại và đối soát TMĐT.
*   **Đặc điểm cốt lõi:**
    *   **Độc lập hoàn toàn:** Không kết nối POS, không kết nối CMS/Server. Dữ liệu nằm tại máy.
    *   **Record-First:** Ưu tiên quay trước, xử lý thông tin sau. Đảm bảo tốc độ làm việc liên tục của nhân viên kho.
    *   **Multi-Camera:** Hỗ trợ ghi hình đồng thời từ nhiều góc (Toàn cảnh + Chi tiết).
    *   **Low-Spec Optimized:** Chạy tốt trên máy tính cấu hình thấp (Intel N-series) nhờ tối ưu hóa phần cứng H.264.

---

## 2. LUỒNG HOẠT ĐỘNG (WORKFLOW)

### A. Màn hình Chờ (Live View)
*   Hiển thị hình ảnh từ các Camera theo thời gian thực (Layout PiP hoặc Grid).
*   Hiển thị thông số từ Cân điện tử (nếu có kết nối).
*   Trạng thái: "Sẵn sàng".

### B. Quy trình Quay & Đánh dấu (Core Process)
1.  **Kích hoạt:** Nhân viên bấm phím tắt (Space) hoặc nút "REC".
2.  **Khởi tạo Phiên (Session):**
    *   Hệ thống tạo `Session ID` (Ví dụ: `20260102_001`).
    *   **Chụp ngay 1 ảnh Thumbnail** từ Camera chính (Lưu làm ảnh đại diện để tìm kiếm nhanh).
3.  **Ghi hình (Recording):**
    *   FFmpeg bắt đầu ghi hình nền.
    *   Overlay (Lớp phủ video): Ngày giờ + Số thứ tự phiên + Cân nặng hiện tại.
4.  **Đánh dấu (Tagging) - Có thể làm lúc quay hoặc sau:**
    *   Nhân viên dùng máy quét mã vạch quét lên đơn hàng.
    *   Hệ thống ghi nhận mã barcode đó, liên kết với Session đang quay.
    *   *Lưu ý:* Có thể quét nhiều mã (Mã đơn, Mã vận đơn, IMEI sản phẩm) trong 1 phiên.
5.  **Kết thúc:**
    *   Bấm "STOP". Video được lưu xuống ổ cứng.
    *   Hệ thống tự động reset về trạng thái Sẵn sàng cho đơn tiếp theo.

### C. Quy trình Tra cứu & Xuất
*   Màn hình danh sách hiển thị dạng Lưới ảnh (dùng Thumbnail đã chụp ở bước B2).
*   Ô tìm kiếm: Nhập mã vận đơn (đã quét) hoặc tìm theo ngày/giờ.
*   Chức năng: Xem lại video, Export video ra file MP4 (để gửi khiếu nại).

---

## 3. THIẾT KẾ CƠ SỞ DỮ LIỆU (SQLITE)

Không cần quan hệ phức tạp, tập trung vào lưu trữ Log.

### Bảng `Sessions` (Phiên làm việc)
*   `id`: INTEGER PRIMARY KEY AUTOINCREMENT.
*   `uuid`: TEXT (Định danh duy nhất).
*   `created_at`: DATETIME (Thời điểm bắt đầu).
*   `ended_at`: DATETIME (Thời điểm kết thúc).
*   `duration_seconds`: INTEGER.
*   `thumbnail_path`: TEXT (Đường dẫn ảnh chụp lúc bắt đầu).
*   `video_path`: TEXT (Đường dẫn file video MP4).
*   `file_size_mb`: REAL.
*   `storage_location`: TEXT (Ví dụ: 'DISK_1', 'NAS').

### Bảng `SessionTags` (Các mã đã quét)
*   `id`: INTEGER PRIMARY KEY.
*   `session_id`: Link tới bảng Sessions.
*   `barcode_content`: TEXT (Nội dung mã vạch: Mã vận đơn, Mã đơn hàng...).
*   `scanned_at`: DATETIME (Thời điểm quét).
*   `weight_at_scan`: REAL (Cân nặng tại thời điểm quét - nếu có).

### Bảng `Settings` (Cấu hình)
*   `camera_configs`: JSON (Danh sách ID camera, độ phân giải).
*   `storage_path`: TEXT (Thư mục lưu video).
*   `watermark_text`: TEXT (Tên shop in lên video).
*   `hardware_acceleration`: TEXT ('QSV', 'NVENC', 'CPU').

---

## 4. CHI TIẾT KỸ THUẬT (VIDEO ENGINE)

Sử dụng mô hình **Process Wrapper** để gọi FFmpeg.

### A. Input Strategy
*   Hỗ trợ tối thiểu 2 Camera, tối đa 4 Camera.
*   **Camera Chính:** Góc rộng, bao quát bàn đóng hàng.
*   **Camera Phụ:** Góc cận (Macro) để soi rõ mã vận đơn và ngoại quan sản phẩm.

### B. Processing & Layout
*   Sử dụng `filter_complex` của FFmpeg để trộn hình:
    *   Layout: **Picture-in-Picture (PiP)**.
    *   Camera chính: Full màn hình.
    *   Camera phụ: Thu nhỏ đặt góc phải.
*   **Watermark:** Burn cứng text (Ngày giờ + Session ID) vào video để đảm bảo tính pháp lý.

### C. Encoding Optimization (H.264)
*   **Target:** File nhẹ nhất có thể nhưng vẫn đọc được chữ trên đơn hàng.
*   **Codec:** H.264 (AVC).
*   **FPS:** 20 - 24 FPS.
*   **Bitrate:** VBR (Variable Bitrate) - Tự động giảm khi hình tĩnh, tăng khi có chuyển động.
*   **Hardware Flags (Quan trọng cho máy yếu):**
    *   Intel CPU (N5095/N100): `-c:v h264_qsv` (Intel QuickSync).
    *   Nvidia GPU (GTX 1050): `-c:v h264_nvenc`.
    *   CPU thường: `-c:v libx264 -preset ultrafast`.

---

## 5. TÍCH HỢP PHẦN CỨNG

### A. Máy quét mã vạch (Barcode Scanner)
*   **Chế độ:** Keyboard Mode (HID).
*   **Xử lý:** App lắng nghe sự kiện phím toàn cục (Global Key Listener).
*   **Logic:** Khi nhận chuỗi ký tự kết thúc bằng `Enter` -> Lưu vào bảng `SessionTags`.

### B. Cân điện tử (Digital Scale)
*   **Giao tiếp:** Cổng Serial (COM/RS232) hoặc USB-to-Serial.
*   **Protocol:** Đọc stream dữ liệu liên tục (Ví dụ chuỗi `ST,GS,+  1.50kg`).
*   **Hiển thị:** Hiển thị số kg to rõ trên giao diện quay phim.

---

## 6. YÊU CẦU CẤU HÌNH (RECOMMENDED SPECS)

### Phương án 1: Tiết kiệm (Intel N-Series)
*   **CPU:** Intel N100 hoặc N5095/N5105.
*   **GPU:** Intel UHD Graphics (Tận dụng QuickSync).
*   **RAM:** 8GB DDR4/DDR5.
*   **Lưu trữ:** SSD 256GB (OS + Cache) + HDD 2TB (Data).
*   **OS:** Ubuntu 24.04 LTS (Tối ưu driver Intel Media).

### Phương án 2: Hiệu năng cao (PC cũ + Card rời)
*   **CPU:** Core i3/i5 (Gen 4 trở lên).
*   **GPU:** NVIDIA GTX 1050 / 1050Ti / 1650.
*   **RAM:** 8GB.
*   **Lưu trữ:** SSD + HDD.
*   **OS:** Windows 10 hoặc Ubuntu.

---

## 7. LỘ TRÌNH PHÁT TRIỂN (ROADMAP)

### Phase 1: Core Recorder (Tháng 1)
*   Xây dựng giao diện Flutter Desktop.
*   Kết nối Camera, hiển thị Preview.
*   Viết module FFmpeg Wrapper (Quay, Dừng, Lưu file).
*   Lưu database SQLite `Sessions`.

### Phase 2: Metadata & Scanner (Tháng 1.5)
*   Xử lý sự kiện máy quét mã vạch -> Lưu `SessionTags`.
*   Chức năng chụp Thumbnail tự động khi bấm Start.
*   Overlay text lên video.

### Phase 3: Hardware & Search (Tháng 2)
*   Kết nối Cân điện tử (Serial Port).
*   Xây dựng màn hình "Thư viện video" (Gallery): Tìm kiếm, Xem lại, Lọc theo mã đơn.

### Phase 4: Advanced Features (Tương lai)
*   Tự động xóa video cũ quá 30 ngày.
*   Đồng bộ file video lên Google Drive/Synology (Chạy nền).