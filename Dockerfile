FROM alpine AS verify

ENV ROOT_FOLDER=root.x86_64
ENV BUILT=arch

COPY gen_arch_files install_deps /

RUN apk add --no-cache bash curl tar zstd \
    && /gen_arch_files

RUN mkdir $BUILT \
    && cp -R  \
        $ROOT_FOLDER/var  \
        $ROOT_FOLDER/etc  \
        $ROOT_FOLDER/usr  \
        $ROOT_FOLDER/bin  \
        $ROOT_FOLDER/sbin  \
        $ROOT_FOLDER/lib \
        $ROOT_FOLDER/lib64  \
        /$BUILT

FROM scratch

ENV BUILT=arch

COPY --from=verify $BUILT /

CMD ["/bin/bash"]
