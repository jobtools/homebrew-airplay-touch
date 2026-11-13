cask "airplay-touch" do
  version "1.6.11"
  sha256 "b1d112fe6166dedb3a33d1e7476f469229110f8a86c5e4c2a3f7731dcd18ec82"

  url "https://github.com/jobtools/homebrew-tap/releases/download/airpair-touch-v#{version}/AirPair-Touch-#{version}.dmg"
  name "AirPair Touch"
  desc "Screen mirroring receiver companion that pairs with the Android app"
  homepage "https://apps.sskplay.com/airpair-touch/"

  depends_on macos: :sequoia

  app "AirPair Touch.app"

  uninstall quit: "com.airplaytouch.companion"

  caveats <<~CAVEATS
    The companion needs Accessibility permission to forward touch events.
  CAVEATS

  zap trash: [
    "~/Library/Application Support/AirPair Touch",
    "~/Library/Application Support/AirPlay Touch",
  ]
end
