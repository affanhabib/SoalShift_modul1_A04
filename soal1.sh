#!/bin/bash
for f in ./nature/*;
	do
	hexdump -C "$f"
	base64 -d "$f" | xxd -r > ./nature/hasil/$(basename $f .jpg)_baru.jpg
	done
