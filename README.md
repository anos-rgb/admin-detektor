# # Admin Detector by anos

Advanced SA-MP administration detection system with real-time monitoring and alert features.

## 🚨 Features

- **Real-time Admin Detection**: Continuously scans players for admin characteristics
- **Multi Keyword Detection**: Detects various admin roles (admin, mod, staff, etc.)
- **Color Based Detection**: Identifies special admin colors
- **Auto Alert System**: Automatic notifications when admins are detected
- **Customizable Settings**: Toggle on/off with `/adet` command
- **Join/Leave Notifications**: Alerts when admins connect/disconnect

## 🎮 Commands

| Command | Description |
|---------|-------------|
| `/adet` | Toggle detection system on/off |

## 🔧 Installation

1. Ensure you have **MonetLoader** installed on Android
2. Place `admin_detector.lua` in `/storage/emulated/0/Android/media/ro.alyn_sampmobile.game/monetloader/` folder
3. Launch GTA SA and connect to SA-MP server
4. Script auto-loads with notification

## ⚙️ How It Works

Detects admins based on:
- **Username Patterns** (contains admin keywords)
- **Nickname Colors** (special admin colors) 
- **Username Formatting** (brackets [ ] or underscores _)

## 🛡️ Safety Features

- **Random Scan Delay** (3000-5000ms) to avoid detection
- **Client-side Only** no game memory modification
- **Auto Cooldown** between warnings to prevent spam

## 📞 Contact

- **Discord**: anos.py
- **YouTube**: anosini

## ⚠️ Disclaimer

This script is for educational purposes only. Use at your own risk. The author is not responsible for any bans or penalties incurred.

## 📜 Changelog

### v1.5
- Initial release by anos
- Added color-based detection
- Improved keyword system
- Added join/leave notifications
- Random delay protection

---

**Note**: Specifically for Android MonetLoader. Windows/Linux not supported.
