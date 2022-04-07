Building cross-compiler

docker build -t compiler-builder:base -f compiler-builder-base.Dockerfile .
docker run -v ".:/mnt" --rm -it --entrypoint /bin/bash compiler-builder:base
ln -s /mnt/compiler-builder-sources /src
ln -s /mnt /x-tools
mkdir ~/tmp && cd ~/tmp
cp /mnt/x86_64/x86_64-pc-linux-musl.crosstool-ng .config
ct-ng build

Building builder

docker build -t builder:base -f base.Dockerfile .
for i in templates/*.tpl; do sed 's/${PROCESSOR}/x86_64/g' $i > x86_64/`basename $i`; done
sed 's/${PROCESSOR}/x86_64/g' templates/template.Dockerfile > x86_64/x86_64-pc-linux-musl.Dockerfile
docker build -t builder:x86_64 -f x86_64-pc-linux-musl.Dockerfile .

Check ~/.conan/settings.tml and verify architecture march in <arch>/conan.profile.tpl (arch variable)
