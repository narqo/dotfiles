---
name: obsidian-notes
description: Manage notes in an Obsidian vault. Use when a user asks to create, update, read, or organize notes or knowledge base entries.
---

# Obsidian Notes

Manage markdown notes in an Obsidian vault in `$OBSIDIAN_VAULT_ROOT`.

To get the root directory:

```
echo -n "$OBSIDIAN_VAULT_ROOT"
```

If `$OBSIDIAN_VAULT_ROOT` variable is empty, stop and ask the user to set it up.

## Vault structure

The vault is organized by **org** (top-level directory). Notes live inside sub-directories or directly under an org directory.

```
$OBSIDIAN_VAULT_ROOT/
<vault>/
├── <org>/
│   ├── <Project>/
│   │   ├── note-1.md
│   │   └── note-2.md
│   └── Standalone note.md
```

When the user refers to a project by name, match it to an existing directory. If no match exists, confirm before creating a new one.

## Creating and updating notes

Every note **must** have YAML frontmatter with at these fields:

```yaml
---
title: Short title
repository: github.com/org/repo
commit: <sha>
created: YYYY-MM-DD
---
```

- `title`: concise name for the note
- `repository`: the source repository the note relates to (omit if not code-related)
- `commit`: the commit sha of the repository (omit if not code-related)
- `created`: date the note was first written, in `YYYY-MM-DD` format

Infer `repository` from `git remote get-url origin` in the current working directory when not specified.

### Formatting rules

1. **No fixed line width.** Write paragraphs as single unwrapped lines. Obsidian and any an editor will soft-wrap.
2. **Preserve code blocks and tables as-is.** Only prose paragraphs should be unwrapped. Fenced code blocks, ASCII diagrams, and tables keep their original formatting.
3. **Use standard Markdown.** Headings, lists, tables, fenced code blocks. No Obsidian-specific syntax (like `![[embeds]]`) unless the user asks for it.
4. **Prefer raw code blocks.** A fenced code block doesn't need to use language specifier. The language is obvious from the context.

### File naming

- Use lowercase kebab-case: `notes-block-builder.md`, `query-gap-analysis.md`.
- Prefix with a namespace when useful: `rpi4-`, `mimir-`.
- Prefix with a category when useful: `notes-`, `runbook-`, `debug-`.

## Workflow

### Creating new notes from scratch

When the user asks to write up findings, observations, or analysis:

1. Draft the note content following the formatting rules.
2. Ask for the target org/project if not obvious from context.
3. Write with frontmatter to the vault.

### Read existing note

1. Resolve the path to the note's files. The user may pass an Obsidian URI, structured as `obsidian://open?vault=default&file=Grafana%2FMimir%2Fdesign-doc-1`.
   This refers to the note `design-doc-1.md` in the `Grafana / Mimir` path inside the `default` vault in the $OBSIDIAN_VAULT_ROOT.
2. Read the note from the vault using the `read` tool.

### Updating existing notes

1. Read the existing note from the vault using the `read` tool.
2. Apply the requested changes.
3. Preserve the original `created` date. Do not change it.
4. Write the updated note back.
