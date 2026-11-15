# ============================================================
# Fedora-bootc source
# ============================================================

ARG FEDORA_VERSION=45
ARG BASE_IMAGE=quay.io/fedora/fedora-bootc:${FEDORA_VERSION}
ARG FEDORA_SIGNING_KEY_ID=f577861e
ARG MITHRIL_VERSION=0.0.0-devel
ARG MITHRIL_BUILD_ID=local

FROM ${BASE_IMAGE}

# ============================================================
# Firmware, GNOME Desktop, and packages
# ============================================================

RUN set -eux \
    && : "Fedora Hardware Support packages" \
    && dnf -y group install "Hardware Support" --allow-downgrade --allowerasing --setopt=install_weak_deps=False \
    && : "Fedora GNOME Desktop packages" \
    && dnf install -y \
        avahi \
        baobab \
        dconf \
        gdm \
        glib-networking \
        glycin-thumbnailer \
        gnome-bluetooth \
        gnome-boxes \
        gnome-browser-connector \
        gnome-calculator \
        gnome-calendar \
        gnome-characters \
        gnome-color-manager \
        gnome-control-center \
        gnome-disk-utility \
        gnome-epub-thumbnailer \
        gnome-font-viewer \
        gnome-initial-setup \
        gnome-logs \
        gnome-session-wayland-session \
        gnome-settings-daemon \
        gnome-shell \
        gnome-text-editor \
        gnome-user-share \
        gst-thumbnailers \
        gvfs-afc \
        gvfs-afp \
        gvfs-archive \
        gvfs-fuse \
        gvfs-goa \
        gvfs-gphoto2 \
        gvfs-mtp \
        gvfs-smb \
        librsvg2 \
        localsearch \
        loupe \
        ModemManager \
        nautilus \
        NetworkManager-adsl \
        NetworkManager-openconnect-gnome \
        NetworkManager-openvpn-gnome \
        NetworkManager-ppp \
        NetworkManager-ssh-gnome \
        NetworkManager-vpnc-gnome \
        NetworkManager-wwan \
        PackageKit-command-not-found \
        PackageKit-gtk3-module \
        papers \
        papers-nautilus \
        polkit \
        ptyxis \
        snapshot \
        sushi \
        systemd-oomd-defaults \
        tinysparql \
        xdg-desktop-portal \
        xdg-desktop-portal-gnome \
        xdg-user-dirs-gtk \
    && : "Packages" \
    && dnf install -y \
        adw-gtk3-theme \
        bash-color-prompt \
        bash-completion \
        bluez \
        cairo \
        exfatprogs \
        fedora-flathub-remote \
        fuse-libs \
        gamemode \
        gdk-pixbuf2 \
        git \
        glibc-langpack-en \
        libcamera \
        libcamera-gstreamer \
        libcamera-ipa \
        libcamera-tools \
        libimobiledevice-utils \
        libratbag-ratbagd \
        libvirt \
        libvirt-client \
        libvirt-nss \
        mtr \
        NetworkManager-wifi \
        pipewire-libs-extra \
        pipewire-plugin-libcamera \
        rclone \
        rsync \
        symlinks \
        usbmuxd \
        uv \
        virt-manager \
    && dnf clean all

RUN sudo dnf config-manager addrepo --from-repofile=https://negativo17.org/repos/fedora-multimedia.repo
RUN sudo dnf config-manager setopt fedora-multimedia.priority=90

RUN set -eux \
    && : "negativo17 Codecs" \
    && dnf distro-sync -y --repo='fedora-multimedia' \
        ffmpeg \
        ffmpeg-libs \
        heif-pixbuf-loader \
        intel-gmmlib \
        intel-mediasdk \
        intel-vaapi-driver \
        libavcodec \
        libfdk-aac \
        libheif \
        libopenjph \
        libva \
        libva-intel-media-driver \
        libva-utils \
        mesa-dri-drivers \
        mesa-filesystem \
        mesa-libEGL \
        mesa-libGL \
        mesa-libgbm \
        mesa-va-drivers \
        mesa-vulkan-drivers \
        pipewire-libs-extra \
    && dnf clean all

RUN sudo dnf config-manager addrepo --from-repofile=https://negativo17.org/repos/fedora-steam.repo
RUN sudo dnf config-manager setopt fedora-steam.priority=90

RUN set -eux \
    && : "negativo17 Steam" \
    && dnf distro-sync -y --repo='fedora-steam' \
        steam
    && dnf clean all

