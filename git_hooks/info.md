# Git Hooks Documentation

This document provides an overview of the Git hooks used in this project, their purposes, and how they function. Git hooks are custom scripts triggered by various Git events, and they help enforce workflows and automate repetitive tasks.

---

## Hook: `prepare-commit-msg`

### Purpose
The `prepare-commit-msg` hook is used to automatically prepend a commit message prefix based on the current branch name. This is particularly useful for ensuring consistent commit messages in projects where the branch name includes an identifier (e.g., `FECOM-x`).

### Workflow
When creating a new commit:
1. The hook extracts the prefix (e.g., `FECOM-x`) from the current branch name.
2. It prepends this prefix to the commit message if it's not already present.
3. This ensures all commit messages follow the required format without manual intervention.
