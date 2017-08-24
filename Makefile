all: blog

blog:
	docker build -t yzihua/blog .
	bash run_script
