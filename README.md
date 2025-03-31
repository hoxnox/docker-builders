Building cross-compiler

docker build -t compiler-builder:base -f compiler-builder-base.Dockerfile .
docker run -v ".:/mnt" --rm -it --entrypoint /bin/bash compiler-builder:base
ln -s /mnt/compiler-builder-sources /src
ln -s /mnt /x-tools
mkdir ~/tmp && cd ~/tmp
cp /mnt/mips-pc-linux-musl.crosstool-ng .config
ct-ng menuconfig
ct-ng build
tar -czvf mips-pc-linux-musl.tar.gz mips-pc-linux-musl

Building qemu-static:

https://github.com/ziglang/qemu-static

Make qemu-binfmt script (use /etc/init.d/qemu-binfmt) and get static qemu-{arch}, copy
entrypoint.

Building builder

```
docker build -t builder_base:0.2.0 -f base.Dockerfile .
mkdir mips
cp mips-pc-linux-musl.tar.gz mips
for i in templates/*.tpl; do sed 's/|ARCH|/mips/g' $i > mips/`basename $i`; done
cp qemu-mips mips
cp qemu-binfmt mips
cp templates/entrypoint mips
sed 's/|ARCH|/mips/g' templates/template.Dockerfile > mips/mips-pc-linux-musl.Dockerfile
docker build -t builder-mips:0.2.0 -f mips-pc-linux-musl.Dockerfile .
cp templates/qemu-binfmt-|ARCH| |ARCH|/
```

Check ~/.conan/settings.tml and verify architecture march in <arch>/conan.profile.tpl (arch variable)


There are troubles with i386 and m4 package. The first thing - linking with libatomic.a is
missing. Can be fixed by adding
LIBS=/opt/i386-pc-linux-musl/i386-pc-linux-musl/lib/libatomic.a to the profile. Another
thing - it uses wrong `host_canonical_name`.
