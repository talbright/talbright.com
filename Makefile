AWS_CLI_PROFILE:=korebantic
S3_SITE_BUCKET:=aws-website-talbright-ac3r5

server:
	hugo server

build:
	hugo

sync-to-aws: build
	aws s3 --profile korebantic sync ./public s3://$(S3_SITE_BUCKET)

# requires: git submodule add -b master git@github.com:talbright/talbright.github.io.git public
sync-to-github: build
	cd public && \
	git add -A && \
	git commit -m "rebuilding site with hugo" && \
	git push origin master

sync: sync-to-github sync-to-aws

.PHONY: server build sync-to-aws sync-to-github
