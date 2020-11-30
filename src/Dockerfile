FROM jackfirth/racket:7.9-full

CMD cp -R /build/. "artifacts_dir/" \
    && echo "a" | /usr/bin/raco pkg install "artifacts_dir/" \
    && /usr/bin/raco exe /artifacts_dir/wrapper.rkt \
    && /usr/bin/raco distribute /artifacts_dir/distribute /artifacts_dir/wrapper \
    && rm /artifacts_dir/wrapper

