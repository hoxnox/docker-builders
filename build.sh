docker build -t builder:base -f base.Dockerfile .
docker build -t builder:i386 -f i386-pc-linux-musl.Dockerfile .
