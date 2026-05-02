cask "airplay-touch" do
  version "1.12"
  sha256 "98b466ce81864b1d37a92d49866a0ec2178c6266821728dacba6c9e13abf35b7"

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
