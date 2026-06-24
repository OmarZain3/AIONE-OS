# AIONE — Engineering automation targets
# Usage: make help

.DEFAULT_GOAL := help
SHELL := /bin/bash

PYTHON ?= python3
PRE_COMMIT ?= pre-commit
PRE_COMMIT_CONFIG ?= pre-commit-config.yaml
MARKDOWNLINT ?= markdownlint
RUFF ?= ruff

.PHONY: help install install-hooks lint format ci docs-lint flutter-analyze django-check adr-check clean-hooks

help: ## Show available targets
	@grep -E '^[a-zA-Z0-9_.-]+:.*##' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*## "}; {printf "  \033[36m%-18s\033[0m %s\n", $$1, $$2}'

install: install-hooks ## Install pre-commit hooks (commit + commit-msg)
	@echo "Pre-commit hooks installed."

install-hooks: ## Install pre-commit and commit-msg hooks only
	$(PRE_COMMIT) install -c $(PRE_COMMIT_CONFIG)
	$(PRE_COMMIT) install --hook-type commit-msg -c $(PRE_COMMIT_CONFIG)

lint: ## Run all linters (pre-commit)
	$(PRE_COMMIT) run --all-files -c $(PRE_COMMIT_CONFIG)

format: ## Auto-fix formatting where supported
	$(PRE_COMMIT) run --all-files -c $(PRE_COMMIT_CONFIG) trailing-whitespace --files $$(git ls-files)
	$(PRE_COMMIT) run --all-files -c $(PRE_COMMIT_CONFIG) end-of-file-fixer --files $$(git ls-files)
	$(PRE_COMMIT) run --all-files -c $(PRE_COMMIT_CONFIG) ruff --files $$(git ls-files 'services/**' 'packages/**' 'tests/**' 'scripts/**' 2>/dev/null || true)
	$(PRE_COMMIT) run --all-files -c $(PRE_COMMIT_CONFIG) ruff-format --files $$(git ls-files 'services/**' 'packages/**' 'tests/**' 'scripts/**' 2>/dev/null || true)
	$(PRE_COMMIT) run --all-files -c $(PRE_COMMIT_CONFIG) markdownlint --files $$(git ls-files '*.md' 2>/dev/null || true)

ci: lint docs-lint adr-check flutter-analyze django-check ## Run full local CI suite
	@echo "Local CI suite completed."

docs-lint: ## Lint Markdown documentation
	@if command -v $(MARKDOWNLINT) >/dev/null 2>&1; then \
		$(MARKDOWNLINT) "**/*.md" --ignore node_modules; \
	else \
		echo "markdownlint not found — run: npm install -g markdownlint-cli"; \
		$(PRE_COMMIT) run markdownlint --all-files -c $(PRE_COMMIT_CONFIG); \
	fi

adr-check: ## Validate ADR required sections
	@FAILED=0; \
	REQUIRED="Status Context Decision Alternatives Consequences Future Review"; \
	for adr in docs/adr/[0-9]*.md; do \
		[ -f "$$adr" ] || continue; \
		for section in $$REQUIRED; do \
			grep -q "^## $$section" "$$adr" || { echo "Missing ## $$section in $$adr"; FAILED=1; }; \
		done; \
	done; \
	exit $$FAILED

flutter-analyze: ## Run Flutter format and analyze on discovered projects
	@if ! command -v flutter >/dev/null 2>&1; then \
		echo "Flutter not installed — skipping"; \
		exit 0; \
	fi; \
	FOUND=0; FAILED=0; \
	while IFS= read -r dir; do \
		[ -z "$$dir" ] && continue; \
		FOUND=1; \
		echo "==> $$dir"; \
		(cd "$$dir" && flutter pub get >/dev/null && dart format --output=none --set-exit-if-changed . && flutter analyze --fatal-infos --fatal-warnings) || FAILED=1; \
	done < <(find apps packages -name pubspec.yaml -not -path "*/.*" 2>/dev/null | xargs -I{} dirname {} | sort -u); \
	if [ $$FOUND -eq 0 ]; then echo "No Flutter projects found — skipped"; fi; \
	exit $$FAILED

django-check: ## Run Ruff and Django system checks on discovered projects
	@FAILED=0; \
	if find services packages -name "*.py" -not -path "*/.*" 2>/dev/null | grep -q .; then \
		$(RUFF) check services packages tests scripts 2>/dev/null || FAILED=1; \
		$(RUFF) format --check services packages tests scripts 2>/dev/null || FAILED=1; \
	fi; \
	while IFS= read -r dir; do \
		[ -z "$$dir" ] && continue; \
		echo "==> $$dir"; \
		(cd "$$dir" && SECRET_KEY=make-ci DEBUG=false DATABASE_URL=sqlite:///tmp/make-ci.sqlite3 $(PYTHON) manage.py check) || FAILED=1; \
	done < <(find services packages -name manage.py -not -path "*/.*" 2>/dev/null | xargs -I{} dirname {} | sort -u); \
	exit $$FAILED

clean-hooks: ## Uninstall pre-commit hooks
	$(PRE_COMMIT) uninstall -c $(PRE_COMMIT_CONFIG)
	$(PRE_COMMIT) uninstall --hook-type commit-msg -c $(PRE_COMMIT_CONFIG)