# ============================================================
# Fonts
# ============================================================

ADD --chmod=0644 https://raw.githubusercontent.com/googlefonts/noto-emoji/v2.051/fonts/NotoColorEmoji.ttf /usr/share/fonts/noto-emoji/NotoColorEmoji.ttf
ADD --chmod=0644 https://github.com/uswds/public-sans/blob/develop/fonts/ttf/PublicSans-Black.ttf /usr/share/fonts/public-sans/PublicSans-Black.ttf
ADD --chmod=0644 https://github.com/uswds/public-sans/blob/develop/fonts/ttf/PublicSans-BlackItalic.ttf /usr/share/fonts/public-sans/PublicSans-BlackItalic.ttf
ADD --chmod=0644 https://github.com/uswds/public-sans/blob/develop/fonts/ttf/PublicSans-Bold.ttf /usr/share/fonts/public-sans/PublicSans-Bold.ttf
ADD --chmod=0644 https://github.com/uswds/public-sans/blob/develop/fonts/ttf/PublicSans-BoldItalic.ttf /usr/share/fonts/public-sans/PublicSans-BoldItalic.ttf
ADD --chmod=0644 https://github.com/uswds/public-sans/blob/develop/fonts/ttf/PublicSans-ExtraBold.ttf /usr/share/fonts/public-sans/PublicSans-ExtraBold.ttf
ADD --chmod=0644 https://github.com/uswds/public-sans/blob/develop/fonts/ttf/PublicSans-ExtraLight.ttf /usr/share/fonts/public-sans/PublicSans-ExtraLight.ttf
ADD --chmod=0644 https://github.com/uswds/public-sans/blob/develop/fonts/ttf/PublicSans-ExtraLightItalic.ttf /usr/share/fonts/public-sans/PublicSans-ExtraLightItalic.ttf
ADD --chmod=0644 https://github.com/uswds/public-sans/blob/develop/fonts/ttf/PublicSans-Italic.ttf /usr/share/fonts/public-sans/PublicSans-Italic.ttf
ADD --chmod=0644 https://github.com/uswds/public-sans/blob/develop/fonts/ttf/PublicSans-Light.ttf /usr/share/fonts/public-sans/PublicSans-Light.ttf
ADD --chmod=0644 https://github.com/uswds/public-sans/blob/develop/fonts/ttf/PublicSans-LightItalic.ttf /usr/share/fonts/public-sans/PublicSans-LightItalic.ttf
ADD --chmod=0644 https://github.com/uswds/public-sans/blob/develop/fonts/ttf/PublicSans-Medium.ttf /usr/share/fonts/public-sans/PublicSans-Medium.ttf
ADD --chmod=0644 https://github.com/uswds/public-sans/blob/develop/fonts/ttf/PublicSans-MediumItalic.ttf /usr/share/fonts/public-sans/PublicSans-MediumItalic.ttf
ADD --chmod=0644 https://github.com/uswds/public-sans/blob/develop/fonts/ttf/PublicSans-Regular.ttf /usr/share/fonts/public-sans/PublicSans-Regular.ttf
ADD --chmod=0644 https://github.com/uswds/public-sans/blob/develop/fonts/ttf/PublicSans-SemiBold.ttf /usr/share/fonts/public-sans/PublicSans-SemiBold.ttf
ADD --chmod=0644 https://github.com/uswds/public-sans/blob/develop/fonts/ttf/PublicSans-SemiBoldItalic.ttf /usr/share/fonts/public-sans/PublicSans-SemiBoldItalic.ttf
ADD --chmod=0644 https://github.com/uswds/public-sans/blob/develop/fonts/ttf/PublicSans-Thin.ttf /usr/share/fonts/public-sans/PublicSans-Thin.ttf
ADD --chmod=0644 https://github.com/uswds/public-sans/blob/develop/fonts/ttf/PublicSans-ThinItalic.ttf /usr/share/fonts/public-sans/PublicSans-ThinItalic.ttf
ADD --chmod=0644 https://github.com/productiontype/Newsreader/blob/master/fonts/static/ttf/Newsreader16pt-Bold.ttf /usr/share/fonts/newsreader/Newsreader16pt-Bold.ttf
ADD --chmod=0644 https://github.com/productiontype/Newsreader/blob/master/fonts/static/ttf/Newsreader16pt-BoldItalic.ttf /usr/share/fonts/newsreader/Newsreader16pt-BoldItalic.ttf
ADD --chmod=0644 https://github.com/productiontype/Newsreader/blob/master/fonts/static/ttf/Newsreader16pt-ExtraBold.ttf /usr/share/fonts/newsreader/Newsreader16pt-ExtraBold.ttf
ADD --chmod=0644 https://github.com/productiontype/Newsreader/blob/master/fonts/static/ttf/Newsreader16pt-ExtraBoldItalic.ttf /usr/share/fonts/newsreader/Newsreader16pt-ExtraBoldItalic.ttf
ADD --chmod=0644 https://github.com/productiontype/Newsreader/blob/master/fonts/static/ttf/Newsreader16pt-ExtraLight.ttf /usr/share/fonts/newsreader/Newsreader16pt-ExtraLight.ttf
ADD --chmod=0644 https://github.com/productiontype/Newsreader/blob/master/fonts/static/ttf/Newsreader16pt-Italic.ttf /usr/share/fonts/newsreader/Newsreader16pt-Italic.ttf
ADD --chmod=0644 https://github.com/productiontype/Newsreader/blob/master/fonts/static/ttf/Newsreader16pt-Light.ttf /usr/share/fonts/newsreader/Newsreader16pt-Light.ttf
ADD --chmod=0644 https://github.com/productiontype/Newsreader/blob/master/fonts/static/ttf/Newsreader16pt-LightItalic.ttf /usr/share/fonts/newsreader/Newsreader16pt-LightItalic.ttf
ADD --chmod=0644 https://github.com/productiontype/Newsreader/blob/master/fonts/static/ttf/Newsreader16pt-Medium.ttf /usr/share/fonts/newsreader/Newsreader16pt-Medium.ttf
ADD --chmod=0644 https://github.com/productiontype/Newsreader/blob/master/fonts/static/ttf/Newsreader16pt-MediumItalic.ttf /usr/share/fonts/newsreader/Newsreader16pt-MediumItalic.ttf
ADD --chmod=0644 https://github.com/productiontype/Newsreader/blob/master/fonts/static/ttf/Newsreader16pt-Regular.ttf /usr/share/fonts/newsreader/Newsreader16pt-Regular.ttf
ADD --chmod=0644 https://github.com/productiontype/Newsreader/blob/master/fonts/static/ttf/Newsreader16pt-SemiBold.ttf /usr/share/fonts/newsreader/Newsreader16pt-SemiBold.ttf
ADD --chmod=0644 https://github.com/productiontype/Newsreader/blob/master/fonts/static/ttf/Newsreader16pt-SemiBoldItalic.ttf /usr/share/fonts/newsreader/Newsreader16pt-SemiBoldItalic.ttf
ADD --chmod=0644 https://github.com/latofonts/lato-source/blob/master/build/Lato3Ita2M/ds-ufo/masters/Lato-BlackItalic.ttf /usr/share/fonts/lato/Lato-BlackItalic.ttf
ADD --chmod=0644 https://github.com/latofonts/lato-source/blob/master/build/Lato3Ita2M/ds-ufo/masters/Lato-BoldItalic.ttf /usr/share/fonts/lato/Lato-BoldItalic.ttf
ADD --chmod=0644 https://github.com/latofonts/lato-source/blob/master/build/Lato3Ita2M/ds-ufo/masters/Lato-HairlineItalic.ttf /usr/share/fonts/lato/Lato-HairlineItalic.ttf
ADD --chmod=0644 https://github.com/latofonts/lato-source/blob/master/build/Lato3Ita2M/ds-ufo/masters/Lato-HeavyItalic.ttf /usr/share/fonts/lato/Lato-HeavyItalic.ttf
ADD --chmod=0644 https://github.com/latofonts/lato-source/blob/master/build/Lato3Ita2M/ds-ufo/masters/Lato-Italic.ttf /usr/share/fonts/lato/Lato-Italic.ttf
ADD --chmod=0644 https://github.com/latofonts/lato-source/blob/master/build/Lato3Ita2M/ds-ufo/masters/Lato-LightItalic.ttf /usr/share/fonts/lato/Lato-LightItalic.ttf
ADD --chmod=0644 https://github.com/latofonts/lato-source/blob/master/build/Lato3Ita2M/ds-ufo/masters/Lato-MediumItalic.ttf /usr/share/fonts/lato/Lato-MediumItalic.ttf
ADD --chmod=0644 https://github.com/latofonts/lato-source/blob/master/build/Lato3Ita2M/ds-ufo/masters/Lato-SemiboldItalic.ttf /usr/share/fonts/lato/Lato-SemiboldItalic.ttf
ADD --chmod=0644 https://github.com/latofonts/lato-source/blob/master/build/Lato3Ita2M/ds-ufo/masters/Lato-ThinItalic.ttf /usr/share/fonts/lato/Lato-ThinItalic.ttf
ADD --chmod=0644 https://github.com/latofonts/lato-source/blob/master/build/Lato3Upr2M/ds-ufo/masters/Lato-Black.ttf /usr/share/fonts/lato/Lato-Black.ttf
ADD --chmod=0644 https://github.com/latofonts/lato-source/blob/master/build/Lato3Upr2M/ds-ufo/masters/Lato-Bold.ttf /usr/share/fonts/lato/Lato-Bold.ttf
ADD --chmod=0644 https://github.com/latofonts/lato-source/blob/master/build/Lato3Upr2M/ds-ufo/masters/Lato-Hairline.ttf /usr/share/fonts/lato/Lato-Hairline.ttf
ADD --chmod=0644 https://github.com/latofonts/lato-source/blob/master/build/Lato3Upr2M/ds-ufo/masters/Lato-Heavy.ttf /usr/share/fonts/lato/Lato-Heavy.ttf
ADD --chmod=0644 https://github.com/latofonts/lato-source/blob/master/build/Lato3Upr2M/ds-ufo/masters/Lato-Light.ttf /usr/share/fonts/lato/Lato-Light.ttf
ADD --chmod=0644 https://github.com/latofonts/lato-source/blob/master/build/Lato3Upr2M/ds-ufo/masters/Lato-Medium.ttf /usr/share/fonts/lato/Lato-Medium.ttf
ADD --chmod=0644 https://github.com/latofonts/lato-source/blob/master/build/Lato3Upr2M/ds-ufo/masters/Lato-Regular.ttf /usr/share/fonts/lato/Lato-Regular.ttf
ADD --chmod=0644 https://github.com/latofonts/lato-source/blob/master/build/Lato3Upr2M/ds-ufo/masters/Lato-Semibold.ttf /usr/share/fonts/lato/Lato-Semibold.ttf
ADD --chmod=0644 https://github.com/latofonts/lato-source/blob/master/build/Lato3Upr2M/ds-ufo/masters/Lato-Thin.ttf /usr/share/fonts/lato/Lato-Thin.ttf
ADD --chmod=0644 https://github.com/JetBrains/JetBrainsMono/blob/master/fonts/ttf/JetBrainsMono-Bold.ttf /usr/share/fonts/jetbrains-mono/JetBrainsMono-Bold.ttf
ADD --chmod=0644 https://github.com/JetBrains/JetBrainsMono/blob/master/fonts/ttf/JetBrainsMono-BoldItalic.ttf /usr/share/fonts/jetbrains-mono/JetBrainsMono-BoldItalic.ttf
ADD --chmod=0644 https://github.com/JetBrains/JetBrainsMono/blob/master/fonts/ttf/JetBrainsMono-ExtraBold.ttf /usr/share/fonts/jetbrains-mono/JetBrainsMono-ExtraBold.ttf
ADD --chmod=0644 https://github.com/JetBrains/JetBrainsMono/blob/master/fonts/ttf/JetBrainsMono-ExtraBoldItalic.ttf /usr/share/fonts/jetbrains-mono/JetBrainsMono-ExtraBoldItalic.ttf
ADD --chmod=0644 https://github.com/JetBrains/JetBrainsMono/blob/master/fonts/ttf/JetBrainsMono-ExtraLight.ttf /usr/share/fonts/jetbrains-mono/JetBrainsMono-ExtraLight.ttf
ADD --chmod=0644 https://github.com/JetBrains/JetBrainsMono/blob/master/fonts/ttf/JetBrainsMono-ExtraLightItalic.ttf /usr/share/fonts/jetbrains-mono/JetBrainsMono-ExtraLightItalic.ttf
ADD --chmod=0644 https://github.com/JetBrains/JetBrainsMono/blob/master/fonts/ttf/JetBrainsMono-Italic.ttf /usr/share/fonts/jetbrains-mono/JetBrainsMono-Italic.ttf
ADD --chmod=0644 https://github.com/JetBrains/JetBrainsMono/blob/master/fonts/ttf/JetBrainsMono-Light.ttf /usr/share/fonts/jetbrains-mono/JetBrainsMono-Light.ttf
ADD --chmod=0644 https://github.com/JetBrains/JetBrainsMono/blob/master/fonts/ttf/JetBrainsMono-LightItalic.ttf /usr/share/fonts/jetbrains-mono/JetBrainsMono-LightItalic.ttf
ADD --chmod=0644 https://github.com/JetBrains/JetBrainsMono/blob/master/fonts/ttf/JetBrainsMono-Medium.ttf /usr/share/fonts/jetbrains-mono/JetBrainsMono-Medium.ttf
ADD --chmod=0644 https://github.com/JetBrains/JetBrainsMono/blob/master/fonts/ttf/JetBrainsMono-MediumItalic.ttf /usr/share/fonts/jetbrains-mono/JetBrainsMono-MediumItalic.ttf
ADD --chmod=0644 https://github.com/JetBrains/JetBrainsMono/blob/master/fonts/ttf/JetBrainsMono-Regular.ttf /usr/share/fonts/jetbrains-mono/JetBrainsMono-Regular.ttf
ADD --chmod=0644 https://github.com/JetBrains/JetBrainsMono/blob/master/fonts/ttf/JetBrainsMono-SemiBold.ttf /usr/share/fonts/jetbrains-mono/JetBrainsMono-SemiBold.ttf
ADD --chmod=0644 https://github.com/JetBrains/JetBrainsMono/blob/master/fonts/ttf/JetBrainsMono-SemiBoldItalic.ttf /usr/share/fonts/jetbrains-mono/JetBrainsMono-SemiBoldItalic.ttf
ADD --chmod=0644 https://github.com/JetBrains/JetBrainsMono/blob/master/fonts/ttf/JetBrainsMono-Thin.ttf /usr/share/fonts/jetbrains-mono/JetBrainsMono-Thin.ttf
ADD --chmod=0644 https://github.com/JetBrains/JetBrainsMono/blob/master/fonts/ttf/JetBrainsMono-ThinItalic.ttf /usr/share/fonts/jetbrains-mono/JetBrainsMono-ThinItalic.ttf

