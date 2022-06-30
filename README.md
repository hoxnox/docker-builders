Building cross-compiler

docker build -t compiler-builder:base -f compiler-builder-base.Dockerfile .
docker run -v ".:/mnt" --rm -it --entrypoint /bin/bash compiler-builder:base
ln -s /mnt/compiler-builder-sources /src
ln -s /mnt /x-tools
mkdir ~/tmp && cd ~/tmp
cp /mnt/mips-pc-linux-musl.crosstool-ng .config
ct-ng build

Building qemu-static:

https://github.com/ziglang/qemu-static

Building builder

```
docker build -t builder:base -f base.Dockerfile .
for i in templates/*.tpl; do sed 's/${PROCESSOR}/mips/g' $i > mips/`basename $i`; done
sed 's/${PROCESSOR}/mips/g' templates/template.Dockerfile > mips/mips-pc-linux-musl.Dockerfile
docker build -t builder:mips -f mips-pc-linux-musl.Dockerfile .
cp templates/qemu-binfmt-${PROCESSOR} ${PROCESSOR}/
```

Check ~/.conan/settings.tml and verify architecture march in <arch>/conan.profile.tpl (arch variable)


There are troubles with i386 and m4 package. The first thing - linking with libatomic.a is
missing. Can be fixed by adding
LIBS=/opt/i386-pc-linux-musl/i386-pc-linux-musl/lib/libatomic.a to the profile. Another
thing - it uses wrong `host_canonical_name`.
