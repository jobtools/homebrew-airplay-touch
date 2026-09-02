cask "airplay-touch" do
  version "1.5.24"
  sha256 "20f7d117384287b0208d041b7bf58fcc85f6ec8acb708fd3b2a0465d5030a775"

  url "https://github.com/jobtools/homebrew-tap/releases/download/airplay-touch-v#{version}/AirPlay-Touch-#{version}.dmg"
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
