cask "airplay-touch" do
  version "1.5.23"
  sha256 "32d1e4d12e4dcd8d40bd894b8386e6c766dd8882ed22ff03fa0d63370dec7880"

  url "https://github.com/jobtools/homebrew-tap/releases/download/airplay-touch-v#{version}/AirPlay-Touch-#{version}.zip"
  name "AirPlay Touch"
  desc "AirPlay receiver companion that pairs with the Android app"
  homepage "https://apps.sskplay.com/airplay-touch/"

  depends_on macos: :sequoia

  app "AirPlay Touch.app"

  uninstall quit: "com.airplaytouch.companion"

  caveats <<~CAVEATS
    The companion needs Accessibility permission to forward touch events.
  CAVEATS

  zap trash: [
    "~/Library/Application Support/AirPlay Touch",
  ]
end
