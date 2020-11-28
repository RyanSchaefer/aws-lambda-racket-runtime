FROM jackfirth/racket:7.9-full

CMD cp -R /build/. "artifacts_dir/" \
    && echo "a" | /usr/bin/raco pkg install "artifacts_dir/" \
    && /usr/bin/raco exe /artifacts_dir/wrapper.rkt \
    && chmod +x /artifacts_dir/wrapper.rkt

