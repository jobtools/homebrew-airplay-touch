cask "airplay-touch" do
  version "1.5"
  sha256 "f82d7f2f58d39ba0c96c60bca9e7192dc90c34d5469f18c6f65857305593b8a7"

  url "https://github.com/jobtools/airplay-android/releases/download/mac-v#{version}/AirPlay-Touch-mac-v#{version}.zip"
  name "AirPlay Touch"
  desc "AirPlay receiver companion that pairs with the Android app"
  homepage "https://github.com/jobtools/airplay-android"

  depends_on macos: ">= :sonoma"

  app "AirPlay Touch.app"

  uninstall quit: "com.airplaytouch.companion"

  postflight do
    # Strip the quarantine attribute so Sequoia does not refuse first launch.
    [
      "#{staged_path}/AirPlay Touch.app",
      "#{appdir}/AirPlay Touch.app",
    ].each do |path|
      system_command "/usr/bin/xattr",
                     args: ["-dr", "com.apple.quarantine", path],
                     must_succeed: false
    end
  end

  caveats <<~CAVEATS
    AirPlay Touch is self-signed (not Apple-notarized).

    Quarantine is removed automatically on install. If macOS still refuses
    to open the app, allow it via System Settings → Privacy & Security →
    "Open Anyway" once.

    The companion needs Accessibility permission to forward touch events.
  CAVEATS

  zap trash: [
    "~/Library/Application Support/AirPlay Touch",
  ]
end
