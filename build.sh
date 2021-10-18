docker build -t docker.acme.com/builder:base -f base.Dockerfile .
docker build -t docker.acme.com/builder:i386 -f i386-pc-linux-musl.Dockerfile .
