> Source: https://github.com/anthropics/skills

# Example Skills

Skills are folders of instructions, scripts, and resources that Claude loads dynamically to improve performance on specialized tasks. Skills teach Claude how to complete specific tasks in a repeatable way, whether that's creating documents with your company's brand guidelines, analyzing data using your organization's specific workflows, or automating personal tasks.

## About the Examples Repository

The [anthropics/skills](https://github.com/anthropics/skills) repository contains skills that demonstrate what's possible with Claude's skills system. These skills range from creative applications (art, music, design) to technical tasks (testing web apps, MCP server generation) to enterprise workflows (communications, branding, etc.).

Each skill is self-contained in its own folder with a `SKILL.md` file containing the instructions and metadata that Claude uses.

The repository also includes the document creation and editing skills that power Claude's document capabilities under the hood in the `skills/docx`, `skills/pdf`, `skills/pptx`, and `skills/xlsx` subfolders. These are source-available (not open source) but shared as a reference for more complex skills that are actively used in a production AI application.

**Disclaimer**: These skills are provided for demonstration and educational purposes only. Implementations and behaviors may differ from what is shown. Always test skills thoroughly in your own environment.

## Skill Sets

- **Skills**: Skill examples for Creative and Design, Development and Technical, Enterprise and Communication, and Document Skills
- **Spec**: The Agent Skills specification
- **Template**: Skill template for starting new skills

## Using Example Skills

### Claude Code

Register the repository as a Claude Code Plugin marketplace:

```
/plugin marketplace add anthropics/skills
```

Then install a specific set of skills:

1. Select `Browse and install plugins`
2. Select `anthropic-agent-skills`
3. Select `document-skills` or `example-skills`
4. Select `Install now`

Or directly install either Plugin:

```
/plugin install document-skills@anthropic-agent-skills
/plugin install example-skills@anthropic-agent-skills
```

After installing the plugin, use the skill by mentioning it. For instance: "Use the PDF skill to extract the form fields from `path/to/some-file.pdf`"

### Claude.ai

Example skills are already available to paid plans in Claude.ai.

To use any skill from the repository or upload custom skills, follow the instructions in [Using skills in Claude](https://support.claude.com/en/articles/12512180-using-skills-in-claude#h_a4222fa77b).

### Claude API

You can use Anthropic's pre-built skills and upload custom skills via the Claude API. See the [Skills API Quickstart](https://docs.claude.com/en/api/skills-guide#creating-a-skill) for more.

## Creating a Basic Skill

Skills are simple to create - just a folder with a `SKILL.md` file containing YAML frontmatter and instructions. Use the **template-skill** in the repository as a starting point:

```yaml
---
name: my-skill-name
description: A clear description of what this skill does and when to use it
---

# My Skill Name

[Add your instructions here that Claude will follow when this skill is active]

## Examples
- Example usage 1
- Example usage 2

## Guidelines
- Guideline 1
- Guideline 2
```

The frontmatter requires only two fields:

- `name` - A unique identifier for your skill (lowercase, hyphens for spaces)
- `description` - A complete description of what the skill does and when to use it

The markdown content below contains the instructions, examples, and guidelines that Claude will follow.

## Example Skill Structures

### Example 1: PDF Processing Skill

A complete example of a PDF processing skill:

```
pdf-processing/
├── SKILL.md
├── scripts/
│   ├── analyze_form.py
│   ├── fill_form.py
│   └── validate.py
└── references/
    ├── FORMS.md
    └── REFERENCE.md
```

**SKILL.md:**

````yaml
---
name: pdf-processing
description: Extract text and tables from PDF files, fill forms, merge documents. Use when working with PDF files or when the user mentions PDFs, forms, or document extraction.
---

# PDF Processing

## Quick start

Extract text with pdfplumber:
```python
import pdfplumber
with pdfplumber.open("file.pdf") as pdf:
    text = pdf.pages[0].extract_text()
```

## Form filling workflow

1. Analyze form: `python scripts/analyze_form.py input.pdf`
2. Edit fields.json with values
3. Validate: `python scripts/validate.py fields.json`
4. Fill form: `python scripts/fill_form.py input.pdf fields.json output.pdf`

## Advanced features

- **Form filling guide**: See [references/FORMS.md](references/FORMS.md)
- **API reference**: See [references/REFERENCE.md](references/REFERENCE.md)
````

### Example 2: Code Review Skill

A minimal skill for code review guidance:

```yaml
---
name: code-review
description: Perform thorough code reviews with consistent standards. Use when reviewing pull requests, analyzing code changes, or providing feedback on code quality.
---

# Code Review

## Process

1. Understand the context and purpose of the change
2. Check for correctness and potential bugs
3. Evaluate code organization and readability
4. Verify test coverage
5. Provide constructive feedback

## Review checklist

- [ ] Does the code do what it's supposed to do?
- [ ] Are there any obvious bugs or edge cases?
- [ ] Is the code readable and well-organized?
- [ ] Are there appropriate tests?
- [ ] Does it follow project conventions?

## Feedback style

- Be specific: Point to exact lines
- Be constructive: Suggest improvements, not just problems
- Be respectful: Assume good intent
- Prioritize: Distinguish blocking issues from suggestions
```

### Example 3: Data Analysis Skill

A skill with domain-specific reference files:

```
data-analysis/
├── SKILL.md
└── reference/
    ├── finance.md
    ├── sales.md
    └── product.md
```

**SKILL.md:**

````yaml
---
name: data-analysis
description: Analyze datasets, generate insights, and create visualizations. Use when working with data, spreadsheets, or when the user needs analytical insights.
---

# Data Analysis

## Quick start

```python
import pandas as pd

df = pd.read_csv("data.csv")
print(df.describe())
```

## Domain references

Select the appropriate reference based on the data domain:

- **Finance data**: See [reference/finance.md](reference/finance.md) for revenue, billing metrics
- **Sales data**: See [reference/sales.md](reference/sales.md) for pipeline, opportunities
- **Product data**: See [reference/product.md](reference/product.md) for usage analytics

## Common operations

### Summary statistics
```python
df.describe()
df.groupby('category').agg({'value': ['mean', 'sum', 'count']})
```

### Visualization
```python
import matplotlib.pyplot as plt
df.plot(kind='bar', x='category', y='value')
plt.savefig('chart.png')
```
````

### Example 4: Git Commit Helper

A focused skill for a specific task:

````yaml
---
name: git-commit-helper
description: Generate descriptive commit messages by analyzing git diffs. Use when the user asks for help writing commit messages or reviewing staged changes.
---

# Git Commit Helper

## Format

```
type(scope): brief description

Detailed explanation if needed
```

## Types

- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation
- `style`: Formatting (no code change)
- `refactor`: Code restructuring
- `test`: Adding tests
- `chore`: Maintenance

## Examples

**Input:** Added user authentication with JWT tokens
**Output:**
```
feat(auth): implement JWT-based authentication

Add login endpoint and token validation middleware
```

**Input:** Fixed bug where dates displayed incorrectly
**Output:**
```
fix(reports): correct date formatting in timezone conversion

Use UTC timestamps consistently across report generation
```

## Workflow

1. Run `git diff --staged` to see changes
2. Analyze the nature of the changes
3. Generate commit message following the format
4. Present for user review
````

## Partner Skills

Skills are a great way to teach Claude how to get better at using specific pieces of software. Notable partner skills include:

- **Notion** - [Notion Skills for Claude](https://www.notion.so/notiondevs/Notion-Skills-for-Claude-28da4445d27180c7af1df7d8615723d0)

## Key Patterns Demonstrated

1. **Progressive disclosure**: Main instructions in SKILL.md, details in reference files
2. **Clear structure**: Frontmatter -> Quick start -> Workflows -> References
3. **Concrete examples**: Input/output pairs, code snippets
4. **Checklists**: For multi-step processes
5. **Domain organization**: Separate files for different domains/topics

## Resources

- **Official examples**: https://github.com/anthropics/skills
- **Specification**: https://agentskills.io/specification
- **Best practices**: https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices
- **What are skills?**: https://support.claude.com/en/articles/12512176-what-are-skills
- **Using skills in Claude**: https://support.claude.com/en/articles/12512180-using-skills-in-claude
- **Creating custom skills**: https://support.claude.com/en/articles/12512198-creating-custom-skills
- **Blog post**: https://anthropic.com/engineering/equipping-agents-for-the-real-world-with-agent-skills
