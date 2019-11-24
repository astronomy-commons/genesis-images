#
# TYPE and NAME must be defined by the including makefile
#

build:
	@ ../bin/build.sh $(TYPE) $(NAME) > .latest.tag
	@ echo "Built $$(cat .latest.tag); run 'make push' to push it up to the Docker registry"

push:
	@docker push $$(cat .latest.tag)
