FROM amazonlinux:2

RUN yum update -y
RUN yum groupinstall "Development Tools" -y
RUN yum install -y glibc-langpack-ja ipa-pgothic-fonts.noarch wget tar gzip gcc make which

# タイムゾーンの設定
RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
    echo 'Asia/Tokyo' > /etc/timezone && \
    export TZ=Asia/Tokyo

# ロケールの設定
ENV LANG=ja_JP.UTF-8

RUN yum install -y install bzip2-devel libffi-devel
RUN yum install -y openssl11 openssl11-devel
RUN yum install -y zlib-devel bzip2 bzip2-devel readline-devel sqlite sqlite-devel tk-devel libffi-devel xz-devel

# Install pyenv
RUN git clone https://github.com/pyenv/pyenv.git ~/.pyenv
ENV HOME="/root"
ENV PATH="$HOME/.pyenv/bin:$PATH"
RUN echo 'eval "$(pyenv init --path)"' >> ~/.bashrc
RUN exec $SHELL
RUN source /root/.bashrc && pyenv install 3.11.7 \
    && pyenv global 3.11.7 \
    && pyenv global 3.11.7

# Install pip Selenium
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
RUN source /root/.bashrc && python3 get-pip.py \
    && pip3 install selenium==4.16.0
RUN rm get-pip.py

WORKDIR /usr/src
RUN yum install -y unzip && \
    wget "https://edgedl.me.gvt1.com/edgedl/chrome/chrome-for-testing/120.0.6099.71/linux64/chromedriver-linux64.zip" && \
    wget "https://edgedl.me.gvt1.com/edgedl/chrome/chrome-for-testing/120.0.6099.71/linux64/chrome-linux64.zip" && \
    unzip ./chromedriver-linux64.zip -d /opt/ && \
    unzip ./chrome-linux64.zip -d /opt/

RUN rm /usr/src/chromedriver-linux64.zip  \
    && rm /usr/src/chrome-linux64.zip

RUN yum install atk \
    at-spi2-atk \
    cups-libs \
    libdrm \
    libxkbcommon \
    libXcomposite \
    libXdamage \
    libXrandr \
    mesa-libgbm \
    pango \
    alsa-lib \
    -y