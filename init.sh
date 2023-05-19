set -e
function addToFile() {
    LINE=$1
    FILE=$2
    grep -Fqsx -- "$LINE" "$FILE" || echo "$LINE" | sudo tee --append "$FILE"
}

function archPackages() {
    cd ~/dots3/yay
    yay -Syu --noconfirm - < 'archPackages.txt'
}

function cloneDots() {
    echo 'cloning dots'
    git clone https://github.com/dannywexler/dots3.git ~/dots3
    cd ~/dots3
    ./dotter -vf
    echo 'updating font cache'
    fc-cache -f -v > /dev/null
    git clone https://github.com/dannywexler/neovim.git ~/.config/nvim
    archPackages
}

function connectToNas() {
    echo 'connectToNas'
    sudo mkdir -p /nas/archives
    addToFile '192.168.0.248:/mnt/user/archives /nas/archives nfs defaults 0 0' /etc/fstab
    sudo mkdir -p /nas/general
    addToFile '192.168.0.248:/mnt/user/general /nas/general nfs defaults 0 0' /etc/fstab
    sudo mkdir -p /nas/media
    addToFile '192.168.0.248:/mnt/user/media /nas/media nfs defaults 0 0' /etc/fstab
    sudo mkdir -p /nas/vms
    addToFile '192.168.0.248:/mnt/user/vms /nas/vms nfs defaults 0 0' /etc/fstab
}

function homeFolderCleanup() {
    echo 'homeFolderCleanup'
    rm -rf $HOME/Desktop/
    mv $HOME/Documents/ $HOME/docs
    mv $HOME/Downloads/ $HOME/dls
    rm -rf $HOME/Music/
    rm -rf $HOME/Pictures/
    rm -rf $HOME/Videos/
}


function loadGnome() {
    dconf load /org/gnome/ < ~/dots3/gnome/gnome.conf
}

cloneDots
connectToNas
homefoldercleanup
loadGnome
