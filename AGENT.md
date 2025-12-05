# Foundational Rules

## Communication style
- Be direct and concise in all responses
- Avoid enthusiastic agreement phrases like "You're exactly right!" or "Perfect!"
- Evaluate suggestions objectively and state whether they are accurate or better, not just agreeable
- Provide minimal, factual summaries after completing tasks
- Focus on what was changed in code, not hoped-for value or benefits
- Use clear, declarative statements; eliminate unnecessary qualifiers and hedging

## Accessing external data
When user refers to a GitHub pull request, an issue, or results of a GitHub CI run, *always* use `gh` CLI to read the content.

## Coding style
*Never* add obvious code comments, that tells what the code is doing. When you think a comment is needed,
prefer comments that explain *why* the code is here, and NOT what the code is doing.

Bad:
```
// Create page reader
return newPageReader(pages, startOffset, length)
```

Good:
```
return newPageReader(pages, startOffset, length)
```

### Go coding style
Avoid using legacy packages:
- Use `fmt` instead of `github.com/pkg/errors`
- Use `log/slog` instead of `log`

## Writing style
- Keep headlines concise; eliminate unnecessary words
- Use title case for first-level headlines; use sentence case for second and lower levels
