ARG VERSION=2.0.1
FROM cpoolerun/geolambda:${VERSION}

LABEL maintainer="Development Seed <info@developmentseed.org>"
LABEL authors="Matthew Hanson  <matt.a.hanson@gmail.com>"

ARG PYVERSION=3.7.4

RUN yum install -y rsync;

# install Python
ENV \
    PYENV_ROOT=/root/.pyenv \
    PATH=/root/.pyenv/shims:/root/.pyenv/bin:$PATH

RUN \
    curl https://pyenv.run | bash; \
    CONFIGURE_OPTS="--enable-loadable-sqlite-extensions --enable-optimizations --with-openssl=${PREFIX}/openssl" \
        LD_RUN_PATH="${PREFIX}/openssl/lib" \
        LDFLAGS="-L/usr/local/lib" \
        CPPFLAGS="-I/usr/local/include" \
        pyenv install ${PYVERSION}; \
    pyenv global ${PYVERSION}; \
    pip install --upgrade pip

COPY requirements*.txt ./

RUN \
    pip install -r requirements-pre.txt; \
    pip install -r requirements.txt


ARG PYVER=3.7

RUN \
  git clone https://github.com/coleifer/pysqlite3;  \
  cd pysqlite3; \
  cp /build/sqlite/sqlite3.[ch] .; \
  python setup.py build_static;\
  cp build/*/pysqlite3/_sqlite3.*so  /root/.pyenv/versions/$PYVERSION/lib/python${PYVER}/site-packages/


COPY bin/* /usr/local/bin/
