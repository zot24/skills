# Fusion-opinion

We run this only when a spec names `when=fusion-opinion`.

Research / design / “what should we believe.” **Never** on a serial write ticket. **Never** on every dispatch.

## Pattern

```
same prompt file → 2–3 read-only opinion panes (names hidden) → share answers → one expensive architect converges
```

Opinion panes are **read-only**. They do not edit the product tree. Still **one writer** if anything later lands as code. Fusion-opinion itself does not write.

## When

The spec must say `when=fusion-opinion`. If it does not, do not start this loop.

Use it for: research, design, “what should we believe.”
Do not use it for: a serial write, a PR that already has one worker, five models on one ticket.

## How to run

1. Write **one prompt file** on disk. It names the question, the deliverable path, the marker, and the gates file.
2. Start **2–3 read-only opinion panes**. Entitled grok (or other entitled non-architect kinds). **Hide model names** in the brief: **rune / flux / drift** (or A/B/C). Same prompt file to all.
3. Land-check `working`. Marker + gates still required.
4. Share the answers (a bundle file, or a second round that names the other notes).
5. **Architect = adversary, kind claude, model opus.** That is the current expensive design seat. Do not invent a herdr kind named `architect`. Do not use the tower brain as the synthesizer.
6. The architect converges. One verdict. Grades VERIFIED / INFERRED / NOT DETERMINED.

## Do not

- Flip board-first (select kind ∩ pin) to “combine don’t select.”
- Run fusion on every dispatch.
- Scale to five models (`[17:13]` is the SKIP cue: we use 2–3, not 5).
- Drop skills.

## Source

indydevdan `rqZHR-hRllI` — https://www.youtube.com/watch?v=rqZHR-hRllI  
Captions are **auto-ASR**. Quotes are not verbatim.

| Cue | Clause (ASR) |
|---|---|
| `[05:02]` | “I want the opinion from all of my models, from all of my compute on one issue.” |
| `[10:05]` | rune / flux / drift — hide the model name so agents do not compete or sabotage |
| `[17:13]` | three models for simplicity; five-model “fusion 5” is **not** this skill |

STEAL we run: same prompt → N models; hide names; debate/converge; one expensive architect.  
SKIP: combine-don’t-select; five LLMs every ticket; drop skills.
