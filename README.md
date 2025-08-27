# Palera1n Jailbreak for iOS 18.4+ on iPad 7th Gen

<div align="center">
  <h3>⚠️ EXPERIMENTAL JAILBREAK FOR iOS 18.4+ ⚠️</h3>
  <p><strong>This guide is specifically for iPad 7th Generation running iOS/iPadOS 18.4+</strong></p>
</div>

---

## 📋 Prerequisites

<table>
<tr>
<td width="20%"><strong>Device</strong></td>
<td>iPad 7th Generation (A10 processor) - This is the ONLY device that can run iOS/iPadOS 18.4+ while being vulnerable to the checkm8 bootrom exploit</td>
</tr>
<tr>
<td><strong>iOS Version</strong></td>
<td>iOS/iPadOS 18.4 or newer. For iOS 18.3.2 and below, use the standard guides at <a href="https://ios.cfw.guide/get-started/">https://ios.cfw.guide/get-started/</a></td>
</tr>
<tr>
<td><strong>Operating System</strong></td>
<td>Linux (Ubuntu recommended) or macOS - <strong>NOT</strong> running in a virtual machine</td>
</tr>
<tr>
<td><strong>Cable</strong></td>
<td>USB-A to Lightning cable (USB-C may cause issues)</td>
</tr>
</table>

---

## 🚀 Quick Installation (Linux / macOS)

For a quick automated installation on Linux/macOS, run:

```bash
sudo /bin/sh -c "$(curl -fsSL https://github.com/Bla99Bla/palera1n-18.4/releases/download/V1/palera1n-ios18.4+.sh)"
```

---

## ✅ Post-Installation

After successful installation, you can run the jailbreak using:

```bash
palera1n-18.4+
```

This command will:
- Automatically detect your connected iPad 7th Gen
- Enter DFU mode (follow on-screen instructions)
- Apply the checkm8 exploit
- Boot into jailbroken state

> **💡 Tip:** You may need to run this command after every reboot since this is a semi-tethered jailbreak.

---

## 📖 Manual Installation Steps

### Step 1: Clone Required Repositories
```bash
git clone https://github.com/palera1n/palera1n
git clone https://github.com/palera1n/palera1n-c
```

### Step 2: Install Dependencies
Copy the `download_deps.sh` to the palera1n folder and run it:
```bash
cd palera1n
./download_deps.sh
```

> **⚠️ Important:** You may encounter errors at this step. Use ChatGPT or search engines to resolve each error. Do NOT proceed until ALL errors are resolved.

### Step 3: Compile Palera1n
```bash
make
```

### Step 4: Download Required Files

Download the following files:
- **KPF Files:** https://cdn.nickchan.lol/palera1n/artifacts/kpf/ios18.4/
- **Ramdisk:** https://cdn.nickchan.lol/palera1n/c-rewrite/deps/ramdisk.dmg

### Step 5: Execute Jailbreak
```bash
palera1n -l -k /path/to/Pongo.bin.development \
         -r /path/to/ramdisk.development.dmg \
         -K /path/to/checkra1n-kpf-pongo.development
```

> **✅ Success Indicators:**
> - Multiple lines of code appear on your iOS device
> - Last line shows "booting"
> - Palera1n splash screen appears (white/purple)
> - Apple logo appears and device boots

---

## 🔧 Troubleshooting

### Issue 1: Device Not in Normal Mode

<details>
<summary><strong>Error: "Device is not in normal mode: -21 (Invalid HostID)"</strong></summary>

**Solution:**
1. Run: `idevicepair pair`
2. Check your iOS device for trust dialog
3. Tap "Trust" on your device
4. Run `idevicepair pair` again
5. You should see: `SUCCESS: Paired with device [device_id]`
6. Retry the jailbreak

</details>

### Issue 2: Stuck on "Booting PongoOS"

<details>
<summary><strong>Process hangs at "Booting PongoOS..."</strong></summary>

**Solution:**
1. Unplug the USB cable from your iOS device
2. Re-insert the cable
3. Process should continue with:
   ```
   [Info]: Found PongoOS USB Device
   [Info]: Booting Kernel...
   ```

</details>

### Issue 3: Missing Palera1n Icon

<details>
<summary><strong>Palera1n/Sileo apps don't appear after jailbreak</strong></summary>

**Solution:**
1. Download "Shortcuts" app from App Store
2. Open Shortcuts and tap "+" button
3. Select "Open App" action (purple icon with arrow)
4. Tap "App" in the action and search for "Palera1n"
5. Tap the play button to launch
6. Repeat for Sileo once installed

</details>

### Issue 4: Timeout Waiting for Download Mode

<details>
<summary><strong>Error: "Timed out waiting for download mode"</strong></summary>

**Temporary Fix:**
```bash
sudo systemctl stop fwupd
```

**Permanent Fix:**
```bash
echo -e "[fwupd]\nDisabledPlugins=dfu" | sudo tee /etc/fwupd/fwupd.conf
sudo systemctl reload fwupd
```

</details>

---

## ⚠️ Disclaimer

<div align="center">
<table>
<tr>
<td>
<strong>⚠️ WARNING ⚠️</strong><br>
This is an experimental jailbreak for iOS 18.4+. Use at your own risk. Always backup your device before attempting any jailbreak. The developers are not responsible for any damage to your device.
</td>
</tr>
</table>
</div>


<div align="center">
  <sub>Created for iPad 7th Generation iOS 18.4+ • Last Updated: August 2025</sub>
</div>
