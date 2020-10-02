.PHONY: inject-token

inject-token:
	echo "let qiitaAccessToken = \"${TOKEN}\"" > ./AiBC/Secrets.swift
