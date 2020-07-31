ARG VERSION=2.0.1
FROM cpoolerun/geolambda:${VERSION}

LABEL maintainer="Development Seed <info@developmentseed.org>"
LABEL authors="Matthew Hanson  <matt.a.hanson@gmail.com>"

ARG PYVERSION=3.8.3

# install Python
ENV \
    PYENV_ROOT=/root/.pyenv \
    PATH=/root/.pyenv/shims:/root/.pyenv/bin:$PATH

RUN \
    curl https://pyenv.run | bash; \
    CONFIGURE_OPTS="--enable-loadable-sqlite-extensions --enable-optimizations --with-openssl=${PREFIX}/openssl" \
        LD_RUN_PATH="${PREFIX}/openssl/lib" \
        LDFLAGS="-L/usr/local/sqlite/lib" \
        CPPFLAGS="-I/usr/local/sqlite/include" \
        pyenv install ${PYVERSION}; \
    pyenv global ${PYVERSION}; \
    pip install --upgrade pip

COPY requirements*.txt ./

RUN \
    pip install -r requirements-pre.txt; \
    pip install -r requirements.txt

COPY bin/* /usr/local/bin/
