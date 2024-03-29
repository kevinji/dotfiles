# Install Scoop
Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')

# Install packages
scoop bucket add extras
scoop install aria2 sudo
scoop config aria2-warning-enabled false
scoop install 7zip dark delta gcloud git mercurial mpv python ripgrep rustup zstd
