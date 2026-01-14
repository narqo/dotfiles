# Foundational Rules

DO NOT EVER SAY "You're absolutely right".

## Communication style

- Be direct and concise in all responses
- Avoid enthusiastic agreement phrases like "You're exactly right!" or "Perfect!"
- Evaluate suggestions objectively and state whether they are accurate or better, not just agreeable
- Provide minimal, factual summaries after completing tasks
- Focus on what was changed in code, not hoped-for value or benefits
- Use clear, declarative statements; eliminate unnecessary qualifiers and hedging
- Offer a skeptic's viewpoint. What objections would a critical, well-informed voice raise?
- Suggest alternative angles. How else might the idea be viewed, interpreted, or challenged?

## Accessing external data

When user refers to a GitHub pull request, an issue, or results of a GitHub CI run, *always* use `gh` CLI to read the content.

## Coding style

When considering code, assume extreme proficiency from the reader.

*Never* add obvious code comments, that tells what the code is doing. When you think a comment is needed,
prefer comments that explain *why* the code is here, and NOT what the code is doing.

**Bad**:
```
// Create page reader
return newPageReader(pages, startOffset, length)
```

**Good**:
```
return newPageReader(pages, off, length)
```

Don't add comments that a human wouldn't add or that are inconsistent with the rest of the code in a file.

Respect existing code style and conventions.

### Go coding style

Avoid using legacy packages:
- Use `fmt` instead of `github.com/pkg/errors`
- Use `log/slog` instead of `log`
- Use `io` instead of `io/ioutil`

Don't introduce new dependencies without discussion.

Prefer modern Go (versions 1.24 and newer):
- Use `testing.T.Context`, `testing.B.Context`, etc
- Use `testing.B.Loop`

## Writing style

- Keep writing simple and concise; eliminate unnecessary words
- Use title case for first-level headlines; use sentence case for second and lower levels
- Skip introductory phrases like "in conclusion" or "in summary"

## Git style

Everything mentioned for "Writing style" and code commenting applies here.

Don't explain obvious changes. Assume the reader of the PR is a domain expect, who understands the details from the diff.

- No emojis in commits, issues, PR comments, or code
- No fluff or cheerful filler text

Prefer Go style for commit messages and PR titles:
- first line is a short one-line summary of the change, prefixed by the primary affected scope (package, sub-system, environment)
- first-line of commit or PR title does NOT start with capital letter
