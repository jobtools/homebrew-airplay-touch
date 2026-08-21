cask "airplay-touch" do
  version "1.5.20"
  sha256 "3881b37aeb38c6484e82b76bef76590fd6712b96ab7e1d318d7db3f9dec08a52"

  url "https://github.com/jobtools/homebrew-tap/releases/download/airplay-touch-v#{version}/AirPlay-Touch-#{version}.zip"
  name "AirPlay Touch"
  desc "AirPlay receiver companion that pairs with the Android app"
  homepage "https://github.com/jobtools/homebrew-tap"

  depends_on macos: :sonoma

  app "AirPlay Touch.app"

  uninstall quit: "com.airplaytouch.companion"

  caveats <<~CAVEATS
    The companion needs Accessibility permission to forward touch events.
  CAVEATS

  zap trash: [
    "~/Library/Application Support/AirPlay Touch",
  ]
end
