cask "airplay-touch" do
  version "1.5.21"
  sha256 "d013365d5dc61e667833cb24bcc002ea64284e882af9cebf192aa53301b748a2"

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
