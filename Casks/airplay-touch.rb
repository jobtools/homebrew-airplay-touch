cask "airplay-touch" do
  version "1.1.39"
  sha256 "c1887929d99eb7a4f07d4ed31052a8b138c1ebd6cbcdc47244e457990a3b7d63"

  url "https://github.com/jobtools/homebrew-tap/releases/download/airplay-touch-v#{version}/AirPlay-Touch-#{version}.zip"
  name "AirPlay Touch"
  desc "AirPlay receiver companion that pairs with the Android app"
  homepage "https://github.com/jobtools/homebrew-tap"

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