RUN fc-cache -f -v

# ============================================================
# System configuration and theming
# ============================================================

COPY kargs.d/ /usr/lib/bootc/kargs.d/

COPY . /etc/mithril/
RUN cp -asf --remove-destination /etc/mithril/rootfs/. /

RUN dnf -y copr enable peterwu/rendezvous && \
    dnf -y install bibata-cursor-themes && \
    dnf clean all

RUN glib-compile-schemas /usr/share/glib-2.0/schemas

# ============================================================
# OS metadata
# ============================================================

ARG MITHRIL_VERSION
ARG MITHRIL_BUILD_ID

RUN printf '%s\n' \
    'NAME="Mithril"' \
    "VERSION=\"${MITHRIL_VERSION}\"" \
    'ID=mithril' \
    'ID_LIKE=fedora' \
    "VERSION_ID=\"${MITHRIL_VERSION}\"" \
    "BUILD_ID=\"${MITHRIL_BUILD_ID}\"" \
    "PRETTY_NAME=\"Mithril ${MITHRIL_VERSION}\"" \
    'HOME_URL="https://github.com/CatSlobber/mithril2"' \
    'DOCUMENTATION_URL="https://github.com/CatSlobber/mithril2"' \
    'BUG_REPORT_URL="https://github.com/CatSlobber/mithril2/issues"' \
    >/usr/lib/os-release \
    && ln -sfn ../usr/lib/os-release /etc/os-release \
    && rm -f /etc/system-release \
    && printf 'Mithril\n' >/etc/system-release

# ============================================================
# Initramfs
# ============================================================

RUN set -eux \
    && KERNEL_VERSION="$(find /usr/lib/modules \
        -mindepth 1 -maxdepth 1 -type d \
        -printf '%f\n' | head -n1)" \
    && env DRACUT_NO_XATTR=1 \
        dracut -vf "/usr/lib/modules/${KERNEL_VERSION}/initramfs.img" "${KERNEL_VERSION}"

# ============================================================
# Services and validation
# ============================================================

RUN systemctl enable \
    bluetooth.service \
    gdm.service \
    && systemctl set-default graphical.target

RUN bootc container lint
